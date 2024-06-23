import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/error_page.dart';
import '../../../common/loading_page.dart';
import '../../../constants/assets_constants.dart';
import '../../../core/enums/notification_type_num.dart';
import '../../../models/notification_model.dart' as model;
import '../../../theme/pallete.dart';
import '../../tweet/controller/tweet_controller.dart';

class NotificationTile extends ConsumerWidget {
  final model.Notification notification;
  const NotificationTile({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getTweetsProvider).when(
          data: (tweets) {
            return ListTile(
              leading: notification.notificationType == NotificationType.follow
                  ? const Icon(
                      Icons.person,
                      color: Pallete.blueColor,
                    )
                  : notification.notificationType == NotificationType.like
                      ? SvgPicture.asset(
                          AssetsConstants.likeFilledIcon,
                          color: Pallete.redColor,
                          height: 20,
                        )
                      : notification.notificationType ==
                              NotificationType.retweet
                          ? SvgPicture.asset(
                              AssetsConstants.retweetIcon,
                              color: Pallete.blackColor,
                              height: 20,
                            )
                          : null,
              title: Text(
                notification.text.length <= 50
                    ? "Ai đó đã bày tỏ cảm xúc về bài viết ${notification.text}"
                    : "Ai đó đã bày tỏ cảm xúc về bài viết ${notification.text.substring(0, 25)}...",
                style: TextStyle(color: Pallete.blackColor),
              ),
            );
          },
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
