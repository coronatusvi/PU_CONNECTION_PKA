import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/tweet_model.dart';
import '../views/twitter_reply_view.dart';
import 'tweet_card.dart';

class TweetList extends ConsumerWidget {
  const TweetList({
    super.key,
    required this.tweets,
  });

  final List<Tweet> tweets;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: tweets.length,
      itemBuilder: (BuildContext context, int index) {
        final tweet = tweets[index];
        return TweetCard(
          tweet: tweet,
          changeOnTap: () {
            Navigator.push(
              context,
              TwitterReplyScreen.route(tweet),
            );
          },
        );
      },
    );
  }
}
