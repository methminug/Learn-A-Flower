import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/models/myFlower.dart';
import 'package:learn_a_flower_app/services/myFlower_service.dart';


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

class EditMyFlowerScreen extends StatefulWidget {
  const EditMyFlowerScreen({Key? key}) : super(key: key);

  @override
  _EditMyFlowerScreenState createState() => _EditMyFlowerScreenState();
}

class _EditMyFlowerScreenState extends State<EditMyFlowerScreen> {
  late MyFlowers flowerData;
  late TextEditingController flowerImageController;
  late TextEditingController flowerNameController;
  late TextEditingController flowerDescriptionController;

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
        title: const Text('Edit Flower'),
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
                  'Flower Name',
                  style: textStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: flowerNameController,
                  keyboardType: TextInputType.text,
                  decoration: inputDecoration.copyWith(
                      hintText: 'Enter the flower name'),
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
                      hintText: 'Enter the flower description'),
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
                              myFlowersService myFlowerService =
                                  myFlowersService();
                              MyFlowers myFlowers = MyFlowers(
                                  id: flowerData.id,
                                  flowerName: flowerData.flowerName,
                                  notes: flowerData.notes,
                                  image: flowerData.image);
                              setState(() {
                                isLoading = true;
                              });
                              await myFlowerService.updateMyFlowers(myFlowers);
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
    flowerData = ModalRoute.of(context)!.settings.arguments as MyFlowers;
    flowerNameController = TextEditingController(text: flowerData.flowerName);
    flowerImageController = TextEditingController(text: flowerData.image);
    flowerDescriptionController =
        TextEditingController(text: flowerData.notes);
  }
}
