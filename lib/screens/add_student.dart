import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_record_getx/controllers/controllers.dart';
import 'package:student_record_getx/screens/widgets/add_image.dart';
import 'package:student_record_getx/screens/widgets/custom_form_field.dart';
import 'package:student_record_getx/screens/widgets/custom_submit_button.dart';

class AddStudent extends StatelessWidget {
  final controller = Get.put(ActionController());
  AddStudent({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
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
            "Add Student",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15, top: 30),
            child: Column(
              children: [
                CustomFormField(
                    controller: controller.nameController,
                    current: controller.nameFocus,
                    next: controller.ageFocus,
                    hint: "Name",
                    type: TextInputType.text),
                CustomFormField(
                  controller: controller.ageController,
                  current: controller.ageFocus,
                  next: controller.gradeFocus,
                  hint: "Age",
                  type: TextInputType.number,
                ),
                CustomFormField(
                  controller: controller.gradeController,
                  current: controller.gradeFocus,
                  next: null,
                  hint: "Batch",
                  type: TextInputType.text,
                ),
                AddImageButton(controller: controller)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: CustomSubmitButton(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
