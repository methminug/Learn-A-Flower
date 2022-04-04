import 'package:flutter/material.dart';

final inputDecoration = InputDecoration(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 2,
        )));

class FormTextField extends StatelessWidget {
  final TextEditingController controller;
  final int lineCount;
  final String hintText, validator;

  const FormTextField({Key? key, required this.controller, required this.lineCount, required this.hintText, required this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      maxLines: lineCount,
      textAlign: TextAlign.justify,
      decoration: inputDecoration.copyWith(hintText: hintText),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validator;
        }
        return null;
      },
    );
  }
}
