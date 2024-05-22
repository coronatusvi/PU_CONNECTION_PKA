// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:phenikaa_campus/constants/appwrite_constant.dart';
import 'package:phenikaa_campus/core/core.dart';
import 'package:phenikaa_campus/core/providers.dart';
import 'package:phenikaa_campus/models/user_models.dart';

final userAPIProvider = Provider((ref) {
  return UserAPI(db: ref.watch(appwriteDatabaseProvider));
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
  Future<model.Document> getUserData(String uid);
}

class UserAPI implements IUserAPI {
  final Databases _db;
  UserAPI({
    required Databases db,
  }) : _db = db;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.userCollection,
        documentId: userModel.uid,
        data: userModel.toMap(),
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(
        e.message ?? "Unknown error",
        st,
      ));
    } catch (e, st) {
      return left(
        Failure(
          e.toString(),
          st,
        ),
      );
    }
  }

  @override
  Future<model.Document> getUserData(String uid) {
    return _db.getDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.userCollection,
      documentId: uid,
    );
  } 
}
