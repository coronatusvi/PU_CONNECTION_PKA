import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phenikaa_campus/constants/constants.dart';
import 'package:phenikaa_campus/features/explore/widget/text_form_field_custom.dart';
import 'package:phenikaa_campus/features/notification/view/notification_view.dart';
import 'package:phenikaa_campus/features/tweet/views/create_tweet_view.dart';
import 'package:phenikaa_campus/features/tweet/widgets/tweet_list.dart';
import 'package:phenikaa_campus/theme/pallete.dart';

class NotificationsList extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const NotificationsList(),
      );
  const NotificationsList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationsListState();
}

class _NotificationsListState extends ConsumerState<NotificationsList> {
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
                margin: EdgeInsets.symmetric(),
                width: size.width,
                height: size.height * 0.8,
                decoration: BoxDecoration(
                  color: Pallete.rhinoDark700,
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
                  gradient: Pallete.cardColor,
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
            ),
            Positioned.fill(
              top: size.height * 0.068,
              child: const Align(
                alignment: Alignment.topCenter,
                child: Text('Notifications'),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
              ),
              margin: EdgeInsets.only(
                top: size.height * 0.13,
                left: 10,
                right: 10,
              ),
              child: NotificationView(),
            )
          ],
        ),
      ),
    );
  }
}
