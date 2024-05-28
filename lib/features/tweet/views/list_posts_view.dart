import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phenikaa_campus/common/error_page.dart';
import 'package:phenikaa_campus/common/loading_page.dart';
import 'package:phenikaa_campus/features/tweet/controller/tweet_controller.dart';
import 'package:phenikaa_campus/features/tweet/views/create_tweet_view.dart';
import 'package:phenikaa_campus/features/tweet/widgets/tweet_list.dart';
import 'package:phenikaa_campus/theme/pallete.dart';

class NewPostsList extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const NewPostsList(),
      );
  const NewPostsList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewPostsListState();
}

class _NewPostsListState extends ConsumerState<NewPostsList> {
  void onCreateTweet() {
    Navigator.push(context, CreateTweetScreen.route());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Pallete.blackColor,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            // Layer 1: Background Image
            Positioned(
              top: 0,
              child: Container(
                margin: const EdgeInsets.symmetric(),
                width: size.width,
                height: size.height * 0.8,
                decoration: BoxDecoration(
                  gradient: Pallete.cardColor,
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
            ),
            Positioned(
              top: 100,
              child: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  color: Pallete.rhinoDark700,
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: onCreateTweet,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: size.height * 0.035, horizontal: 60),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Pallete.rhinoDark700,
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.create),
                        Text("How are you today?"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
              ),
              margin: EdgeInsets.only(
                top: size.height * 0.13 + 15,
                left: 10,
                right: 10,
              ),
              child: Consumer(
                builder: (context, ref, child) {
                  final tweets = ref.watch(getTweetsProvider);
                  ref.listen(
                    getLatestTweetProvider,
                    (previous, next) {
                      return switch (next) {
                        AsyncData() => ref.invalidate(getTweetsProvider),
                        _ => () {},
                      };
                    },
                  );

                  return switch (tweets) {
                    AsyncData(:final value) => RefreshIndicator(
                      onRefresh: () async => ref.invalidate(getTweetsProvider),
                      child: TweetList(tweets: value),
                    ),
                    AsyncError(:final error) => ErrorText(
                        error: error.toString(),
                      ),
                    AsyncLoading() => const Loader(),
                    _ => const SizedBox(),
                  };
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
