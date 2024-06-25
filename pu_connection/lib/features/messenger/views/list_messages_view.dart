import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListMessagesView extends ConsumerStatefulWidget {
  const ListMessagesView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListMessagesViewState();
}

class _ListMessagesViewState extends ConsumerState<ListMessagesView> {
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
        child: Text('Nội dung của tin mới'),
      ),
    );
  }
}
