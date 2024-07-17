import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../models/course_model.dart';
import '../../home/view/home_view.dart';
import '../controller/course_provider.dart';

class CalenderView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => CalenderView(),
      );

  @override
  ConsumerState<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends ConsumerState<CalenderView> {
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startDateController.text = "01/01/2024";
    endDateController.text = "07/01/2024";
  }

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  void _pickDate(TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateFormat('dd/MM/yyyy').parse(controller.text),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, HomeView.route());
          },
          icon: const Icon(Icons.close, size: 30),
        ),
        title: const Text('Calender View'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: startDateController,
                    decoration: InputDecoration(
                      labelText: "Start Date",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _pickDate(startDateController),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: endDateController,
                    decoration: InputDecoration(
                      labelText: "End Date",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _pickDate(endDateController),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text("Xem"),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: ref.read(courseDataProvider.notifier).fetchData(
                  ref, startDateController.text, endDateController.text),
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
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: courseData.length,
                      itemBuilder: (context, index) {
                        CourseModel course = courseData[index];
                        return Card(
                          color: Color.fromARGB(255, 248, 248, 248),
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListTile(
                              title: Text(
                                course.tenHocPhan ?? 'Unknown Course',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 102, 255),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "Thu ${course.thuHoc} \nTiet ${course.tietBatDau.toInt()} - ${course.tietKetThuc.toInt()} (${course.gioBatDau.toInt()}:${course.phutBatDau.toInt()} - ${course.gioKetThuc.toInt()}:${course.phutKetThuc.toInt()})",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 102, 255),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
