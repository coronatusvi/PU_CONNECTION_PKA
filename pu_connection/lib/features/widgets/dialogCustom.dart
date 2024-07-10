import 'package:flutter/material.dart';

void ShowCustomDialog(String title, String content, context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Text(title),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 70.0, // Đặt giá trị tối đa cho chiều cao
          ),
          child: ListView(
            children: [Text(content)],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
