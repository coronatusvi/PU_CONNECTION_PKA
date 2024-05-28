import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phenikaa_campus/apis/tweet_api.dart';
import 'package:phenikaa_campus/models/tweet_model.dart';
import 'package:phenikaa_campus/models/user_models.dart';

final UserProfileControllerProvider = StateNotifierProvider(
  (ref) {
    return UserProfileController(
      tweetAPI: ref.watch(tweetAPIProvider),
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
  UserProfileController({
    required TweetAPI tweetAPI,
  })  : _tweetAPI = tweetAPI,
        super(false);
  Future<List<Tweet>> getUserTweets(String uid) async {
    final tweets = await _tweetAPI.getUserTweets(uid);
    return tweets.map((e) => Tweet.fromMap(e.data)).toList();
  }

  void updateUserProfile({required UserModel userModel, required BuildContext context, required bannerFile, required profileFile}) {}
}
