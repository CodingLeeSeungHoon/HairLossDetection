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

import '../object/JBMBHairTypeUpdateRequestObject.dart';
import '../screen/CommunityPage.dart';
import '../screen/Home.dart';
import '../screen/JoinPage.dart';
import '../service/JBMBDiagnoseManager.dart';
import '../service/JBMBShampooManager.dart';
import '../service/JBMBSurveyManager.dart';
import 'JBMBBigButton.dart';

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
            memberManager.memberInfo,
            await memberManager.jwtManager.getToken());

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
        // TODO : shampoo, check hair type
        int? hasHairType = memberManager.memberInfo.getHairType;
        if (hasHairType == null) {
          Navigator.of(context).pop();
          showModalBottomSheet(
              context: context, builder: (context) => buildSheet(context));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ShampooPage(
              memberManager: memberManager,
              shampooManager:
              JBMBShampooManager(memberManager.memberInfo.getHairType),
            ),
          ));
        }
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

  /// 샴푸 bottomSheet 생성하는 메소드
  Widget buildSheet(BuildContext context) => Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "당신의\n두피 타입을\n선택해주세요.\n",
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.black54,
                    fontFamily: 'NanumGothic-Regular',
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.info_outline),
                    tooltip:
                    '\n일반적으로 두피 역시 피부이기 때문에 \n건성 피부는 건성 두피, 지성 피부는 지성 두피를\n 가질 확률이 높습니다.\n'
                        '건성 두피는 각질과 비듬이 많은 두피,\n지성 두피는 유분이 많은 두피를 의미합니다.\n'
                        '샴푸를 한 지 반나절 내에 기름지고 축 가라앉는다면 지성,\n 비듬이나 각질 가루가 많이 떨어지는 두피는 건성입니다.\n',
                  ),
                  const Text("지성 두피와 건성 두피에 대해 \n알고 싶다면 버튼을 꾹 누르세요")
                ],
              ),
              const Divider(
                thickness: 2,
              ),
            ],
          ),
          Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  JBMBBigButton(
                    buttonText: '지성',
                    onPressed: () async {
                      JBMBHairTypeUpdateRequestObject request =
                      JBMBHairTypeUpdateRequestObject(
                          memberManager.memberInfo.getID, 1);
                      bool retval =
                      await memberManager.updateHairType(request);
                      if (retval) {
                        // success to save hair type
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ShampooPage(
                            memberManager: memberManager,
                            shampooManager: JBMBShampooManager(memberManager.memberInfo.getHairType),
                          ),
                        ));
                      } else {
                        // failed to save hair type
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "서버가 원활하지 않아 두피 유형이 저장되지 않았습니다.\n잠시 후에 다시 시도해주세요")));
                      }
                    },
                  ),
                  JBMBBigButton(
                    buttonText: '건성',
                    backgroundColor: Colors.white,
                    elementColor: Colors.black45,
                    onPressed: () async {
                      // TODO : save hair type codes
                      JBMBHairTypeUpdateRequestObject request =
                      JBMBHairTypeUpdateRequestObject(
                          memberManager.memberInfo.getID, 0);
                      bool retval =
                      await memberManager.updateHairType(request);
                      if (retval) {
                        // success to save hair type
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ShampooPage(
                            memberManager: memberManager,
                            shampooManager: JBMBShampooManager(memberManager.memberInfo.getHairType),
                          ),
                        ));
                      } else {
                        // failed to save hair type
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "서버가 원활하지 않아 두피 유형이 저장되지 않았습니다.\n잠시 후에 다시 시도해주세요")));
                      }
                    },
                  )
                ],
              ))
        ],
      ));
}
