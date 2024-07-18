import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pu_connnection/models/message_model.dart';

import '../../../apis/message_api.dart';
import '../../../apis/user_api.dart';
import '../../../models/user_models.dart';

final messageControllerProvider = StateNotifierProvider(
  (ref) {
    return ExploreControllerNotifier(
      userAPI: ref.watch(userAPIProvider),
      messageAPI: ref.watch(messageAPIProvider),
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
  final exploreController = ref.watch(messageControllerProvider.notifier);
  return exploreController.searchMessages(Ids);
});

final getLastMessageProvider = StreamProvider((ref) {
  final messageAPI = ref.watch(messageAPIProvider);
  return messageAPI.getLastMessage();
});

class ExploreControllerNotifier extends StateNotifier<bool> {
  final UserAPI _userAPI;
  final MessageAPI _messageAPI;
  ExploreControllerNotifier({
    required UserAPI userAPI,
    required MessageAPI messageAPI,
  })  : _userAPI = userAPI,
        _messageAPI = messageAPI,
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
    final messages = await _messageAPI.searchMessages(membersIds);
    return messages.map((e) => MessageModel.fromMap(e.data)).toList();
  }

  Future<List<MessageModel>> createMessage(List<String> membersIds, String messageText, File messageFile) async {
    final messages = await _messageAPI.searchMessages(membersIds);
    return messages.map((e) => MessageModel.fromMap(e.data)).toList();
  }
}
