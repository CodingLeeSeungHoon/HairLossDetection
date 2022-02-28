import 'package:flutter/material.dart';
import 'package:jbmb_application/screen/InfoPage.dart';
import 'package:jbmb_application/screen/LoginPage.dart';

import '../screen/JoinPage.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 3);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(height: 70,),
            const Text("제발모발", textAlign: TextAlign.center, style: TextStyle(fontFamily: "Gugi-regular", fontSize: 25, fontWeight: FontWeight.bold),),
            const SizedBox(
              height: 40,
            ),
            buildMenuItem(
                text: '로그인',
                icon: Icons.login,
                onClicked: () => selectedItem(context, 0)),
            buildMenuItem(
                text: '회원가입',
                icon: Icons.account_box,
                onClicked: () => selectedItem(context, 1)),
            buildMenuItem(
                text: '앱 정보',
                icon: Icons.info,
                onClicked: () => selectedItem(context, 2)),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.black;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: const TextStyle(color: color),
      ),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    // 새 창 들어가면 SideDrawer 닫도록
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => JoinPage(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => InfoPage(),
        ));
        break;
    }
  }
}
