import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/user_api.dart';
import '../../../models/user_models.dart';

final exploreControllerProvider = StateNotifierProvider(
  (ref) {
    return ExploreControllerNotifier(
      userAPI: ref.watch(userAPIProvider),
    );
  },
);

final searchUserProvider = FutureProvider.family((ref, String name) async {
  final exploreController = ref.watch(exploreControllerProvider.notifier);
  return exploreController.searchUser(name);
});

class ExploreControllerNotifier extends StateNotifier<bool> {
  final UserAPI _userAPI;
  ExploreControllerNotifier({
    required UserAPI userAPI,
  })  : _userAPI = userAPI,
        super(false);
  Future<List<UserModel>> searchUser(String name) async {
    final users = await _userAPI.searchUserByName(name);
    return users.map((e) => UserModel.fromMap(e.data)).toList();
  }
}
