import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_record_getx/controllers/controllers.dart';
import 'package:student_record_getx/model/db_model.dart';
import 'package:student_record_getx/screens/edit_student.dart';
import 'package:student_record_getx/screens/student_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchTerm = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchTerm.addListener(() {
      final controller = Get.find<ActionController>();
      final List<Student> allStudents = controller.getStudents();
      controller.searchStudents(allStudents, searchTerm.text);
      // Update UI with filtered students
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: const Text('Search Students',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchTerm,
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintText: 'Search by Name',
                hintStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.search_sharp, color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: _buildStudentList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentList() {
    final controller = Get.find<ActionController>();
    final List<Student> allStudents = controller.getStudents();
    final List<Student> filteredStudents =
        controller.searchStudents(allStudents, searchTerm.text);

    return ListView.builder(
      itemCount: filteredStudents.length,
      itemBuilder: (context, index) {
        final student = filteredStudents[index];
        debugPrint(student.imgPath);

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
                  Get.to(() => EditStudentPage(studentName: student.name));
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  controller.deleteDialog(index);
                },
                icon: const Icon(Icons.delete),
              )
            ],
          ),
        );
      },
    );
  }
}
