import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesDetailView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const MessagesDetailView(),
      );
  const MessagesDetailView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MessagesDetailViewState();
}

class _MessagesDetailViewState extends ConsumerState<MessagesDetailView> {
  final searchController = TextEditingController();
  bool isShowUsers = false;
  bool isImageVisible = true;

  int searchResultsCount = 0; // Initialize with 0 search results

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách tin nhắn'),
      ),
      body: Center(
        child: Text('Nội dung của tin nhắn mới sẽ được hiển thị ở đây.'),
      ),
    );
  }
}
