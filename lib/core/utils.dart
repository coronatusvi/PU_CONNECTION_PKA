import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_android/image_picker_android.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
  ));
}

String getNameFromEmail(String email) {
//  hung@gmail.com
//List = [hung, @gmail.com]
  return email.split('@')[0];
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  final ImagePicker picker = ImagePicker();
  final imageFiles = await picker.pickMultiImage();
  if (imageFiles.isNotEmpty) {
    for (final image in imageFiles) {
      images.add(File(image.path));
    }
  }
  return images;
}

Future<List<File>> pickImageOrImages() async {
  List<File> images = [];
  final ImagePickerPlatform picker = ImagePickerAndroid();
  // ignore: deprecated_member_use
  final pickedFiles = await picker.pickMultiImage();

  if (pickedFiles != null && pickedFiles.isNotEmpty) {
    // Nếu đã chọn nhiều ảnh, thêm vào danh sách

    images = pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
  } else {
    // Nếu chọn 1 ảnh hoặc không chọn ảnh, lấy ảnh đơn
    // ignore: deprecated_member_use
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      images = [File(pickedFile.path)];
    }
  }
  return images;
}

// Future<File?> pickImage() async {
//   final ImagePicker picker = ImagePicker();
//   final imageFile = await picker.pickImage(source: ImageSource.gallery);
//   if (imageFile != null) {
//     return File(imageFile.path);
//   }
//   return null;
// }