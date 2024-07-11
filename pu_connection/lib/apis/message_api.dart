import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pu_connnection/models/message_group_model.dart';

import '../constants/appwrite_constant.dart';
import '../core/core.dart';
import '../core/providers.dart';
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
  Stream<RealtimeMessage> getLatestMessage();
  Future<List<Document>> getMessageGroup(String currentUserId);
  Future<List<Document>> getMessages(String groupId);
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
  Future<List<Document>> getMessageGroup(String currentUserId) async {
    try {
      final documents = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.notificationsCollection,
        queries: [
          Query.equal('members', currentUserId),
        ],
      );

      for (var doc in documents.documents) {
        List<String> members = List<String>.from(doc.data['members']);
        members.remove(currentUserId);
        print(members);
      }

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
  Future<List<Document>> getMessages(String uid) async {
    try {
      final documents = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.notificationsCollection,
        queries: [
          Query.equal('uid', uid),
        ],
      );
      return documents.documents;
    } catch (e) {
      print('Error fetching messages: $e');
      return [];
    }
  }

  @override
  Stream<RealtimeMessage> getLatestMessage() {
    return _realtime.subscribe([
      'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.notificationsCollection}.documents'
    ]).stream;
  }
}
