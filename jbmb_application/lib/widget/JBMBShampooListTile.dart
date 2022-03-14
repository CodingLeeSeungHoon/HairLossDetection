import 'package:flutter/material.dart';

class JBMBShampooListTile extends StatelessWidget {
  VoidCallback? onTap;
  String imageUrl;

  JBMBShampooListTile({
    Key? key,
    this.onTap,
    required this.imageUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: SizedBox(
        width: 100,
        height: 100,
        child: Image.network(imageUrl),
      ),
      title: Text("샴푸"),
      subtitle: Text("glgl"),
    );
  }
}
