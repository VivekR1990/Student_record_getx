import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_record_getx/controllers/controllers.dart';
import 'package:student_record_getx/controllers/services.dart';
import 'package:student_record_getx/model/db_model.dart';
import 'package:student_record_getx/screens/home_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  await Hive.openBox<Student>('students');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePageScreen(),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut<ImagePickerService>(() => ImagePickerService());
        Get.lazyPut<ActionController>(() => ActionController());
      }),
    );
  }
}