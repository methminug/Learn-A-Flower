import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDialogBox extends StatelessWidget {
  final String title, descriptions, img, url;

  const CustomDialogBox(
      {Key? key,
      required this.title,
      required this.descriptions,
      required this.img,
      required this.url})
      : super(key: key);

  static const double padding = 20;
  static const double avatarRadius = 100;

  @override
  Widget build(BuildContext context) {
    //References: https://medium.flutterdevs.com/custom-dialog-in-flutter-7ca5c2a8d33a
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(padding),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: padding,
                  top: avatarRadius + padding,
                  right: padding,
                  bottom: padding),
              margin: const EdgeInsets.only(top: avatarRadius),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(padding),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: textContent(context),
            ),
            flowerImage(context)
          ],
        ));
  }

  //DialogBox Flower Image box
  Widget flowerImage(BuildContext context) {
    return Positioned(
      left: padding,
      right: padding,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: avatarRadius,
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.network(
              img,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  //DialogBox Flower title and details text
  Widget textContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          descriptions,
          style: const TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(139, 144, 165, 1),
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 22,
        ),
        dialogBoxButton(context),
      ],
    );
  }

  //DialogBox Button
  Widget dialogBoxButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            // References: https://stackoverflow.com/questions/43149055/how-do-i-open-a-web-browser-url-from-my-flutter-code
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: const Text(
            'Read More',
            style: TextStyle(fontSize: 18, color: Colors.black),
          )),
    );
  }
}
