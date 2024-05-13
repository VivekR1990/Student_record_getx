import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:student_record_getx/controllers/services.dart';
import 'package:student_record_getx/model/db_model.dart';

class ActionController extends GetxController {
  final selected = "None".obs;
  final Box<Student> _studentBox = Hive.box<Student>('students');
  final ImagePickerService _imagePickerService = Get.put(ImagePickerService());
  final RxString searchTerm = RxString("");
  Rx<File?> selectedImage = Rx<File?>(null);

  Future<void> pickImage() async {
    final pickedImage = await _imagePickerService.pickImage();
    if (pickedImage != null) {
      moveImageToFolder(pickedImage.path);
    }
  }

  List<Student> searchStudents(List<Student> students, String searchTerm) {
    if (searchTerm.isEmpty) {
      return students; // Return all students if search term is empty
    } else {
      return students.where((student) =>
        student.name.toLowerCase().contains(searchTerm.toLowerCase())
      ).toList();
    }
  }

  void clearSelectedImage() {
    selectedImage.value = null;
  }

  void setSelected(String value) {
    selected.value = value;
  }

  List<String> list = ['Male', 'Female', 'Others', 'None'];
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController gradeController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode ageFocus = FocusNode();
  FocusNode gradeFocus = FocusNode();

  List<Student> getStudents() {
  if (searchTerm.isEmpty) {
    return _studentBox.values.toList();
  } else {
    return _studentBox.values
        .where((element) => element.name.toLowerCase().contains(searchTerm.value))
        .toList();
  }
}


  void searchStudent(String input) {
  if (input.isEmpty) {
    // If input is empty, show all students
    searchTerm.value = "";
  } else {
    // Filter students whose name contains the input
    searchTerm.value = input.toLowerCase();
  }
}



  void addStudent(Student student) {
    try {
      _studentBox.add(student);
      update();
      debugPrint("To Do Object added ${student.name}");
    } catch (e) {
      debugPrint("Erro occured while adding $e");
    }
  }

  void deleteStudent(int index) {
    _studentBox.deleteAt(index);
    update(); // Trigger an update to reflect changes in the UI
  }

  void updateStudent(
      {String? id,
      String? newName,
      String? newAge,
      String? newGrade,
      String? newImg}) {
    final List<Student> students = getStudents();
    final studentIndex = students.indexWhere((student) => student.id == id);
    if (studentIndex != -1) {
      students[studentIndex].name = newName ?? students[studentIndex].name;
      students[studentIndex].age = newAge ?? students[studentIndex].age;
      students[studentIndex].batch = newGrade ?? students[studentIndex].age;
      students[studentIndex].imgPath = newImg ?? students[studentIndex].imgPath;
      update();
    }
  }

  Student? getStudentByName(String name) {
    final List<Student> students = getStudents();
    return students.firstWhere(
      (student) => student.name.toLowerCase() == name.toLowerCase(),
      orElse: () => Student(age: '', batch: '', id: '', name: name),
    );
  }

  Future<void> moveImageToFolder(String sourcePath) async {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    final destinationFolder = '${appDocumentDir.path}/desired_folder';
    final fileName = DateTime.now().microsecondsSinceEpoch.toString();
    final File sourceFile = File(sourcePath);
    final File destinationFile = File('$destinationFolder/$fileName');

    try {
      if (!await Directory(destinationFolder).exists()) {
        await Directory(destinationFolder).create(recursive: true);
      }

      await sourceFile.copy(destinationFile.path);
      final updatedImage = File(destinationFile.path);
      final selectedImage = Get.find<ActionController>().selectedImage;
      selectedImage.value = updatedImage;
    } catch (e) {
      debugPrint("Error moving image: $e");
    }
  }

  newStudentSnack() => Get.snackbar("Successful", " Student Added Sucessfully",
      colorText: Colors.white,
      backgroundColor: Colors.green,
      icon: const Icon(Icons.add_alert),
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.BOTTOM);

  editedStudentSnack() =>
      Get.snackbar("Successful", " Student Edited Sucessfully",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          icon: const Icon(Icons.add_alert),
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.BOTTOM);
  deleteStudentSnack() =>
      Get.snackbar("Successful", " Student Edited Sucessfully",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          icon: const Icon(Icons.add_alert),
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.BOTTOM);

  deleteDialog(int index) => Get.defaultDialog(
          backgroundColor: Colors.amber[50],
          title: 'Are you sure',
          content: const Text("Student is going to delete. confirm"),
          actions: [
            TextButton(
                onPressed: () => Get.back(), child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  deleteStudent(index);
                  Get.back();
                },
                child: const Text('Delete')),
          ]);
  logoutDialog() => Get.defaultDialog(
          title: 'Are you sure',
          content: const Text("Student is going to delete. confirm"),
          actions: [
            TextButton(
                onPressed: () => Get.back(), child: const Text('Cancel')),
            TextButton.icon(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.logout_outlined),
                label: const Text('Logout')),
          ]);
          
}


