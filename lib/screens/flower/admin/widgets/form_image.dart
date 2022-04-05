import 'package:flutter/material.dart';

class FormImageBox extends StatelessWidget {
  final String imageUrl;
  final double width, height;

  const FormImageBox({Key? key, required this.imageUrl, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: const Color.fromRGBO(233, 233, 233, 1),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            imageUrl,
          ),
        ),
      ),
    );
  }
}
