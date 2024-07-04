import 'package:flutter/material.dart';

class Appbars extends StatelessWidget {
  const Appbars({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
                text: 'Wallpaper',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontWeight: FontWeight.w500)),
            TextSpan(
                text: 'Hub', style: TextStyle(fontSize: 15, color: Colors.blue))
          ]),
        ),
      ],
    );
  }
}
