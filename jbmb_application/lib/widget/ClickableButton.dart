import 'package:flutter/material.dart';

/// 2022.02.27 이승훈 개발
/// ClickableButton Class

class ClickableButton extends StatelessWidget {
  final String buttonText;
  final Function? action;

  const ClickableButton({
    Key? key,
    required this.buttonText,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
        icon: const Icon(Icons.local_hospital, color: Colors.black, size: 15,),
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
