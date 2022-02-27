import 'package:flutter/material.dart';
import 'screen/Home.dart';

void main() => runApp(const JBMBApplication());

class JBMBApplication extends StatelessWidget {
  const JBMBApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '제발모발',
      themeMode: ThemeMode.system,
      home: Home(),
    );
  }
}
