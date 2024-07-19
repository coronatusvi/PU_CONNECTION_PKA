import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pu_connnection/models/message_model.dart';
import '../../../common/error_page.dart';
import '../../../common/loading_page.dart';
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

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    final currentUserId =
                        ref.watch(currentUserDetailsProvider).value?.uid;

                    final AsyncValue<List<MessageModel>> messagesAsyncValue =
                        ref.watch(searchMessagesProvider([
                      currentUserId!,
                      widget.userModel.uid,
                    ]));

                    print(messagesAsyncValue.valueOrNull);

                    return messagesAsyncValue.when(
                      data: (value) {
                        if (value.isEmpty) {
                          return Center(
                            child: Text(
                              'Hãy gửi đến nhau tin nhắn đầu tiên',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          );
                        }
                        return RefreshIndicator(
                          onRefresh: () async {
                            ref.refresh(searchMessagesProvider([
                              currentUserId,
                              widget.userModel.uid,
                            ]));
                          },
                          child: MessageList(messages: value),
                        );
                      },
                      loading: () =>
                          const SizedBox(), // Không hiển thị loading khi đã có dữ liệu
                      error: (error, _) => ErrorText(
                        error: error.toString(),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.attach_file, color: Colors.white),
                    onPressed: () {
                      // Function to select and send file
                    },
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
                    onPressed: () {
                      final message = _messageController.text.trim();
                      if (message.isNotEmpty) {
                        // ref.read(messageControllerProvider.notifier).sendMessage(
                        //       currentUserId,
                        //       widget.userModel.uid,
                        //       message,
                        //     );
                        // _messageController.clear();
                      }
                    },
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
