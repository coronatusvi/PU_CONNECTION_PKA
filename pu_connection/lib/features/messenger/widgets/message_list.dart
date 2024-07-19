import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/message_model.dart';
import 'message_card.dart';

class MessageList extends ConsumerWidget {
  const MessageList({
    super.key,
    required this.messages,
  });

  final List<MessageModel> messages;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int index) {
        final message = messages[index];
        return MessageCard(
          message: message,
        );
      },
    );
  }
}
