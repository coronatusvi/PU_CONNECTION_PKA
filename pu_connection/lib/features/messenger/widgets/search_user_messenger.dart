import 'package:flutter/material.dart';
import '../../../models/user_models.dart';
import '../../../theme/theme.dart';
import '../views/messages_detail_view.dart';

class SearchUserMessenger extends StatelessWidget {
  final UserModel userModel;
  const SearchUserMessenger({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                    '@${userModel.name}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Pallete.subTextColor,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
