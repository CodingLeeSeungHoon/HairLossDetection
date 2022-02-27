import 'package:flutter/material.dart';

import '../widget/ClickableButton.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "제발모발",
            style: TextStyle(
                fontSize: 23, color: Colors.black, fontFamily: 'Gugi-Regular'),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          titleTextStyle:
              const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        body: const Center(
            child: ClickableButton(
          buttonText: '생성자 버튼',
        )));
  }
}
