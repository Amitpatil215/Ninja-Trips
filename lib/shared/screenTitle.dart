import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String text;

  const ScreenTitle({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(seconds: 2),
      builder: (context, value, child) {
        return Opacity(
          opacity: value, // It takes value as a double, provided in tween.

          /// Workaround 1:
          // child: child, // It automatically looks for child of builder and wrpas it with opacity

          /// Workaround 2:
          // We wanna animate the paddind along with opacity
          child: Padding(
            padding: EdgeInsets.only(top: value * 20),
            child: child, // It automatically looks for child of builder and wrpas it with opacity and padding
          ),
        );
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
