import 'package:flutter/material.dart';

class TextContent extends StatelessWidget {
  final String flowerName, flowerDescription;

  const TextContent(
      {Key? key, required this.flowerName, required this.flowerDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          flowerName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          flowerDescription,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color.fromRGBO(139, 144, 165, 1),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
      ],
    );
  }
}
