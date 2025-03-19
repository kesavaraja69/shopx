import 'package:flutter/material.dart';

class Customtext extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color? textcolor;
  const Customtext({
    super.key,
    required this.text,
    required this.size,
    required this.fontWeight,
    this.textcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: textcolor,
        fontWeight: fontWeight,
      ),
    );
  }
}
