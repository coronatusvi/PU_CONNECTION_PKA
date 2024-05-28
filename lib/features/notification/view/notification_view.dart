import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phenikaa_campus/theme/pallete.dart';

import '../../../common/error_page.dart';
import '../../../common/loading_page.dart';
import '../../../constants/appwrite_constant.dart';
import '../../../models/notification_model.dart' as model;
import '../../auth/controller/auth_controller.dart';
import '../controller/notification_controller.dart';
import '../widget/notification_tile.dart';

class NotificationView extends ConsumerWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;

    return Scaffold(
      backgroundColor: Pallete.noColor,
      body: currentUser == null
          ? const Loader()
          : ref.watch(getNotificationsProvider(currentUser.uid)).when(
                data: (notifications) {
                  return ref.watch(getLatestNotificationProvider).when(
                        data: (data) {
                          if (data.events.contains(
                            'databases.*.collections.${AppwriteConstants.notificationsCollection}.documents.*.create',
                          )) {
                            final latestNotif =
                                model.Notification.fromMap(data.payload);
                            if (latestNotif.uid == currentUser.uid) {
                              notifications.insert(0, latestNotif);
                            }
                          }

                          return ListView.builder(
                            itemCount: notifications.length,
                            itemBuilder: (BuildContext context, int index) {
                              final notification = notifications[index];
                              return NotificationTile(
                                notification: notification,
                              );
                            },
                          );
                        },
                        error: (error, stackTrace) => ErrorText(
                          error: error.toString(),
                        ),
                        loading: () {
                          return ListView.builder(
                            itemCount: notifications.length,
                            itemBuilder: (BuildContext context, int index) {
                              final notification = notifications[index];
                              return NotificationTile(
                                notification: notification,
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
              ),
    );
  }
}
