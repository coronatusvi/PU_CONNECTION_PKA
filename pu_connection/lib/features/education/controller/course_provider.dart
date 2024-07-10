// Course Providers

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../constants/env.dart';
import '../../../models/auth_model.dart';
import '../../../models/course_model.dart';
import '../../../models/data_model.dart';
import 'auth_provider.dart';

class CourseDataNotifier extends StateNotifier<List<CourseModel>?> {
  CourseDataNotifier() : super(null);

  Future<void> fetchData(Ref ref, String startDate, String endDate) async {
    AuthModel? authProvider =
        ref.read(authDataProvider); // Access the auth data

    DateTime now = DateTime.now();
    int unixTimestamp = now.millisecondsSinceEpoch ~/ 1000;

    String course_endpoint = Config.setApiGetCourse(
      (authProvider?.userId).toString(),
      unixTimestamp,
      startDate,
      endDate,
    );
    String apiUrl = Config.API_URL + course_endpoint;

    var response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authProvider?.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      ResponseModel couseData = ResponseModel.fromJson(data);

      if (couseData.data is List) {
        state = (couseData.data as List)
            .map((item) => CourseModel.fromJson(item))
            .toList();
      } else {
        state = null;
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}

final courseDataProvider =
    StateNotifierProvider<CourseDataNotifier, List<CourseModel>?>((ref) {
  return CourseDataNotifier();
});
