import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_record_getx/controllers/controllers.dart';
import 'package:student_record_getx/screens/widgets/constants.dart';

class ProfileWidget extends StatelessWidget {
  final int index;
  const ProfileWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActionController>(builder: (controller) {
      final students = controller.getStudents();
      final student = students[index];
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
            title: const Text(
              "Student Profile",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green[200],
            shadowColor: Colors.black,
            elevation: 25,
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.lightBlueAccent, width: 2),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25)),
            )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                      image: student.imgPath != null
                          ? FileImage(File(student.imgPath!))
                              as ImageProvider<Object>
                          : const AssetImage('assets/avatar.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            // Student name
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  changeStyle('Name', student.name),

                  const SizedBox(height: 20),
                  // Student age
                  changeStyle('Age', student.age),
                  const SizedBox(height: 20),

                  // Student grade
                  changeStyle('Batch', student.batch),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.amber[50],
      );
    });
  }
}
