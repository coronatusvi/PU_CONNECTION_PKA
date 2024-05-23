import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phenikaa_campus/features/explore/widget/text_form_field_custom.dart';
import 'package:phenikaa_campus/features/tweet/views/twitter_reply_view.dart';
import 'package:phenikaa_campus/theme/pallete.dart';

import '../../../common/error_page.dart';
import '../../../common/loading_page.dart';
import '../../../constants/appwrite_constant.dart';
import '../../../models/tweet_model.dart';
import '../controller/tweet_controller.dart';
import 'tweet_card.dart';

class TweetList extends ConsumerWidget {
  const TweetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;

    return ref.watch(getTweetsProvider).when(
          data: (tweets) {
            return ref.watch(getLatestTweetProvider).when(
                  data: (data) {
                    if (data.events.contains(
                      'databases.*.collections.${AppwriteConstants.tweetsCollection}.documents.*.create',
                    )) {
                      tweets.insert(0, Tweet.fromMap(data.payload));
                    } else if (data.events.contains(
                      'databases.*.collections.${AppwriteConstants.tweetsCollection}.documents.*.update',
                    )) {
                      // get id of original tweet
                      final startingPoint =
                          data.events[0].lastIndexOf('documents.');
                      final endPoint = data.events[0].lastIndexOf('.update');
                      final tweetId = data.events[0]
                          .substring(startingPoint + 10, endPoint);

                      var tweet = tweets
                          .where((element) => element.id == tweetId)
                          .first;

                      final tweetIndex = tweets.indexOf(tweet);
                      tweets.removeWhere((element) => element.id == tweetId);

                      tweet = Tweet.fromMap(data.payload);
                      tweets.insert(tweetIndex, tweet);
                    }

                    return Column(
                      children: [
                        // Phần tử con tĩnh 2
                        Container(
                          margin: EdgeInsets.symmetric(
                              // horizontal: 10.0,
                              ),
                          width: size.width,
                          height: size.height * 0.8,
                          decoration: BoxDecoration(
                            gradient: Pallete.cardColor,
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                        // Phần tử con tĩnh 3
                        Positioned.fill(
                          top: size.height * 0.068,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text('Search'),
                          ),
                        ),
                        // ListView.builder
                        Expanded(
                          child: ListView.builder(
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
                          ),
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) => ErrorText(
                    error: error.toString(),
                  ),
                  loading: () {
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
                  },
                );
          },
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
