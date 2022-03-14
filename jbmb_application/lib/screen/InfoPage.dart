import 'package:flutter/material.dart';
import 'package:jbmb_application/widget/JBMBBigLogo.dart';
import 'package:jbmb_application/widget/JBMBOutlinedButton.dart';

/// 2022.03.08 이승훈
/// JBMB 정보 페이지
/// 어플리케이션 정보 페이지
class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double phoneHeight = MediaQuery.of(context).size.height;
    double phonePadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(phonePadding * 0.33),
          margin: EdgeInsets.all(phonePadding * 0.33),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const JBMBBigLogo(),
              SizedBox(
                height: phoneHeight * 0.02,
              ),
              const Divider(
                thickness: 1,
                color: Colors.black38,
              ),
              SizedBox(
                height: phoneHeight * 0.04,
              ),
              getInfoContents(),
              SizedBox(
                height: phoneHeight * 0.04,
              ),
              JBMBOutlinedButton(
                buttonText: '돌아가기',
                iconData: Icons.arrow_back,
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          )),
    );
  }

  Column getInfoContents() {
    const String fontFamily = 'NanumGothic-Regular';
    const double fontSize = 13.0;
    const Color color = Colors.black45;
    const TextStyle textStyle = TextStyle(
        fontSize: fontSize,
        color: color,
        fontFamily: fontFamily,
        fontWeight: FontWeight.normal);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("제발모발은 자가문진과 AI 이미지 분석을 통한 \n"
            "무료 탈모 진단 및 추가 서비스 어플리케이션입니다.\n\n"
            "본 어플리케이션은 한국공학대학교 학생\n"
            "이승훈, 이한범, 김준태에게 모든 저작권이 있습니다.\n\n"
            "- 어플리케이션 제작에 많은 도움을 주신 전문가\n\n"
            "닥터포헤어 배곧점 원소정 원장님\n"
            "원광디지털대학교 한방미용예술학과 외래교수 조성일 교수님\n\n"
            "- 어플리케이션 폰트\n\n"
            "Google Fonts : Gugi\n"
            "나눔고딕체\n\n"
            "- 어플리케이션 아이콘\n"
            "Flaticon", style: textStyle,)
      ],
    );
  }
}
