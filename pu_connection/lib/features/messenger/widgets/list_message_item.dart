import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/error_page.dart';
import '../../../common/loading_page.dart';
import '../../../models/message_model.dart';
import '../../auth/controller/auth_controller.dart';
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

  // Create a variable to store search results
  List<MessageModel> searchResults = [];
  bool hasFetchedMessages = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final currentUser = ref.watch(currentUserDetailsProvider);

    // Ensure the API call and listening to the provider happen only once
    if (!hasFetchedMessages &&
        currentUser is AsyncData &&
        currentUser.value != null) {
      ref.listen<AsyncValue<List<MessageModel>>>(
        searchMessagesProvider(
            ["6683c460753bb0154c54", "66794da14cc66d80947a"]),
        (previous, next) {
          next.when(
            data: (messages) {
              setState(() {
                searchResults = messages;
                searchResultsCount = messages.length;
                hasFetchedMessages =
                    true; // Set the flag to true after fetching
              });
            },
            loading: () {},
            error: (error, stackTrace) {
              // Handle error if needed
            },
          );
        },
      );
    }

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: searchResultsCount,
                          itemBuilder: (context, index) {
                            final message = searchResults[index];
                            return SearchUserMessengerItem(
                              userModel: currentUser,
                              messageUser: message,
                            );
                          },
                        ),
                      ),
                    ],
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
