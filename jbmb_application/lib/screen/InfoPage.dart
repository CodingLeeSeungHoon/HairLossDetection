import 'package:flutter/material.dart';
import 'package:jbmb_application/widget/ClickableButton.dart';

class InfoPage extends StatelessWidget {
  final String jbmbLogoPath = 'images/jbmb_logo.png';

  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50.0,
              ),
              Image.asset(jbmbLogoPath),
              const SizedBox(
                height: 20.0,
              ),
              const Divider(
                thickness: 2,
                color: Colors.black38,
              ),
              const SizedBox(
                height: 40.0,
              ),
              getInfoContents(),
              const SizedBox(
                height: 40.0,
              ),
              ClickableButton(
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
        Text(
          "제발모발은 자가문진과 AI 이미지 분석을 통한",
          style: textStyle,
        ),
        Text(
          "무료 탈모 진단 및 추가 서비스 어플리케이션입니다.",
          style: textStyle,
        ),
        Text(
          "본 어플리케이션은 한국공학대학교 학생",
          style: textStyle,
        ),
        Text(
          "이승훈, 이한범, 김준태에게 모든 저작권이 있습니다.",
          style: textStyle,
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          "- 어플리케이션 제작에 많은 도움을 주신 전문가",
          style: textStyle,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "닥터포헤어 배곧점 원소정 원장님",
          style: textStyle,
        ),
        Text(
          "원광디지털대학교 한방미용예술학과 외래교수 조성일 교수님",
          style: textStyle,
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          "- 어플리케이션 폰트",
          style: textStyle,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Google Fonts : Gugi",
          style: textStyle,
        ),
        Text(
          "나눔고딕체",
          style: textStyle,
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          "- 어플리케이션 아이콘",
          style: textStyle,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Flaticon",
          style: textStyle,
        ),
      ],
    );
  }
}
