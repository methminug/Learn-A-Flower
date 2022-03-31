import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/models/disease.dart';
import 'package:learn_a_flower_app/models/myFlower.dart';

class MyFlowerDetails extends StatefulWidget {
  const MyFlowerDetails({ Key? key}) : super(key: key);

  @override
  _MyFlowerDetailsState createState() => _MyFlowerDetailsState();
}

class _MyFlowerDetailsState extends State<MyFlowerDetails> {

  @override
  Widget build(BuildContext context) {
    MyFlowers myFlowersData = ModalRoute.of(context)!.settings.arguments as MyFlowers;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(myFlowersData.flowerName,
                        style:
                        const TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold,)),
                    const SizedBox(height: 20),
                    Image.network(myFlowersData.image,width: 250,
                    ),
                  ],
                ),
              ),
              Expanded(child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children:  [
                    Text(
                      myFlowersData.notes,
                      textAlign: TextAlign.justify,
                      style:
                      const TextStyle(color: Colors.black, fontSize: 18, height: 1.5),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )),
            ],
          ),
        ));
  }
}