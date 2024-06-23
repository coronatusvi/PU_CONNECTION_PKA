import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../constants/appwrite_constant.dart';
import '../core/core.dart';
import '../core/providers.dart';
import '../models/notification_model.dart';

final notificationAPIProvider = Provider((ref) {
  return NotificationAPI(
    db: ref.watch(appwriteDatabaseProvider),
    realtime: ref.watch(appwriteRealtimeProvider),
  );
});

abstract class INotificationAPI {
  FutureEitherVoid createNotification(Notification notification);
  Future<List<Document>> getNotifications(String uid);
  Stream<RealtimeMessage> getLatestNotification();
}

class NotificationAPI implements INotificationAPI {
  final Databases _db;
  final Realtime _realtime;
  NotificationAPI({required Databases db, required Realtime realtime})
      : _realtime = realtime,
        _db = db;

  @override
  FutureEitherVoid createNotification(Notification notification) async {
    try {
      final result = await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.notificationsCollection,
        documentId: ID.unique(),
        data: notification.toMap(),
      );
      print("Create Notification Success ==> ${result.toMap()}");
      return right(null);
    } on AppwriteException catch (e, st) {
      print(
          "Create Notification AppwriteException ==> ${e.message}, StackTrace: $st");
      return left(Failure(e.message ?? 'Some unexpected error occurred', st));
    } catch (e, st) {
      print("Create Notification Error ==> $e, StackTrace: $st");
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Future<List<Document>> getNotifications(String uid) async {
    try {
      final documents = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.notificationsCollection,
        queries: [Query.equal('uid', uid)],
      );
      print("Get Notifications Success ==> ${documents.documents}");
      return documents.documents;
    } on AppwriteException catch (e, st) {
      print(
          "Get Notifications AppwriteException ==> ${e.message}, StackTrace: $st");
      return [];
    } catch (e, st) {
      print("Get Notifications Error ==> $e, StackTrace: $st");
      return [];
    }
  }

  @override
  Stream<RealtimeMessage> getLatestNotification() {
    try {
      final stream = _realtime.subscribe([
        'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.notificationsCollection}.documents'
      ]).stream;
      print("Subscribed to Realtime Notifications");
      return stream;
    } catch (e) {
      print("Subscribe to Realtime Notifications Error ==> $e");
      // Handle error appropriately here, possibly returning an empty stream
      return Stream.error(e);
    }
  }
}
