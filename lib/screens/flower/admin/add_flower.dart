import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/helpers/colors.dart';
import 'package:learn_a_flower_app/models/flower.dart';
import 'package:learn_a_flower_app/screens/flower/admin/widgets/form_image.dart';
import 'package:learn_a_flower_app/screens/flower/admin/widgets/form_text.dart';
import 'package:learn_a_flower_app/screens/flower/admin/widgets/form_text_field.dart';
import 'package:learn_a_flower_app/services/flower_service.dart';

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
  late String imageUrl = '';
  TextEditingController flowerImageController = TextEditingController();
  TextEditingController flowerNameController = TextEditingController();
  TextEditingController flowerDescriptionController = TextEditingController();
  TextEditingController flowerInfoURLController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueGreen,
        elevation: 10,
        title: const Text(
          'Add New Flower',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const FormText(text: 'Flower Image URL'),
                    FormImageBox(imageUrl: imageUrl, width: 150.0, height: 100.0,),
                  ],
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: flowerImageController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      imageUrl = flowerImageController.text;
                    });
                  },
                  decoration:
                      inputDecoration.copyWith(hintText: 'Enter flower image'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter flower image';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0,),
                const FormText(text: 'Flower Name'),
                const SizedBox(height: 8.0,),
                FormTextField(controller: flowerNameController, lineCount: 1, hintText: 'Enter flower name', validator: 'Please enter flower name', ),
                const SizedBox(height: 24.0,),
                const FormText(text: 'Flower Description'),
                const SizedBox(height: 8.0,),
                FormTextField(controller: flowerDescriptionController, lineCount: 5, hintText: 'Enter flower description', validator: 'Please enter flower description', ),
                const SizedBox(height: 24.0,),
                const FormText(text: 'Flower More Details URL'),
                const SizedBox(height: 8.0,),
                FormTextField(controller: flowerInfoURLController, lineCount: 1, hintText: 'Enter flower more details url', validator: 'Please enter flower details url', ),
                const SizedBox(height: 24.0,),
                !isLoading
                    ? Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                AppColors.blueGreen.withOpacity(0.6),
                              ),
                              minimumSize: MaterialStateProperty.all(const Size(250, 50)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ))
                          ),
                          onPressed: (() async {
                            if (_formKey.currentState!.validate()) {
                              Flower flower = Flower(
                                  flowerImage: flowerImageController.text,
                                  flowerName: flowerNameController.text,
                                  flowerDescription: flowerNameController.text,
                                  flowerInfoURL: flowerInfoURLController.text);
                              setState(() {
                                isLoading = true;
                              });
                              await FlowerService.addFlower(flower);
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.of(context).pop();
                            }
                          }),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                            child: Text(
                              'Add Flower',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.green,
                            ),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
