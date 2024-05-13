import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.controller,
    this.type,
    this.hint,
    this.current,
    this.next,
  });

  final TextEditingController controller;
  final TextInputType? type;
  final String? hint;
  final FocusNode? current, next;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20
      ),
      child: TextFormField(
        keyboardType: type,
        focusNode: current,
        onEditingComplete: () {
          next?.requestFocus();
        },
        style:
            const TextStyle(color: Colors.black,),
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) return 'Enter your $hint';
          return null;
        },
        decoration: InputDecoration(
          hintText: hint ?? '',
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
        ),
      ),
    );
  }
}