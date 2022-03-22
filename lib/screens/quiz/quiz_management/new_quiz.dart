import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewQuiz extends StatefulWidget {
  const NewQuiz({Key? key}) : super(key: key);

  @override
  State<NewQuiz> createState() => _NewQuestionState();
}

class _NewQuestionState extends State<NewQuiz> {
  dynamic progress;
  bool firstLoad = true;
  final String errorText = 'This is a required field';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _servingsController = new TextEditingController();

  String _level = '';

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
