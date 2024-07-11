import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/storage_api.dart';
import '../../../apis/tweet_api.dart';
import '../../../apis/user_api.dart';
import '../../../core/enums/notification_type_num.dart';
import '../../../models/tweet_model.dart';
import '../../../models/user_models.dart';
import '../../notification/controller/notification_controller.dart';

final UserProfileControllerProvider = StateNotifierProvider(
  (ref) {
    return UserProfileController(
      ref: ref,
      userAPI: ref.watch(userAPIProvider),
      tweetAPI: ref.watch(tweetAPIProvider),
      storageAPI: ref.watch(storaegAPIProvider),
      notificationController:
          ref.watch(notificationControllerProvider.notifier),
    );
  },
);

final getUserTweetsProvider = FutureProvider.family((ref, String uid) async {
  final userProfileController =
      ref.watch(UserProfileControllerProvider.notifier);
  return userProfileController.getUserTweets(uid);
});

class UserProfileController extends StateNotifier<bool> {
  final TweetAPI _tweetAPI;
  final UserAPI _userAPI;
  final StorageAPI _storageAPI;
  final NotificationController _notificationController;
  final Ref _ref;
  UserProfileController({
    required TweetAPI tweetAPI,
    required UserAPI userAPI,
    required StorageAPI storageAPI,
    required Ref ref,
    required NotificationController notificationController,
  })  : _ref = ref,
        _tweetAPI = tweetAPI,
        _userAPI = userAPI,
        _storageAPI = storageAPI,
        _notificationController = notificationController,
        super(false);
  Future<List<Tweet>> getUserTweets(String uid) async {
    final tweets = await _tweetAPI.getUserTweets(uid);
    return tweets.map((e) => Tweet.fromMap(e.data)).toList();
  }

  void updateUserProfile(
      {required UserModel userModel,
      required BuildContext context,
      required bannerFile,
      required profileFile}) {}

  void updateUserEducationId({
    required UserModel user,
  }) async {
    String educationId = user.educationId;

    user = user.copyWith(educationId: educationId);
    final res = await _userAPI.updateEducationId(user);
    res.fold(
        (l) => null,
        (r) => _notificationController.createNotification(
            text: "Education successfully updated",
            postId: "",
            notificationType: NotificationType.follow,
            uid: "66793bfc573379814a77"));
  }
}
