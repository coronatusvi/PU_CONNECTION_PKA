import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pu_connnection/models/message_model.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../common/error_page.dart';
import '../../../common/loading_page.dart';
import '../../../constants/assets_constants.dart';
import '../../../theme/pallete.dart';
import '../../auth/controller/auth_controller.dart';
import '../../tweet/widgets/carousel_image.dart';
import '../../tweet/widgets/hashtag_text.dart';
import '../../user_profile/view/user_profile_view.dart';

class MessageCard extends ConsumerWidget {
  final MessageModel message;
  const MessageCard({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    final ui_currentUser = currentUser?.uid == message.senderId
        ? TextDirection.rtl
        : TextDirection.ltr;
    return currentUser == null
        ? const SizedBox()
        : ref.watch(userDetailsProvider(message.senderId)).when(
              data: (user) {
                return GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Row(
                        textDirection: ui_currentUser,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  UserProfileView.route(user),
                                );
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(user.profilePic),
                                radius: 15,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              textDirection: ui_currentUser,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  textDirection: ui_currentUser,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: user.isTwitterBlue ? 1 : 5,
                                      ),
                                      child: Text(
                                        user.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    if (user.isTwitterBlue)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: SvgPicture.asset(
                                          AssetsConstants.verifiedIcon,
                                        ),
                                      ),
                                    Text(
                                      '${timeago.format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            message.timestamp),
                                        locale: "en_short",
                                      )}',
                                      style: const TextStyle(
                                        color: Pallete.greyColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                HashtagText(text: message.messageText),
                                // if (message.tweetType == TweetType.image)
                                //   CarouselImage(imageLinks: message.imageLinks),
                                // if (message.fileIds.isNotEmpty) ...[
                                //   const SizedBox(height: 4),
                                //   Container(
                                //     decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(10.0),
                                //     ),
                                //     child: ClipRRect(
                                //       borderRadius: BorderRadius.circular(10.0),
                                //       child: AnyLinkPreview(
                                //         displayDirection:
                                //             UIDirection.uiDirectionHorizontal,
                                //         link: fileIds.link[0],
                                //       ),
                                //     ),
                                //   ),
                                // ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              error: (error, stackTrace) => ErrorText(
                error: error.toString(),
              ),
              loading: () => const Loader(),
            );
  }
}
