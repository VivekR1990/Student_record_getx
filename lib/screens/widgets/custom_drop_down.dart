
// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:student_record_getx/model/db_model.dart';

// class CustomDropDOwnButton extends StatelessWidget {
//   Gender? selectedGender;
//   CustomDropDOwnButton({super.key, required this.selectedGender});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(
//         top: 20.0,
//         bottom: 5.0,
//       ),
//       child: DropdownButtonFormField<Gender>(
//         decoration: const InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(30.0),
//             ),
//           ),
//         ),
//         hint: const Text("Choose your gender",
//             style: TextStyle(color: Colors.black)),
//         value: selectedGender,
//         onChanged: (Gender? newValue) {
//           if (newValue != null) {
//             selectedGender = newValue;
//           }
//         },
//         items: Gender.values.map((Gender gender) {
//           return DropdownMenuItem<Gender>(
//             value: gender,
//             child: Text(
//               gender.toString().toUpperCase().split('.').last,
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }