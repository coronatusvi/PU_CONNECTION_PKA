import 'dart:async';

import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  const Loader();

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  int dotCount = 1;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  void startTimer() {
    const duration = Duration(milliseconds: 500);
    timer = Timer.periodic(duration, (Timer t) {
      setState(() {
        dotCount = (dotCount % 3) + 1;
      });
    });
  }

  void stopTimer() {
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16.0),
          Text(
            'Loading' + (' . ' * dotCount),
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Loader(),
    );
  }
}
