import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/course_model.dart';
import '../controller/course_provider.dart';

class CalenderView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => CalenderView(),
      );

  @override
  ConsumerState<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends ConsumerState<CalenderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: ref
            .read(courseDataProvider.notifier)
            .fetchData(ref as Ref<Object?>, "01/01/2024", "07/01/2024"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Loading state
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Error state
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Data loaded successfully
            List<CourseModel>? courseData = ref.read(courseDataProvider);
            return Center(
              child: Text(
                  "Log Lịch học: ${courseData?[0].tenHocPhan ?? 'No course data'}"),
            );
          }
        },
      ),
    );
  }
}
