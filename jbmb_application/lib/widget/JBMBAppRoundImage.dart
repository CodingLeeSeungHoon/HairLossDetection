import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class JBMBAppRoundImage extends StatelessWidget {
  final ImageProvider provider;
  final double height;
  final double width;

  const JBMBAppRoundImage(this.provider,
      {Key? key, required this.height, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(1),
      child: Image(
        image: provider,
        height: height,
        width: width,
      ),
    );
  }

  factory JBMBAppRoundImage.url(String url, {
    required double height,
    required double width,
  }) {
    // return JBMBAppRoundImage(NetworkImage(url), height: height, width: width);
    return JBMBAppRoundImage(Image.file(File(url)).image, height: height, width: width);
  }

  factory JBMBAppRoundImage.memory(Uint8List data,
      { required double height, required double width,}){
    return JBMBAppRoundImage(MemoryImage(data), height: height, width: width);
  }
}
