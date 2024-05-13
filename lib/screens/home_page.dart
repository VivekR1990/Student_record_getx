// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:student_record_getx/controllers/controllers.dart';
import 'package:student_record_getx/model/db_model.dart';
import 'package:student_record_getx/screens/add_student.dart';
import 'package:student_record_getx/screens/edit_student.dart';
import 'package:student_record_getx/screens/search_page.dart';
import 'package:student_record_getx/screens/student_page.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Student Management",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green[200],
        shadowColor: Colors.black,
        elevation: 25,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.lightBlueAccent, width: 2),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => const SearchScreen()),
            icon: const Icon(Icons.search, color: Colors.white),
          )
        ],
      ),
      body: GetBuilder<ActionController>(
        builder: (controller) {
          final List<Student> students = controller.getStudents();
          if (students.isEmpty) {
            return Center(
              child: Lottie.asset(
                'assets/nodata.json',
              ),
            );
          }
          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              debugPrint(student.imgPath ?? "");

              return ListTile(
                onTap: () => Get.to(() => ProfileWidget(index: index)),
                leading: student.imgPath != null
                    ? SizedBox.square(
                        dimension: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image(
                            image: FileImage(File(student.imgPath!)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : const CircleAvatar(
                        backgroundImage: AssetImage('assets/avatar.png'),
                        radius: 25,
                      ),
                title: Text(
                  student.name,
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: Text('Age: ${student.age}'),
                trailing: Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.to(
                            () => EditStudentPage(studentName: student.name));
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.deleteDialog(index);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(
          side: BorderSide(color: Colors.lightBlueAccent, width: 4),
        ),
        backgroundColor: Colors.green[200],
        onPressed: () {
          Get.to(() => AddStudent());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.amber[50],
    );
  }
}
