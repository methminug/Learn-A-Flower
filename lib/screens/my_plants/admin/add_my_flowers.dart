import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/models/myFlower.dart';
import 'package:learn_a_flower_app/services/myFlower_service.dart';

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

class AddMyFlowerScreen extends StatefulWidget {
  const AddMyFlowerScreen({Key? key}) : super(key: key);

  @override
  _AddMyFlowerScreenState createState() => _AddMyFlowerScreenState();
}

class _AddMyFlowerScreenState extends State<AddMyFlowerScreen> {
  TextEditingController myFlowerImageController = TextEditingController();
  TextEditingController myFlowerNameController = TextEditingController();
  TextEditingController myFlowerNoteController = TextEditingController();

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
                  controller: myFlowerImageController,
                  keyboardType: TextInputType.text,
                  decoration:
                  inputDecoration.copyWith(hintText: 'Enter my flower image'),
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
                  controller: myFlowerNameController,
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
                  controller: myFlowerNoteController,
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
                        myFlowersService myFlowerService = myFlowersService();
                        WonderfulFlowers disease = WonderfulFlowers(
                            flowerName: myFlowerNameController.text,
                            image: myFlowerImageController.text,
                            notes: myFlowerNoteController.text);
                        setState(() {
                          isLoading = true;
                        });
                        await myFlowerService.addEmployee(disease);
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
