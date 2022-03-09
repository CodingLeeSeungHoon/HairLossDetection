import 'package:flutter/material.dart';
import 'package:jbmb_application/screen/DiagnosisAlertPage.dart';
import 'package:jbmb_application/screen/HospitalPage.dart';
import 'package:jbmb_application/screen/InfoPage.dart';
import 'package:jbmb_application/screen/LoginPage.dart';
import 'package:jbmb_application/screen/ShampooPage.dart';

import '../screen/CommunityPage.dart';
import '../screen/Home.dart';
import '../screen/JoinPage.dart';

/// 2020.03.07 이승훈 개발
class LoginedNavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 3);

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;
    double phonePadding = MediaQuery.of(context).padding.top;

    return Drawer(
      child: Material(
        child: ListView(
          padding: padding,
          children: <Widget>[
            SizedBox(height: phoneHeight * 0.10,),
            const Text("제발모발", textAlign: TextAlign.center, style: TextStyle(fontFamily: "Gugi-regular", fontSize: 25, fontWeight: FontWeight.bold),),
            SizedBox(
              height: phoneHeight * 0.05,
            ),
            buildMenuItem(
                text: '로그아웃',
                icon: Icons.logout,
                onClicked: () => selectedItem(context, 0)),
            buildMenuItem(
                text: '무료 자가진단',
                icon: Icons.check_box_rounded,
                onClicked: () => selectedItem(context, 1)),
            buildMenuItem(
                text: '자가진단 기록',
                icon: Icons.book_outlined,
                onClicked: () => selectedItem(context, 2)),
            buildMenuItem(
                text: '내게 맞는 샴푸 검색',
                icon: Icons.search,
                onClicked: () => selectedItem(context, 3)),
            buildMenuItem(
                text: '근처 탈모 병원 찾기',
                icon: Icons.local_hospital,
                onClicked: () => selectedItem(context, 4)),
            buildMenuItem(
                text: 'JBMB 커뮤니티',
                icon: Icons.group,
                onClicked: () => selectedItem(context, 5)),
            buildMenuItem(
                text: '앱 정보',
                icon: Icons.info,
                onClicked: () => selectedItem(context, 6)),
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
        // logout
        // Navigator.of(context).popUntil((route) => route.isFirst);
        Future.delayed(const Duration(milliseconds: 250), (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const Home(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        });
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DiagnosisAlertPage(),
        ));
        // diagnose
        break;
      case 2:
        // diagnose log
        break;
      case 3:
      // shampoo
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ShampooPage(),
        ));
        break;
      case 4:
      // hospital
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HospitalPage(),
        ));
        break;
      case 5:
      // jbmb community
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CommunityPage(),
        ));
        break;
      case 6:
      // info
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => InfoPage(),
        ));
        break;
    }
  }
}
