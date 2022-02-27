import 'package:flutter/material.dart';

/// 2022.02.27 이승훈 개발
/// ClickableButton Class

class ClickableButton extends StatelessWidget {
  final String buttonText;

  const ClickableButton({
    Key? key,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(buttonText)],
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20.0),
          fixedSize: const Size(200, 60),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          onPrimary: Colors.black87,
          side: const BorderSide(color: Colors.black87, width: 2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ));
  }
}
