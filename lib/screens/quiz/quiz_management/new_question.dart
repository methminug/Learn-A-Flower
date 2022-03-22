import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_a_flower_app/helpers/colors.dart';
import 'package:learn_a_flower_app/models/quiz_question.dart';
import 'package:learn_a_flower_app/routes/app_routes.dart';
import 'package:learn_a_flower_app/services/quiz_service.dart';

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
  final List<TextEditingController> _choiceControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

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
    dynamic arguments = ModalRoute.of(context)!.settings.arguments as dynamic;
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
                      style: const TextStyle(fontSize: 16),
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
                      controller: _choiceControllers[0],
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
                      controller: _choiceControllers[1],
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
                      controller: _choiceControllers[2],
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
                      controller: _choiceControllers[3],
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
                      if (_formKey.currentState!.validate()) {
                        List<String> _options = [];
                        // _choiceControllers
                        //     .map((controller) => _options.add(controller.text));

                        _choiceControllers.forEach((element) {
                          _options.add(element.text);
                        });

                        QuizQuestion newQuestion = QuizQuestion.newQuestion(
                            answer: _correctAnswer,
                            options: _options,
                            question: _questionController.text);

                        List<dynamic> newQuestions =
                            arguments['quiz_info'].questions;

                        newQuestions.add(QuizQuestion.toJSON(newQuestion));

                        dynamic result = await QuizService.addNewQuestion(
                            arguments['quiz_info'].id, newQuestions, imageFile);
                        if (result) {
                          Navigator.pop(context);
                          Navigator.popAndPushNamed(
                              context, AppRoutes.QUIZ_MANAGEMENT_QUESTIONS,
                              arguments: {'quiz_info': arguments['quiz_info']});
                          // TODO SHOW ALERT
                        } else {
                          // TODO SHOW ALERT
                          print('Couldnt add question');
                        }
                      }
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
