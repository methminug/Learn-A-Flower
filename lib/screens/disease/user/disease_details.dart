import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/models/disease.dart';

class DiseaseDetails extends StatefulWidget {
  const DiseaseDetails({ Key? key}) : super(key: key);

  @override
  _DiseaseDetailsState createState() => _DiseaseDetailsState();
}

class _DiseaseDetailsState extends State<DiseaseDetails> {

  @override
  Widget build(BuildContext context) {
    Disease diseaseData = ModalRoute.of(context)!.settings.arguments as Disease;

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
              Text(diseaseData.disease_name,
                style:
                 const TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold,)),
               const SizedBox(height: 20),
              Image.network(diseaseData.disease_image,width: 250,
              ),
            ],
          ),
        ),
              Expanded(child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children:  [
                    Text(
                      diseaseData.disease_description,
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