import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jbmb_application/object/JBMBMemberInfo.dart';
import 'package:jbmb_application/screen/DiagnosisAlertPage.dart';
import 'package:jbmb_application/screen/DiagnosisLogPage.dart';
import 'package:jbmb_application/screen/HospitalPage.dart';
import 'package:jbmb_application/screen/InfoPage.dart';
import 'package:jbmb_application/screen/LoginPage.dart';
import 'package:jbmb_application/screen/ShampooPage.dart';
import 'package:jbmb_application/service/JBMBDiagnoseLogManager.dart';
import 'package:jbmb_application/service/JBMBLoginManager.dart';
import 'package:jbmb_application/service/JBMBMemberManager.dart';

import '../screen/CommunityPage.dart';
import '../screen/Home.dart';
import '../screen/JoinPage.dart';
import '../service/JBMBDiagnoseManager.dart';
import '../service/JBMBSurveyManager.dart';

/// 2020.03.07 이승훈 개발
class LoginedNavigationDrawerWidget extends StatelessWidget {
  final JBMBMemberManager memberManager;

  LoginedNavigationDrawerWidget({Key? key, required this.memberManager})
      : super(key: key);
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
            SizedBox(
              height: phoneHeight * 0.10,
            ),
            const Text(
              "제발모발",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Gugi-regular",
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
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

  Future<void> selectedItem(BuildContext context, int index) async {
    // 새 창 들어가면 SideDrawer 닫도록
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        // logout
        // Navigator.of(context).popUntil((route) => route.isFirst);
        try {
          String token = await memberManager.jwtManager.getToken();
          JBMBLoginManager().tryLogout(token);
          log("[Logout] success logout with valid token");
        } catch (e) {
          log("[Logout] token was invalid but success logout : $e");
        }
        Future.delayed(const Duration(milliseconds: 250), () {
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
        JBMBSurveyManager surveyManager = JBMBSurveyManager();
        JBMBDiagnoseManager diagnoseManager =
            JBMBDiagnoseManager(surveyManager);

        int retval = await diagnoseManager.createNewDiagnosis(
            memberManager.memberInfo, await memberManager.jwtManager.getToken());

        if (retval != -1) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DiagnosisAlertPage(
                memberManager: memberManager, diagnoseManager: diagnoseManager),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
            children: const [
              Icon(
                Icons.check,
                color: Colors.red,
              ),
              Text("서버상의 문제로, 진단을 시작할 수 없습니다.\n"
                  "잠시 후에 다시 시도해주세요."),
            ],
          )));
        }
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DiagnosisLogPage(
            memberManager: memberManager,
            diagnoseManager: JBMBDiagnoseManager(null),
            diagnoseLogManager: JBMBDiagnoseLogManager(),
          ),
        ));
        break;
      case 3:
        // shampoo
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ShampooPage(
            memberManager: memberManager,
          ),
        ));
        break;
      case 4:
        // hospital
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HospitalPage(
            memberManager: memberManager,
          ),
        ));
        break;
      case 5:
        // jbmb community
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CommunityPage(
            memberManager: memberManager,
          ),
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
