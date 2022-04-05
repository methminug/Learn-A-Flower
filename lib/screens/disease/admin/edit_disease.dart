import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/models/disease.dart';
import 'package:learn_a_flower_app/services/disease_service.dart';

const textStyle = TextStyle(
  color: Colors.black,
  fontSize: 20.0,
);

final inputDecoration = InputDecoration(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 2,
        )));

class EditDiseaseScreen extends StatefulWidget {
  const EditDiseaseScreen({Key? key}) : super(key: key);

  @override
  _EditDiseaseScreenState createState() => _EditDiseaseScreenState();
}

class _EditDiseaseScreenState extends State<EditDiseaseScreen> {
  late Disease diseaseData;
  late TextEditingController diseaseImageController;
  late TextEditingController diseaseNameController;
  late TextEditingController diseaseDescriptionController;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Edit Flower Disease'),
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
                  decoration:
                      inputDecoration.copyWith(hintText: 'Enter flower disease image'),
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
                  'Flower Disease Name',
                  style: textStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: diseaseNameController,
                  keyboardType: TextInputType.text,
                  decoration: inputDecoration.copyWith(
                      hintText: 'Enter the flower disease name'),
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
                      hintText: 'Enter the flower disease description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter flower disease description';
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
                              backgroundColor: MaterialStateProperty.all(
                                Colors.lightGreen,
                              ),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(250, 50)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10)))),
                          onPressed: (() async {
                            if (_formKey.currentState!.validate()) {
                              DiseaseService diseaseService = DiseaseService();
                              Disease disease = Disease(
                                  id: diseaseData.id,
                                  disease_name: diseaseData.disease_name,
                                  disease_description: diseaseData.disease_description,
                                  disease_image: diseaseData.disease_image);
                              setState(() {
                                isLoading = true;
                              });
                              await DiseaseService.updateDisease(disease);
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }),
                          child: const Text(
                            'Update',
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

  _initializeControllers() {
    diseaseData = ModalRoute.of(context)!.settings.arguments as Disease;
    diseaseImageController = TextEditingController(text: diseaseData.disease_image);
    diseaseNameController = TextEditingController(text: diseaseData.disease_name);
    diseaseDescriptionController =
        TextEditingController(text: diseaseData.disease_description
    );
  }
}
