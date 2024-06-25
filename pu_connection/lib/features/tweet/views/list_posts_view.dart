import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/error_page.dart';
import '../../../common/loading_page.dart';
import '../../../constants/assets_constants.dart';
import '../../../theme/pallete.dart';
import '../../notification/view/list_noti_view.dart';
import '../controller/tweet_controller.dart';
import '../widgets/tweet_list.dart';
import 'create_tweet_view.dart';

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

  void onNotificationScreen() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return NotificationsList(); // Đảm bảo NotificationsList phù hợp để hiển thị như một bottom sheet
      },
      isScrollControlled:
          true, // Cho phép bottom sheet chiếm toàn bộ màn hình nếu cần
    );
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
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Adjust alignment if necessary
              children: [
                Expanded(
                  // Wrap with Expanded if space allows
                  child: GestureDetector(
                    onTap: onCreateTweet,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: size.height * 0.035,
                          horizontal: 20), // Adjusted horizontal margin
                      padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15), // Adjusted horizontal padding
                      decoration: BoxDecoration(
                        color: Pallete.rhinoDark700,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.create),
                          SizedBox(width: 10),
                          Text("How are you today?"),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onNotificationScreen,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: size.height * 0.035,
                        horizontal: 20), // Adjusted horizontal margin
                    decoration: BoxDecoration(
                      color: Pallete.rhinoDark700,
                      shape: BoxShape.circle,
                    ),
                    // The container size is implicitly defined by the padding and the icon size.
                    child: Padding(
                      padding: const EdgeInsets.all(
                          7), // Increase padding to make the icon appear smaller.
                      child: SvgPicture.asset(
                        AssetsConstants.notifOutlinedIcon,
                        color: Pallete.yellow500,
                        // The icon size is reduced, but the overall widget size remains the same due to increased padding.
                        width: 27, // Reduced icon width
                        height: 27, // Reduced icon height
                      ),
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
                        onRefresh: () async =>
                            ref.invalidate(getTweetsProvider),
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
