import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pu_connnection/models/message_model.dart';

import '../../../apis/message_api.dart';
import '../../../apis/storage_api.dart';
import '../../../apis/user_api.dart';
import '../../../models/user_models.dart';

final messageControllerProvider = StateNotifierProvider(
  (ref) {
    return ExploreControllerNotifier(
      userAPI: ref.watch(userAPIProvider),
      messageAPI: ref.watch(messageAPIProvider),
      storageAPI: ref.watch(storaegAPIProvider),
    );
  },
);

final searchUserProvider = FutureProvider.family((ref, String name) async {
  final exploreController = ref.watch(messageControllerProvider.notifier);
  return exploreController.searchUser(name);
});

final searchMessageGroupProvider =
    FutureProvider.family((ref, String currentUserId) async {
  final exploreController = ref.watch(messageControllerProvider.notifier);
  return exploreController.searchMessageGroup(currentUserId);
});

final searchMessagesProvider =
    FutureProvider.family((ref, List<String> Ids) async {
  final messages = ref.watch(messageControllerProvider.notifier);

  return messages.searchMessages(Ids);
});

final getLastMessageProvider = StreamProvider((ref) {
  final messageAPI = ref.watch(messageAPIProvider);
  return messageAPI.getLastMessage();
});

class ExploreControllerNotifier extends StateNotifier<bool> {
  final UserAPI _userAPI;
  final MessageAPI _messageAPI;
  final StorageAPI _storageAPI;
  ExploreControllerNotifier({
    required StorageAPI storageAPI,
    required UserAPI userAPI,
    required MessageAPI messageAPI,
  })  : _userAPI = userAPI,
        _messageAPI = messageAPI,
        _storageAPI = storageAPI,
        super(false);

  Future<List<UserModel>> searchUser(String name) async {
    final users = await _userAPI.searchUserInMessengerScreen(name);
    return users.map((e) => UserModel.fromMap(e.data)).toList();
  }

  Future<List<UserModel>> searchMessageGroup(String currentUserId) async {
    final users = await _messageAPI.searchMessageGroup(currentUserId);
    return users.map((e) => UserModel.fromMap(e.data)).toList();
  }

  Future<List<MessageModel>> searchMessages(List<String> membersIds) async {
    List<MessageModel> messageModels = [];
    try {
      final messages = await _messageAPI.searchMessages(membersIds);

      // Kiểm tra xem danh sách có phần tử hay không
      if (messages.isEmpty) {
        // print("Log cho Controller 1 ==> Danh sách tin nhắn trống");
        return []; // Hoặc có thể trả về danh sách mặc định nếu cần
      }

      messageModels =
          messages.map((e) => MessageModel.fromMap(e.data)).toList();

      // print("Log cho Controller 2 ==> $messageModels"); // Thanh cong
      return messageModels;
    } catch (e, stackTrace) {
      // Xử lý lỗi khi gọi searchMessages
      print("Error fetching messages: $e");
      print("Stack trace: $stackTrace");
      return []; // Hoặc có thể trả về một danh sách mặc định nếu cần
    }
  }

  Future<List<MessageModel>> createMessage(
      List<String> membersIds, String messageText, File messageFile) async {
    final messages = await _messageAPI.searchMessages(membersIds);
    return messages.map((e) => MessageModel.fromMap(e.data)).toList();
  }

  void sendMessage({
    required List<String> Ids,
    required String message,
    required List<File> files,
  }) async {
    List<String> filesUrl = await _storageAPI.uploadImage(files);
    await _messageAPI.createMessage(Ids, message, filesUrl);
  }
}
