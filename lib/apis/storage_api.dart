import 'dart:io';
import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phenikaa_campus/constants/appwrite_constant.dart';
import 'package:phenikaa_campus/core/providers.dart';

final storaegAPIProvider = Provider((ref) {
  return StorageAPI(storage: ref.watch(appwriteStorageProvider));
});

class StorageAPI {
  final Storage _storage;
  StorageAPI({required Storage storage}) : _storage = storage;

  Future<List<String>> uploadImage(List<File> files) async {
    List<String> imageLinks = [];
    for (final file in files) {
      final uploadImage = await _storage.createFile(
        bucketId: AppwriteConstants.imagesBucket,
        fileId: ID.unique(),
        // ignore: deprecated_member_use
        file: InputFile(path: file.path),
      );
      imageLinks.add(AppwriteConstants.imageUrl(uploadImage.$id));
    }
    return imageLinks;
  }
}
