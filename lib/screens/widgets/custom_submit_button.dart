import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_record_getx/controllers/controllers.dart';
import 'package:student_record_getx/model/db_model.dart';

class CustomSubmitButton extends StatelessWidget {
  const CustomSubmitButton({
    super.key,
    required this.controller,
    
  });

  final ActionController controller;
  

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[200],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      onPressed: () {
        final String name = controller.nameController.text;
        final age = controller.ageController.text;
        final grade = controller.gradeController.text;
        if (name.isNotEmpty && age.isNotEmpty) {
          controller.addStudent(Student(
            id: UniqueKey().toString(),
            name: name,
            age: age,
            imgPath: controller.selectedImage.value?.path,
            batch: grade, 
          ));
          controller.nameController.clear();
          controller.ageController.clear();
          controller.gradeController.clear();
          controller.setSelected('none');
          controller.clearSelectedImage();
          Get.back();
          controller.newStudentSnack();
        }
      },
      child: const SizedBox(
          width: 150,
          height: 50,
          child: Center(
              child: Text(
            'Submit',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
          ))),
    );
  }
}