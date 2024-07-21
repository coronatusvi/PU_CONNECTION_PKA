import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../../../common/common.dart';
import '../../../core/utils.dart';
import '../../../models/user_models.dart';
import '../../../theme/pallete.dart';
import '../../auth/controller/auth_controller.dart';
import '../controller/message_controller.dart';
import 'message_list.dart';

class ListMessagesItem extends ConsumerStatefulWidget {
  static Route route(UserModel userModel) => MaterialPageRoute(
        builder: (context) => ListMessagesItem(userModel: userModel),
      );

  final UserModel userModel;

  const ListMessagesItem({super.key, required this.userModel});

  @override
  _ListMessagesItemState createState() => _ListMessagesItemState();
}

class _ListMessagesItemState extends ConsumerState<ListMessagesItem> {
  final TextEditingController _messageController = TextEditingController();
  List<File> files = [];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _pickFiles() async {
    List<File> selectedFiles = await pickFiles();
    setState(() {
      files = selectedFiles; // Lưu các file đã chọn
    });
  }

  void sendMessage(List<String> Ids) {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      ref.watch(messageControllerProvider.notifier).sendMessage(
            Ids: Ids,
            message: message,
            files: files,
          );
      _messageController.clear();
      setState(() {
        files = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String currentUserId = ref.watch(currentUserDetailsProvider).value!.uid;
    List<String> Ids = [currentUserId, widget.userModel.uid];

    return Scaffold(
      backgroundColor: Pallete.blackColor,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Consumer(
                  builder: (context, ref, child) {
                    final messages = ref.watch(searchMessagesProvider(Ids));
                    ref.watch(currentUserAccountProvider);
                    ref.listen(
                      getLastMessageProvider,
                      (previous, next) {
                        return switch (next) {
                          AsyncData() =>
                            ref.invalidate(searchMessagesProvider(Ids)),
                          _ => () {},
                        };
                      },
                    );

                    return switch (messages) {
                      AsyncData(:final value) => RefreshIndicator(
                          onRefresh: () async =>
                              ref.invalidate(searchMessagesProvider(Ids)),
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
              ),
            ),
            if (files.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    for (var file in files)
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Selected file: ${file.path.split('/').last}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.clear, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                files.remove(file);
                              });
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.attach_file, color: Colors.white),
                    onPressed: _pickFiles,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Nhập tin nhắn...',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[800],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: () => sendMessage(Ids),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
