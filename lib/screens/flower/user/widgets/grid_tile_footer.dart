import 'package:flutter/material.dart';

class GridTileFooter extends StatelessWidget {
  final String flowerName;
  const GridTileFooter({Key? key, required this.flowerName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      clipBehavior: Clip.antiAlias,
      child: GridTileBar(
        backgroundColor: Colors.black45,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            flowerName,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
