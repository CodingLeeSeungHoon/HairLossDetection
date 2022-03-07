import 'package:flutter/material.dart';

class SurveyPage1 extends StatelessWidget {
  const SurveyPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      body: Text("hi"),
    ), onWillPop: (){
      return Future(() => false);
    });
  }
}
