// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:jbmb_application/service/JBMBRegisterManager.dart';
import 'package:jbmb_application/widget/JBMBBigLogo.dart';
import 'package:jbmb_application/widget/JBMBOutlinedButton.dart';
import 'package:jbmb_application/widget/JBMBTextField.dart';

/// 2022.03.08 이승훈
/// 회원가입 페이지
/// JBMBRegisterManager 사용 로직 관리
class JoinPage extends StatefulWidget {
  const JoinPage({Key? key}) : super(key: key);

  @override
  _JoinPageState createState() {
    return _JoinPageState();
  }
}

class _JoinPageState extends State<JoinPage> {
  JBMBRegisterManager jbmbRegisterManager = JBMBRegisterManager();
  String _selectedGender = 'male';
  String id = '';
  String pw = '';
  String name = '';
  String phone = '';
  String email = '';
  int? age = 0;

  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;
    double phonePadding = MediaQuery.of(context).padding.top;

    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              if (MediaQuery.of(context).viewInsets.bottom != 0) {
                FocusManager.instance.primaryFocus?.unfocus();
              } else {
                Future.delayed(const Duration(milliseconds: 180), () {
                  Navigator.pop(context);
                });
              }
            },
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(
                    height: phoneHeight * 0.073,
                  ),
                  // TODO : LOGO Image Resolution
                  JBMBBigLogo(),
                  SizedBox(
                    height: phoneHeight * 0.029,
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.black38,
                  ),
                  SizedBox(
                    height: phoneHeight * 0.014,
                  ),
                  const Text(
                    "회원가입",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'NanumGothic-Regular',
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: phoneHeight * 0.029,
                  ),
                  Container(
                    width: phoneWidth * 0.85,
                    padding: EdgeInsets.all(phonePadding * 0.33),
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(color: Colors.black12),
                    child: getDescription(),
                  ),
                  SizedBox(
                    height: phoneHeight * 0.029,
                  ),
                  Container(
                    width: phoneWidth * 0.85,
                    height: phoneHeight * 0.073,
                    child: JBMBTextField(
                      obsecure: false,
                      labelText: 'ID (아이디)',
                      hintText: '아이디를 입력하세요.',
                      controller: idController,
                    ),
                  ),
                  SizedBox(
                    height: phoneHeight * 0.014,
                  ),
                  Container(
                    width: phoneWidth * 0.85,
                    height: phoneHeight * 0.073,
                    child: JBMBTextField(
                      obsecure: true,
                      labelText: 'PW (비밀번호)',
                      hintText: '비밀번호를 입력하세요.',
                      controller: pwController,
                    ),
                  ),
                  SizedBox(
                    height: phoneHeight * 0.014,
                  ),
                  Container(
                    width: phoneWidth * 0.85,
                    height: phoneHeight * 0.073,
                    child: JBMBTextField(
                      obsecure: false,
                      labelText: '이름',
                      hintText: '이름을 입력하세요.',
                      controller: nameController,
                    ),
                  ),
                  SizedBox(
                    height: phoneHeight * 0.014,
                  ),
                  Container(
                    width: phoneWidth * 0.85,
                    height: phoneHeight * 0.073,
                    child: JBMBTextField(
                      obsecure: false,
                      labelText: '전화번호',
                      hintText: '전화번호를 숫자만 입력하세요.',
                      textInputType: TextInputType.phone,
                      controller: phoneController,
                    ),
                  ),
                  SizedBox(
                    height: phoneHeight * 0.014,
                  ),
                  Container(
                    width: phoneWidth * 0.85,
                    height: phoneHeight * 0.073,
                    child: JBMBTextField(
                      obsecure: false,
                      labelText: '이메일',
                      hintText: '이메일을 입력하세요.',
                      textInputType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                  ),
                  SizedBox(
                    height: phoneHeight * 0.014,
                  ),
                  Container(
                    width: phoneWidth * 0.85,
                    height: phoneHeight * 0.073,
                    child: JBMBTextField(
                      obsecure: false,
                      labelText: '나이',
                      hintText: '나이를 숫자만 입력하세요.',
                      textInputType: TextInputType.number,
                      controller: ageController,
                    ),
                  ),
                  SizedBox(
                    height: phoneHeight * 0.014,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: phoneWidth * 0.35,
                        child: ListTile(
                          leading: Radio<String>(
                            fillColor: MaterialStateColor.resolveWith((states) => Colors.black54),
                            value: 'male',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                          ),
                          title: const Text('남성'),
                          horizontalTitleGap: 5,
                        ),
                      ),
                      SizedBox(
                        width: phoneWidth * 0.35,
                        child: ListTile(
                          leading: Radio<String>(
                            fillColor: MaterialStateColor.resolveWith((states) => Colors.black54),
                            value: 'female',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                          ),
                          title: const Text('여성'),
                          horizontalTitleGap: 5,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: phoneHeight * 0.014,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      JBMBOutlinedButton(
                        buttonText: '취소',
                        iconData: Icons.cancel,
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Future.delayed(const Duration(milliseconds: 300), () {
                            Navigator.pop(context);
                          });
                        },
                        backgroundColor: Colors.black12,
                      ),
                      JBMBOutlinedButton(
                        buttonText: '회원가입',
                        iconData: Icons.account_box,
                        onPressed: () {
                          setState(() {
                            id = idController.text;
                            pw = pwController.text;
                            name = nameController.text;
                            phone = phoneController.text;
                            email = emailController.text;
                            age = int.tryParse(ageController.text);
                          });
                          print(id);
                          print(pw);
                          print(name);
                          print(phone);
                          print(email);
                          print(age);
                          // 키보드 drop, 화면 drop, SnackBar show up
                          FocusManager.instance.primaryFocus?.unfocus();
                          Future.delayed(const Duration(milliseconds:  300), () {
                            Navigator.pop(context);
                            Future.delayed(const Duration(milliseconds: 200), () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Row(
                                    children: [
                                      const Icon(Icons.check, color: Colors.white,),
                                      const Text("  회원가입이 완료되었습니다!")
                                    ],
                                  ))
                              );
                            });
                          });
                        },
                        backgroundColor: Colors.black45,
                        elementColor: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: phoneHeight * 0.041,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Column getDescription() {
    const String fontFamily = 'NanumGothic-Regular';
    const Color color = Colors.black45;
    const double fontSize = 12;
    const FontWeight fontWeight = FontWeight.bold;
    const TextStyle textStyle = TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight);

    return Column(
      children: [
        const Text(
          "안녕하세요, 제발모발(JBMB)에 오신 것을 환영합니다.\n\n"
          "제발모발(JBMB)은 AI를 활용한 탈모 자가진단 및 관리 서비스 어플리케이션으로 "
          "간단한 설문과 이미지 AI 진단을 통해 자가 진단을 이용할 수 있으며 "
          "두피에 맞는 샴푸와 내 근처 탈모 전문 병원을 쉽게 검색할 수 있습니다.\n\n"
          "제발모발(JBMB)은 회원제로 운영되고 있으며, "
          "아래의 빈 칸을 모두 입력하셔야 회원가입을 진행할 수 있습니다.",
          style: textStyle,
        ),
      ],
    );
  }
}
