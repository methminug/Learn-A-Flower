import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_a_flower_app/helpers/colors.dart';

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
  final String errorText = 'This field is required';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = new TextEditingController();
  final TextEditingController _choice1Controller = new TextEditingController();
  final TextEditingController _choice2Controller = new TextEditingController();
  final TextEditingController _choice3Controller = new TextEditingController();
  final TextEditingController _choice4Controller = new TextEditingController();

  int _correctAnswer = 0;

  Widget _correctAnswerIcon(int iconIndex) {
    return InkResponse(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Answer',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _correctAnswer == iconIndex
                      ? AppColors.primaryDark
                      : Colors.transparent)),
          Icon(
            Icons.check_circle,
            color: _correctAnswer == iconIndex
                ? AppColors.primaryDark
                : Colors.grey[400],
          ),
        ],
      ),
      onTap: () => setState(() {
        _correctAnswer = iconIndex;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    pickedFile = _imagePicker
                        .pickImage(source: ImageSource.gallery)
                        .whenComplete(() => {setState(() {})});
                  },
                  child: FutureBuilder<XFile?>(
                    future: pickedFile,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        imageFile = File(snapshot.data!.path);
                        return Container(
                          alignment: Alignment.bottomCenter,
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: Image.file(File(snapshot.data!.path))
                                      .image)),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            color: AppColors.primary.withOpacity(0.8),
                            height: 40,
                            child: const Text(
                              "TAP to change image",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          alignment: Alignment.bottomCenter,
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: Image.asset(
                                          "assets/images/uploadImageIcon.png")
                                      .image)),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            color: AppColors.primary.withOpacity(0.8),
                            height: 40,
                            child: const Text(
                              "TAP to add image",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.question_mark_rounded,
                      color: AppColors.primaryDark),
                  title: TextFormField(
                      style: const TextStyle(
                          fontSize: 16, color: Colors.white, letterSpacing: 2),
                      controller: _questionController,
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(fontSize: 16),
                          labelText: 'Question')),
                ),
                ListTile(
                  title: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return errorText;
                        }
                        return null;
                      },
                      style: const TextStyle(fontSize: 16),
                      controller: _choice1Controller,
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(fontSize: 16),
                          labelText: 'Option 1')),
                  leading: _correctAnswerIcon(0),
                ),
                ListTile(
                  title: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return errorText;
                        }
                        return null;
                      },
                      style: const TextStyle(fontSize: 16),
                      controller: _choice2Controller,
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(fontSize: 16),
                          labelText: 'Option 2')),
                  leading: _correctAnswerIcon(1),
                ),
                ListTile(
                  title: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return errorText;
                        }
                        return null;
                      },
                      style: const TextStyle(fontSize: 16),
                      controller: _choice3Controller,
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(fontSize: 16),
                          labelText: 'Option 3')),
                  leading: _correctAnswerIcon(2),
                ),
                ListTile(
                  title: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return errorText;
                        }
                        return null;
                      },
                      style: const TextStyle(fontSize: 16),
                      controller: _choice4Controller,
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(fontSize: 16),
                          labelText: 'Option 4')),
                  leading: _correctAnswerIcon(3),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                  child: ElevatedButton(
                    child: Text("Add Question",
                        style: Theme.of(context).textTheme.headline6),
                    style: ElevatedButton.styleFrom(primary: AppColors.primary),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {}
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
