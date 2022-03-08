import 'package:flutter/material.dart';

class JBMBBigButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? elementColor;

  const JBMBBigButton({Key? key,
    required this.buttonText,
    this.onPressed,
    this.backgroundColor = Colors.black45,
    this.elementColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery
        .of(context)
        .size
        .width;
    double phoneHeight = MediaQuery
        .of(context)
        .size
        .height;

    return OutlinedButton(onPressed: onPressed,
      child: Text(buttonText, style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 50, color: elementColor),),
      style: OutlinedButton.styleFrom(
        primary: Colors.black54,
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.all(10.0),
        fixedSize: Size(phoneWidth * 0.35, phoneWidth * 0.35),
        textStyle: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, fontFamily: 'NanumGothic-Regular', color: elementColor),
        side: const BorderSide(color: Colors.grey, width: 2),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),);
  }
}
