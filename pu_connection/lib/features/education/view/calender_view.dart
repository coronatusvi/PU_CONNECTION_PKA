import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pu_connnection/features/setting_profile/view/setting_profile_view.dart';
import '../../../models/course_model.dart';
import '../controller/course_provider.dart';

String startDate = "01/01/2024";
String endDate = "07/01/2024";

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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, SettingProfileView.route());
          },
          icon: const Icon(Icons.close, size: 30),
        ),
        title: const Text('Calender View'),
      ),
      body: FutureBuilder(
        future: ref
            .read(courseDataProvider.notifier)
            .fetchData(ref, startDate, endDate),
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
            if (courseData == null || courseData.isEmpty) {
              return Center(
                child: Text(
                  "Nghỉ ngơi đi, sắp thi rồi",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: courseData.length,
                itemBuilder: (context, index) {
                  CourseModel course = courseData[index];
                  return ListTile(
                    title: Text(course.tenHocPhan ?? 'Unknown Course'),
                    subtitle: Text(course.tenHocPhan ?? 'No description'),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
