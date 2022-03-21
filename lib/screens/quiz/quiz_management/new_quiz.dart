import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewQuestion extends StatefulWidget {
  const NewQuestion({Key? key}) : super(key: key);

  @override
  State<NewQuestion> createState() => _NewQuestionState();
}

class _NewQuestionState extends State<NewQuestion> {
  dynamic progress;
  final ImagePicker _imagePicker = ImagePicker();
  late Future<XFile?> pickedFile = Future.value(null);
  File imageFile = File('');
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
