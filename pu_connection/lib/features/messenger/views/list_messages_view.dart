import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/error_page.dart';
import '../../../common/loading_page.dart';
import '../../../constants/assets_constants.dart';
import '../../../models/user_models.dart';
import '../../../theme/pallete.dart';
import '../../auth/controller/auth_controller.dart';
import '../controller/message_controller.dart';
import '../widgets/search_user_messenger.dart';

class ListMessagesView extends ConsumerStatefulWidget {
  const ListMessagesView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListMessagesViewState();
}

class _ListMessagesViewState extends ConsumerState<ListMessagesView> {
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
                // Layer 1: Background Image
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(AssetsConstants.darkBlur),
                ),
                Positioned(
                  top: 50.0,
                  child: Container(
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
                ),

                Positioned(
                  top: 70.0,
                  child: Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Pallete.rhinoDark700,
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 75),
                  child: Consumer(
                    builder: (context, ref, child) {
                      // Access the searchUserProvider using ref.watch
                      AsyncValue<List<UserModel>> searchUserAsyncValue =
                          ref.watch(
                              searchUserProvider(searchMessageController.text));

                      // Handle the different states of the provider
                      return searchUserAsyncValue.when(
                        data: (users) {
                          // Update the search results count
                          searchResultsCount = users.length;

                          if (users.isEmpty) {
                            Future.delayed(Duration.zero, () {
                              setState(() {
                                isShowUsers =
                                    false; // Hide results when no data is available
                              });
                            });
                          }
                          // Render the UI with the data from the provider
                          // You can use data (a List<UserModel>) here
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              searchMessageController.text.isNotEmpty
                                  ? Center(
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Pallete.whiteColor
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                        ),
                                        child: Text(
                                          searchResultsCount > 0
                                              ? '$searchResultsCount results'
                                              : '0 results',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Pallete.rhinoDark500,
                                            // fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: searchResultsCount,
                                  itemBuilder: (context, index) {
                                    final user = users[index];
                                    return SearchUserMessenger(userModel: user);
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
