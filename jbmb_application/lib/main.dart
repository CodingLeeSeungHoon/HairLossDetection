import 'package:flutter/material.dart';

void main() => runApp(const JBMBApplication());

class JBMBApplication extends StatelessWidget {
  const JBMBApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '제발모발',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(),
    );
  }
}