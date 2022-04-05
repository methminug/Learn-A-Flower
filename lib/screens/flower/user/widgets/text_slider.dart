import 'package:flutter/material.dart';

class TextSlider extends StatelessWidget {
  final Color color;
  final String text;
  final IconData icon;

  const TextSlider({Key? key, required this.color, required this.text, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), color: color),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
              alignment: Alignment.centerRight,
              child: Icon(
                icon,
                size: 50,
                color: Colors.white,
              )),
        ),
        Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                text,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ))
      ],
    );
  }
}
