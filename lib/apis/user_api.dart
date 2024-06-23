// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../constants/appwrite_constant.dart';
import '../core/core.dart';
import '../core/providers.dart';
import '../core/type_defs.dart';
import '../models/user_models.dart';

final userAPIProvider = Provider((ref) {
  return UserAPI(db: ref.watch(appwriteDatabaseProvider));
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
  Future<Document> getUserData(String uid);
  Future<List<Document>> searchUserByName(String name);
}

class UserAPI implements IUserAPI {
  final Databases _db;
  UserAPI({
    required Databases db,
  }) : _db = db;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      print("Saving user data: ${userModel.toMap()}");
      await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollection,
        documentId: userModel.uid,
        data: userModel.toMap(),
      );
      print("User data saved successfully");
      return right(null);
    } on AppwriteException catch (e, st) {
      print("AppwriteException: ${e.message}");
      return left(Failure(
        e.message ?? "Unknown error",
        st,
      ));
    } catch (e, st) {
      print("Exception: $e");
      return left(
        Failure(
          e.toString(),
          st,
        ),
      );
    }
  }

  @override
  Future<Document> getUserData(String uid) async {
    try {
      print("Getting user data for uid: $uid");
      final document = await _db.getDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollection,
        documentId: uid,
      );
      print("User data retrieved: ${document.data}");
      return document;
    } on AppwriteException catch (e, st) {
      print("AppwriteException: ${e.message}");
      rethrow;
    } catch (e) {
      print("Exception: $e");
      rethrow;
    }
  }

  @override
  Future<List<Document>> searchUserByName(String name) async {
    try {
      print("Searching user by name: $name");
      final documents = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollection,
        queries: [
          Query.contains('name', name),
        ],
      );
      print(
          "Search results: ${documents.documents.map((doc) => doc.data).toList()}");
      return documents.documents;
    } on AppwriteException catch (e, st) {
      print("AppwriteException: ${e.message}");
      rethrow;
    } catch (e) {
      print("Exception: $e");
      rethrow;
    }
  }
}
