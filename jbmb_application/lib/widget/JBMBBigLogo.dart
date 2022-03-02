import 'package:flutter/material.dart';

class JBMBBigLogo extends StatelessWidget {
  final String jbmbLogoPath = 'images/jbmb_logo.png';
  const JBMBBigLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(jbmbLogoPath);
  }
}
