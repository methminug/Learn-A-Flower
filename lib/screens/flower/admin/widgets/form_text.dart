import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/helpers/colors.dart';

class FormText extends StatelessWidget {
  final String text;
  const FormText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.black,
        fontSize: 20.0,
        letterSpacing: 1,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
