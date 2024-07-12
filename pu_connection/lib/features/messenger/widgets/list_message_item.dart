import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/error_page.dart';
import '../../../common/loading_page.dart';
import '../../../constants/assets_constants.dart';
import '../../../constants/text.dart';
import '../../../models/message_model.dart';
import '../../../theme/pallete.dart';
import '../../auth/controller/auth_controller.dart';
import '../../explore/widget/text_form_field_custom.dart';
import '../controller/message_controller.dart';
import 'message_card.dart';

class ListMessagesItem extends ConsumerStatefulWidget {
  const ListMessagesItem({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListMessagesItemState();
}

class _ListMessagesItemState extends ConsumerState<ListMessagesItem> {
  final searchMessageController = TextEditingController();
  bool isShowUsers = false;
  bool isImageVisible = true;

  int searchResultsCount = 0; // Initialize with 0 search results

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final currentUser = ref.watch(currentUserDetailsProvider);
    return switch (currentUser) {
      AsyncData(value: final currentUser?) ||
      AsyncLoading(value: final currentUser?) =>
        Scaffold(
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 140),
                  child: Consumer(
                    builder: (context, ref, child) {
                      // Access the searchUserProvider using ref.watch
                      AsyncValue<List<MessageModel>> searchUserAsyncValue =
                          ref.watch(searchMessagesProvider([
                        "6683c460753bb0154c54",
                        "66794da14cc66d80947a"
                      ]));

                      // Handle the different states of the provider
                      return searchUserAsyncValue.when(
                        data: (messages) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: searchResultsCount,
                                  itemBuilder: (context, index) {
                                    final message = messages[index];
                                    return SearchUserMessengerItem(
                                      userModel: currentUser,
                                      messageUser: message,
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                        loading: () {
                          // Render a loading indicator
                          return const Loader();
                        },
                        error: (error, stackTrace) {
                          // Handle the error
                          return ErrorText(
                            error: error.toString(),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      _ => const Loader()
    };
  }
}
