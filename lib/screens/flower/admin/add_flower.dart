import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/services/flower_service.dart';

import '../../../models/flower.dart';

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

class AddFlowerScreen extends StatefulWidget {
  const AddFlowerScreen({Key? key}) : super(key: key);

  @override
  _AddFlowerScreenState createState() => _AddFlowerScreenState();
}

class _AddFlowerScreenState extends State<AddFlowerScreen> {
  TextEditingController flowerImageController = TextEditingController();
  TextEditingController flowerNameController = TextEditingController();
  TextEditingController flowerDescriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Add Flower'),
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
                  'Image of Flower',
                  style: textStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: flowerImageController,
                  keyboardType: TextInputType.text,
                  decoration:
                  inputDecoration.copyWith(hintText: 'Enter flower image'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter flower image';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  'Name of Flower',
                  style: textStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: flowerNameController,
                  keyboardType: TextInputType.text,
                  decoration:
                      inputDecoration.copyWith(hintText: 'Enter flower name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter flower name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  'Flower Description',
                  style: textStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: flowerDescriptionController,
                  keyboardType: TextInputType.text,
                  decoration: inputDecoration.copyWith(
                      hintText: 'Enter flower description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter flower description';
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
                              FlowerService flowerService = FlowerService();
                              Flower flower = Flower(
                                  flowerImage: flowerImageController.text,
                                  flowerName: flowerNameController.text,
                                  flowerDescription: flowerNameController.text);
                              setState(() {
                                isLoading = true;
                              });
                              await flowerService.addFlower(flower);
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
