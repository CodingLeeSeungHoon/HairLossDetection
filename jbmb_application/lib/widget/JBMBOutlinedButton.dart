import 'package:flutter/material.dart';

/// 2022.02.27 이승훈 개발
/// ClickableButton Class

class JBMBOutlinedButton extends StatelessWidget {
  final String buttonText;
  final IconData? iconData;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? elementColor;

  const JBMBOutlinedButton({
    Key? key,
    required this.buttonText,
    required this.iconData,
    this.onPressed,
    this.backgroundColor = Colors.white,
    this.elementColor = Colors.black
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;

    return OutlinedButton.icon(
        icon: Icon(iconData, color: elementColor, size: 15,),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          padding: const EdgeInsets.all(10.0),
          fixedSize: Size(phoneWidth * 0.40, phoneHeight * 0.065),
          textStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'NanumGothic-Regular', color: elementColor),
          onPrimary: Colors.black87,
          side: const BorderSide(color: Colors.black87, width: 2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      label: Text(buttonText, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'NanumGothic-Regular', color: elementColor),),);
  }
}
