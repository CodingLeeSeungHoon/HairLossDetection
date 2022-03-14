import 'package:flutter/material.dart';
import 'package:jbmb_application/screen/JoinPage.dart';
import 'package:jbmb_application/screen/LoginedHome.dart';
import 'package:jbmb_application/service/JBMBLoginManager.dart';
import 'package:jbmb_application/widget/JBMBBigLogo.dart';
import 'package:jbmb_application/widget/JBMBOutlinedButton.dart';
import 'package:jbmb_application/widget/JBMBTextField.dart';

import '../widget/JBMBAppBars.dart';

/// 2022.03.08 이승훈
/// 로그인 화면
/// JBMBLoginManager에 의해 로직 관리
class LoginPage extends StatelessWidget {
  final JBMBLoginManager jbmbLoginManager = JBMBLoginManager();

  LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;
    double phonePadding = MediaQuery.of(context).padding.top;

    TextEditingController idController = TextEditingController();
    TextEditingController pwController = TextEditingController();

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: JBMBTransparentAppbar(onPressedCancel: () {
        if (MediaQuery.of(context).viewInsets.bottom != 0) {
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
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TODO : Logo Image Resolution
                const JBMBBigLogo(),
                SizedBox(
                  height: phoneHeight * 0.043,
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
                      onPressed: () {
                        Navigator.pop(context);
                        Future.delayed(const Duration(milliseconds: 250), () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  // TODO : change variable
                                  LoginedHome(
                                jbmbMemberInfo: jbmbLoginManager
                                    .getMemberInfoByUserID(idController.text),
                              ),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );
                        });
                      },
                    ),
                    JBMBOutlinedButton(
                      buttonText: '회원가입',
                      iconData: Icons.account_box,
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Future.delayed(const Duration(milliseconds: 180), () {
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => JoinPage()));
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
