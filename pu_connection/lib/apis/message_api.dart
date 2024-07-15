import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../constants/appwrite_constant.dart';
import '../core/core.dart';
import '../core/providers.dart';
import '../models/message_group_model.dart';
import '../models/message_model.dart';

final messageAPIProvider = Provider((ref) {
  return MessageAPI(
    db: ref.watch(appwriteDatabaseProvider),
    realtime: ref.watch(appwriteRealtimeProvider),
  );
});

abstract class IMessageAPI {
  FutureEitherVoid createMessage(MessageModel message);
  FutureEitherVoid createMessageGroup(MessageGroupModel messageGroup);
  Future<List<Document>> searchMessageGroup(String currentUserId);
  Future<List<Document>> searchMessages(List<String> Ids);
  Stream<RealtimeMessage> getLastMessage();
}

class MessageAPI implements IMessageAPI {
  final Databases _db;
  final Realtime _realtime;
  MessageAPI({required Databases db, required Realtime realtime})
      : _realtime = realtime,
        _db = db;

  @override
  FutureEitherVoid createMessageGroup(MessageGroupModel messageGroup) async {
    try {
      await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.messagesGroupCollection,
        documentId: ID.unique(),
        data: messageGroup.toMap(),
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(
          e.message ?? 'Some unexpected error occurred',
          st,
        ),
      );
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Future<List<Document>> searchMessageGroup(String currentUserId) async {
    try {
      final documents = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollection,
      );

      // for (var doc in documents.documents) {
      //   List<String> members = List<String>.from(doc.data['members']);
      //   members.remove(currentUserId);
      //   print(members);
      // }

      return documents.documents;
    } catch (e) {
      print('Error fetching messages: $e');
      return [];
    }
  }

  @override
  FutureEitherVoid createMessage(MessageModel notification) async {
    try {
      await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.notificationsCollection,
        documentId: ID.unique(),
        data: notification.toMap(),
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(
          e.message ?? 'Some unexpected error occurred',
          st,
        ),
      );
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Future<List<Document>> searchMessages(List<String> Ids) async {
    try {
      List<Document> messages = [];
      final documents = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.messagesGroupCollection,
      );

      List<MessageGroupModel> messageGroups = documents.documents
          .map((e) => MessageGroupModel.fromMap(e.data))
          .toList();
      print(messageGroups);

      // Filter message groups that contain any of the ids in their members
      List<MessageGroupModel> filteredGroups = messageGroups
          .where(
              (group) => group.members.every((member) => Ids.contains(member)))
          .toList();

      if (filteredGroups.isEmpty) {
        return messages;
      }

      // Get the first groupId from the filtered list
      String firstGroupId = filteredGroups.first.groupId;

      // Check if Ids contains members other than in the first group's members
      bool containsOtherMembers =
          filteredGroups.first.members.any((member) => !Ids.contains(member));

      if (containsOtherMembers) {
        // Return an empty list if there are members other than Ids
        return messages;
      }

      final documentsMessage = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.messengersCollection,
        queries: [
          Query.orderDesc("timestamp"),
          Query.equal('groupId', firstGroupId),
        ],
      );

      return documentsMessage.documents;
    } catch (e) {
      print('Error fetching messages: $e');
      return [];
    }
  }

  @override
  Stream<RealtimeMessage> getLastMessage() {
    return _realtime.subscribe([
      'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.messengersCollection}.documents'
    ]).stream;
  }
}
