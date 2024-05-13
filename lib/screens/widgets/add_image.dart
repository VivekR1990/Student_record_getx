import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_record_getx/controllers/controllers.dart';

class AddImageButton extends StatelessWidget {
  const AddImageButton({
    super.key,
    required this.controller,
  });

  final ActionController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
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
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )),
          Center(
            child: Obx(
              () => controller.selectedImage.value != null
                  ? Image.file(
                      controller.selectedImage.value!,
                      height: 150,
                      width: 100,
                    )
                  : const Text('No image selected',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
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
    );
  }
}
