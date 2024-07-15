import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/error_page.dart';
import '../../../common/loading_page.dart';
import '../../../models/user_models.dart';
import '../../../theme/pallete.dart';
import '../../auth/controller/auth_controller.dart';
import '../controller/message_controller.dart';
import 'tweet_list.dart';

class ListMessagesItem extends ConsumerStatefulWidget {
  static route(UserModel userModel) => MaterialPageRoute(
        builder: (context) => ListMessagesItem(userModel: userModel),
      );

  final UserModel userModel;

  const ListMessagesItem({super.key, required this.userModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListMessagesItemState();
}

class _ListMessagesItemState extends ConsumerState<ListMessagesItem> {
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
              ),
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Consumer(
                builder: (context, ref, child) {
                  final currentUserId =
                      ref.watch(currentUserDetailsProvider).value?.uid;

                  if (currentUserId == null) {
                    return const Loader();
                  }

                  final messages = ref.watch(searchMessagesProvider(
                      [widget.userModel.uid, currentUserId]));

                  ref.listen(
                    getLastMessageProvider,
                    (previous, next) {
                      return switch (next) {
                        AsyncData() => ref.invalidate(getLastMessageProvider),
                        _ => () {},
                      };
                    },
                  );

                  return switch (messages) {
                    AsyncData(:final value) => RefreshIndicator(
                        onRefresh: () async =>
                            ref.invalidate(searchMessagesProvider),
                        child: MessageList(messages: value),
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
