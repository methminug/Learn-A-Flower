import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String flowerImage;
  const ImageBox({Key? key, required this.flowerImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        flowerImage,
        fit: BoxFit.cover,
      ),
    );
  }
}
