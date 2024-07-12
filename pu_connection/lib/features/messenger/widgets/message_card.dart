import 'package:flutter/material.dart';
import 'package:pu_connnection/models/message_model.dart';
import '../../../models/user_models.dart';
import '../../../theme/theme.dart';
import '../views/messages_detail_view.dart';

class SearchUserMessengerItem extends StatelessWidget {
  final UserModel userModel;
  final MessageModel messageUser;
  const SearchUserMessengerItem({
    super.key,
    required this.userModel,
    required this.messageUser,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MessagesDetailView.route(userModel),
            );
          },
          child: Container(
              margin: EdgeInsets.only(bottom: 23, right: 24, left: 24),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Pallete.rhinoDark500,
                    radius: 26,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(userModel.profilePic),
                      radius: 25, // Kích thước là 50x50, vì radius = 25
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userModel.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '@${messageUser.messageText}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Pallete.subTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
