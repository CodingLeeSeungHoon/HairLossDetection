import 'package:flutter/material.dart';

/// 2022.02.27 이승훈 개발
/// ClickableButton Class

class ClickableButton extends StatelessWidget {
  final String buttonText;
  final Function? action;
  final IconData? iconData;

  const ClickableButton({
    Key? key,
    required this.buttonText,
    required this.iconData,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
        icon: Icon(iconData, color: Colors.black, size: 15,),
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10.0),
          fixedSize: const Size(160, 45),
          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'NanumGothic-Regular'),
          onPrimary: Colors.black87,
          side: const BorderSide(color: Colors.black87, width: 2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      label: Text(buttonText),);
  }
}