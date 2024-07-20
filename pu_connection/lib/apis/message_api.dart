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
  FutureEitherVoid createMessage(MessageModel message) async {
    try {
      await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.messengersCollection,
        documentId: ID.unique(),
        data: message.toMap(),
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
    List<Document> messages = [];
    try {
      final documents = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.messagesGroupCollection,
      );

      List<MessageGroupModel> messageGroups = documents.documents
          .map((e) => MessageGroupModel.fromMap(e.data))
          .toList();

      List<MessageGroupModel> filteredGroups = messageGroups
          .where(
              (group) => group.members.every((member) => Ids.contains(member)))
          .toList();

      if (filteredGroups.isEmpty) {
        MessageGroupModel messageGroup = MessageGroupModel(
          id: '',
          members: Ids,
          groupLeader: Ids.first,
          createdAt: DateTime.now().millisecondsSinceEpoch,
        );

        await _db.createDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.messagesGroupCollection,
          documentId: ID.unique(),
          data: messageGroup.toMap(),
        );
        return messages;
      }

      String firstGroupId = filteredGroups.first.id;

      final documentsMessage = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.messengersCollection,
        queries: [
          Query.equal('groupId', firstGroupId),
        ],
      );
      messages = documentsMessage.documents;
      print("LOG cho API ===> ${messages.length}");
      return messages;
    } catch (e) {
      print('Error fetching messages: $e');
      return messages;
    }
  }

  @override
  Stream<RealtimeMessage> getLastMessage() {
    return _realtime.subscribe([
      'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.messengersCollection}.documents'
    ]).stream;
  }
}
