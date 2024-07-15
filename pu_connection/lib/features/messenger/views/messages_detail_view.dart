// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user_models.dart';
import '../widgets/list_message_item.dart';

class MessagesDetailView extends ConsumerWidget {
  static route(UserModel userModel) => MaterialPageRoute(
        builder: (context) => MessagesDetailView(
          userModel: userModel,
        ),
      );
  final UserModel userModel;
  MessagesDetailView({
    required this.userModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(userModel.name),
        ),
        body: ListMessagesItem(userModel: userModel));
  }
}
