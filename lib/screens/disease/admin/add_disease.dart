import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/models/disease.dart';
import 'package:learn_a_flower_app/services/disease_service.dart';

const textStyle = TextStyle(
  color: Colors.white,
  fontSize: 22.0,
  letterSpacing: 1,
  fontWeight: FontWeight.bold,
);

final inputDecoration = InputDecoration(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 2,
        )));

class AddDiseaseScreen extends StatefulWidget {
  const AddDiseaseScreen({Key? key}) : super(key: key);

  @override
  _AddDiseaseScreenState createState() => _AddDiseaseScreenState();
}

class _AddDiseaseScreenState extends State<AddDiseaseScreen> {
  TextEditingController diseaseNameController = TextEditingController();
  TextEditingController diseaseDescriptionController = TextEditingController();
  TextEditingController diseaseImageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Add Disease'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Image of Flower Disease',
                  style: textStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: diseaseImageController,
                  keyboardType: TextInputType.text,
                  decoration: inputDecoration.copyWith(
                      hintText: 'Enter flower disease image'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter flower disease image';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  'Name of Flower Disease',
                  style: textStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: diseaseNameController,
                  keyboardType: TextInputType.text,
                  decoration:
                      inputDecoration.copyWith(hintText: 'Enter flower disease name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter flower disease name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  'Flower Disease Description',
                  style: textStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: diseaseDescriptionController,
                  keyboardType: TextInputType.text,
                  decoration: inputDecoration.copyWith(
                      hintText: 'Enter flower disease description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter flower diseaseS description';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24.0,
                ),
                !isLoading
                    ? Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  const Size(200, 50)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 83, 80, 80))),
                          onPressed: (() async {
                            if (_formKey.currentState!.validate()) {
                              DiseaseService diseasesService =
                                  DiseaseService();
                              Disease disease = Disease(
                                  disease_name: diseaseNameController.text,
                                  disease_description: diseaseDescriptionController.text,
                                  disease_image: diseaseImageController.text);
                              setState(() {
                                isLoading = true;
                              });
                              await diseasesService.addDisease(disease);
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }),
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
