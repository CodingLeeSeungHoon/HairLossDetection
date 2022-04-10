import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jbmb_application/object/JBMBLoginRequestObject.dart';
import 'package:jbmb_application/screen/JoinPage.dart';
import 'package:jbmb_application/screen/LoginedHome.dart';
import 'package:jbmb_application/service/JBMBJwtManager.dart';
import 'package:jbmb_application/service/JBMBLoginManager.dart';
import 'package:jbmb_application/service/JBMBMemberManager.dart';
import 'package:jbmb_application/widget/JBMBBigLogo.dart';
import 'package:jbmb_application/widget/JBMBOutlinedButton.dart';
import 'package:jbmb_application/widget/JBMBTextField.dart';

import '../object/JBMBLoginResponseObject.dart';
import '../object/JBMBMemberInfo.dart';
import '../widget/JBMBAppBars.dart';

/// 2022.03.08 이승훈
/// 로그인 화면
/// JBMBLoginManager에 의해 로직 관리
class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  JBMBLoginManager jbmbLoginManager = JBMBLoginManager();
  JBMBLoginRequestObject jbmbLoginRequestObject = JBMBLoginRequestObject();

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery
        .of(context)
        .size
        .width;
    double phoneHeight = MediaQuery
        .of(context)
        .size
        .height;
    double phonePadding = MediaQuery
        .of(context)
        .padding
        .top;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: JBMBTransparentAppbar(onPressedCancel: () {
        if (MediaQuery
            .of(context)
            .viewInsets
            .bottom != 0) {
          FocusManager.instance.primaryFocus?.unfocus();
        } else {
          Future.delayed(const Duration(milliseconds: 180), () {
            Navigator.pop(context);
          });
        }
      }),
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(phonePadding * 0.33),
          margin: EdgeInsets.all(phonePadding * 0.33),
          child: SingleChildScrollView(
            // physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const JBMBBigLogo(),
                SizedBox(
                  height: phoneHeight * 0.021,
                ),
                SizedBox(
                    width: phoneWidth * 0.832,
                    child: JBMBTextField(
                      obsecure: false,
                      labelText: 'ID',
                      hintText: 'Enter your ID',
                      controller: idController,
                    )),
                SizedBox(
                  height: phoneHeight * 0.021,
                ),
                SizedBox(
                    width: phoneWidth * 0.832,
                    child: JBMBTextField(
                      obsecure: true,
                      labelText: 'PW',
                      hintText: 'Enter your PW',
                      controller: pwController,
                    )),
                SizedBox(
                  height: phoneHeight * 0.021,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    JBMBOutlinedButton(
                      buttonText: '로그인',
                      iconData: Icons.login,
                      onPressed: () async {
                        setState(() {
                          _getValueFromTextField();
                        });
                        JBMBLoginResponseObject loginResponse =
                        await jbmbLoginManager
                            .requestLogin(jbmbLoginRequestObject);
                        if (loginResponse.getResultCode == 0) {
                          // 로그인 응답에 성공한 경우
                          try {
                            log("after try login success");
                            JBMBMemberInfo memberInfo = await jbmbLoginManager
                                .getMemberInfoByToken(loginResponse.getJWT!);
                            log("success get info");
                            _doAfterSuccessLogin(
                                context, memberInfo, loginResponse);
                          } catch (e) {
                            log("fail get info");
                            _doAfterFailGetMemberInfo(context);
                          }
                        } else {
                          // 로그인 응답에 성공하지 못 한 경우
                          _doAfterFailLogin(context, loginResponse);
                        }
                      },
                    ),
                    JBMBOutlinedButton(
                      buttonText: '회원가입',
                      iconData: Icons.account_box,
                      onPressed: () {
                        _goJoinPage(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }

  // 텍스트 필드로부터 값을 가져온다.
  _getValueFromTextField() {
    jbmbLoginRequestObject.setID = idController.text;
    jbmbLoginRequestObject.setPW = pwController.text;
  }

  // 로그인 성공 및 MemberInfo를 받아오기에 성공하면, 호출되는 메소드
  // 로그인된 홈 페이지로 이동
  _doAfterSuccessLogin(BuildContext context, JBMBMemberInfo jbmbMemberInfo,
      JBMBLoginResponseObject loginResponse) async {
    JBMBJwtManager jwtManager = JBMBJwtManager();
    jwtManager.saveToken(loginResponse.getJWT!);
    JBMBMemberManager memberManager =
    JBMBMemberManager(jbmbMemberInfo, jwtManager);

    FocusManager.instance.primaryFocus?.unfocus();
    // Navigator.pop(context);
    Future.delayed(const Duration(milliseconds: 300), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              LoginedHome(
                memberManager: memberManager,
              ),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }

  // 멤버 정보를 가져오지 못 한 경우, 호출되는 메소드 (스낵바 소환)
  _doAfterFailGetMemberInfo(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: const [
            Icon(
              Icons.cancel_outlined,
              color: Colors.redAccent,
            ),
            Text("  JBMB 서버의 접속이 원활하지 않습니다."),
          ],
        )));
  }

// 로그인에 실패한 경우 호출되는 메소드 (스낵바 소환)
  _doAfterFailLogin(BuildContext context,
      JBMBLoginResponseObject loginResponseObject) {
    String snackBarText = "";
    switch (loginResponseObject.getResultCode) {
      case 1:
        snackBarText = "  존재하지 않는 ID입니다. 다시 확인해주세요.";
        break;
      case 2:
        snackBarText = "  비밀번호 오류입니다. 다시 확인해주세요.";
        break;
      case 3:
        snackBarText = "  JBMB 서버의 동작이 원활하지 않습니다.";
        break;
    }

    FocusManager.instance.primaryFocus?.unfocus();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.cancel_outlined,
              color: Colors.redAccent,
            ),
            Text(snackBarText),
          ],
        )));
  }

  // 회원가입 버튼을 클릭했을 때 호출되는 메소드 (페이지 이동)
  _goJoinPage(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.pop(context);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const JoinPage()));
  }
}
