// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_record_getx/controllers/controllers.dart';
import 'package:student_record_getx/model/db_model.dart';
import 'package:student_record_getx/screens/widgets/custom_form_field.dart';

class EditStudentPage extends StatelessWidget {
  final String studentName;
  EditStudentPage({super.key, required this.studentName});

  final controller = Get.find<ActionController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Student? studentData = controller.getStudentByName(studentName);

    if (studentData != null) {
      controller.nameController.text = studentData.name;
      controller.ageController.text = studentData.age;
      controller.gradeController.text = studentData.batch;
      controller.selectedImage = Rx(File(studentData.imgPath ?? ''));
    }
    return Scaffold(
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
              "Edit Student",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          children: [
            CustomFormField(controller: controller.nameController),
            CustomFormField(controller: controller.ageController),
            CustomFormField(controller: controller.gradeController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                    onPressed: () {
                      controller.pickImage();
                    },
                    icon: const Icon(
                      Icons.upload_outlined,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Add Photo",
                      style: TextStyle(color: Colors.black),
                    )),
                Center(
                  child: Obx(
                    () => controller.selectedImage.value?.path != null &&
                            controller.selectedImage.value!.path.isNotEmpty
                        ? Image.file(
                            File(controller.selectedImage.value!.path),
                            height: 150,
                            width: 125,
                          )
                        : Image.asset(
                            'assets/avatar.png',
                            height: 150,
                          ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      controller.clearSelectedImage();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black,
                    ))
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              onPressed: () {
                final String name = controller.nameController.text;
                final age = controller.ageController.text;
                final grade = controller.gradeController.text;
                final image = controller.selectedImage.value?.path;
                if (name.isNotEmpty && age.isNotEmpty) {
                  controller.updateStudent(
                      id: studentData?.id,
                      newAge: age,
                      newName: name,
                      newGrade: grade,
                      newImg: image ?? studentData?.imgPath);
                  controller.nameController.clear();
                  controller.ageController.clear();
                  controller.gradeController.clear();
                  controller.setSelected('none');
                  controller.clearSelectedImage();
                  Get.back();
                  controller.editedStudentSnack();
                }
              },
              child: const SizedBox(
                  width: 150,
                  height: 50,
                  child: Center(
                      child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ))),
            ),
          ],
        ),
        backgroundColor: Colors.amber[50]);
  }
}
