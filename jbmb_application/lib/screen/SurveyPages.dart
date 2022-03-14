import 'package:flutter/material.dart';
import 'package:jbmb_application/object/JBMBMemberInfo.dart';
import 'package:jbmb_application/screen/SurveyCustomPage.dart';
import 'package:jbmb_application/screen/UploadImageGuidePage.dart';

/// 2022.03.14 이승훈
/// 설문조사 버튼 누른 후 모션 메소드화 (애니메이션 제거, 페이지 변환)
class JBMBSurveyCustomMotion {
  anyButtonPressed(BuildContext context, StatelessWidget widget){
    Future.delayed(const Duration(milliseconds: 250), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              widget,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }
}

/// 2022.03.08 이승훈
/// 설문조사 페이지 1
class SurveyPage1 extends StatelessWidget {
  final String qNum;
  final String question;
  final JBMBMemberInfo jbmbMemberInfo;

  const SurveyPage1({Key? key,
    required this.qNum,
    required this.question,
    required this.jbmbMemberInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: qNum,
      question: question,
      onPressedYes: () {
        JBMBSurveyCustomMotion().anyButtonPressed(context, SurveyPage2(
          qNum: 'Q2.',
          question: '\n전보다 점점 이마가 넓어지는 느낌이 든다',
          jbmbMemberInfo: jbmbMemberInfo,
        ));
      },
      onPressedNo: () {
        JBMBSurveyCustomMotion().anyButtonPressed(context, SurveyPage2(
          qNum: 'Q2.',
          question: '\n전보다 점점 이마가 넓어지는 느낌이 든다',
          jbmbMemberInfo: jbmbMemberInfo,
        ));
      },
    );
    return surveyPageMock.build(context);
  }
}

/// 2022.03.08 이승훈
/// 설문조사 페이지 2
class SurveyPage2 extends StatelessWidget {
  final String qNum;
  final String question;
  final JBMBMemberInfo jbmbMemberInfo;

  const SurveyPage2({Key? key,
    required this.qNum,
    required this.question,
    required this.jbmbMemberInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: qNum,
      question: question,
      onPressedYes: () {
        JBMBSurveyCustomMotion().anyButtonPressed(context, SurveyPage3(
          qNum: 'Q3.',
          question: '\n가늘고 힘이 없는 머리가 빠지기 시작한다.',
          jbmbMemberInfo: jbmbMemberInfo,
        ));
      },
      onPressedNo: () {
        JBMBSurveyCustomMotion().anyButtonPressed(context, SurveyPage3(
          qNum: 'Q3.',
          question: '\n가늘고 힘이 없는 머리가 빠지기 시작한다.',
          jbmbMemberInfo: jbmbMemberInfo,
        ));
      },
    );
    return surveyPageMock.build(context);
  }
}

/// 2022.03.08 이승훈
/// 설문조사 페이지 3
class SurveyPage3 extends StatelessWidget {
  final String qNum;
  final String question;
  final JBMBMemberInfo jbmbMemberInfo;

  const SurveyPage3({Key? key,
    required this.qNum,
    required this.question,
    required this.jbmbMemberInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: qNum,
      question: question,
      onPressedYes: () {
        JBMBSurveyCustomMotion().anyButtonPressed(context, SurveyPage4(
          qNum: 'Q4.',
          question: '\n모발이 가늘고 부드러워진다.',
          jbmbMemberInfo: jbmbMemberInfo,
        ));
      },
      onPressedNo: () {
        JBMBSurveyCustomMotion().anyButtonPressed(context, SurveyPage4(
          qNum: 'Q4.',
          question: '\n모발이 가늘고 부드러워진다.',
          jbmbMemberInfo: jbmbMemberInfo,
        ));
      },
    );
    return surveyPageMock.build(context);
  }
}

/// 2022.03.08 이승훈
/// 설문조사 페이지 4
class SurveyPage4 extends StatelessWidget {
  final String qNum;
  final String question;
  final JBMBMemberInfo jbmbMemberInfo;

  const SurveyPage4({Key? key,
    required this.qNum,
    required this.question,
    required this.jbmbMemberInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: qNum,
      question: question,
      onPressedYes: () {
        JBMBSurveyCustomMotion().anyButtonPressed(context, SurveyPage5(
          qNum: 'Q5.',
          question: '\n두피를 누르면 통증이 있다.',
          jbmbMemberInfo: jbmbMemberInfo,
        ));
      },
      onPressedNo: () {
        JBMBSurveyCustomMotion().anyButtonPressed(context, SurveyPage5(
          qNum: 'Q5.',
          question: '\n두피를 누르면 통증이 있다.',
          jbmbMemberInfo: jbmbMemberInfo,
        ));
      },
    );
    return surveyPageMock.build(context);
  }
}

/// 2022.03.08 이승훈
/// 설문조사 페이지 5
class SurveyPage5 extends StatelessWidget {
  final String qNum;
  final String question;
  final JBMBMemberInfo jbmbMemberInfo;

  const SurveyPage5({Key? key,
    required this.qNum,
    required this.question,
    required this.jbmbMemberInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: qNum,
      question: question,
      onPressedYes: () {
        JBMBSurveyCustomMotion().anyButtonPressed(context, SurveyPage6(
          qNum: 'Q6.',
          question: '\n앞 머리와 뒷 머리의 굵기 차이가 있다',
          jbmbMemberInfo: jbmbMemberInfo,
        ));
      },
      onPressedNo: () {
        JBMBSurveyCustomMotion().anyButtonPressed(context, SurveyPage6(
          qNum: 'Q6.',
          question: '\n앞 머리와 뒷 머리의 굵기 차이가 있다',
          jbmbMemberInfo: jbmbMemberInfo,
        ));
      },
    );
    return surveyPageMock.build(context);
  }
}

/// 2022.03.08 이승훈
/// 설문조사 페이지 6
class SurveyPage6 extends StatelessWidget {
  final String qNum;
  final String question;
  final JBMBMemberInfo jbmbMemberInfo;

  const SurveyPage6({Key? key,
    required this.qNum,
    required this.question,
    required this.jbmbMemberInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: qNum,
      question: question,
      onPressedYes: () {
        JBMBSurveyCustomMotion().anyButtonPressed(context, SurveyPage7(
          qNum: 'Q7.',
          question: '\n몸의 털이 갑자기 굵어진다',
          jbmbMemberInfo: jbmbMemberInfo,
        ));
      },
      onPressedNo: () {
        JBMBSurveyCustomMotion().anyButtonPressed(context, SurveyPage7(
          qNum: 'Q7.',
          question: '\n몸의 털이 갑자기 굵어진다',
          jbmbMemberInfo: jbmbMemberInfo,
        ));
      },
    );
    return surveyPageMock.build(context);
  }
}

/// 2022.03.08 이승훈
/// 설문조사 페이지 7
class SurveyPage7 extends StatelessWidget {
  final String qNum;
  final String question;
  final JBMBMemberInfo jbmbMemberInfo;

  const SurveyPage7({Key? key,
    required this.qNum,
    required this.question,
    required this.jbmbMemberInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: qNum,
      question: question,
      onPressedYes: () {
        JBMBSurveyCustomMotion().anyButtonPressed(context, SurveyPage8(
          qNum: 'Q8.',
          question: '\n이마라인과 정수리 부분의 유난히 번들거린다',
          jbmbMemberInfo: jbmbMemberInfo,
        ));
      },
      onPressedNo: () {
        JBMBSurveyCustomMotion().anyButtonPressed(context, SurveyPage8(
          qNum: 'Q8.',
          question: '\n이마라인과 정수리 부분의 유난히 번들거린다',
          jbmbMemberInfo: jbmbMemberInfo,
        ));
      },
    );
    return surveyPageMock.build(context);
  }
}

/// 2022.03.08 이승훈
/// 설문조사 페이지 8
class SurveyPage8 extends StatelessWidget {
  final String qNum;
  final String question;
  final JBMBMemberInfo jbmbMemberInfo;

  const SurveyPage8({Key? key,
    required this.qNum,
    required this.question,
    required this.jbmbMemberInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: qNum,
      question: question,
      onPressedYes: () {
        JBMBSurveyCustomMotion().anyButtonPressed(context, SurveyPage9(
          qNum: 'Q9.',
          question: '\n두피의 피지량이 갑자기 늘어났다',
          jbmbMemberInfo: jbmbMemberInfo,
        ));
      },
      onPressedNo: () {
        JBMBSurveyCustomMotion().anyButtonPressed(context, SurveyPage9(
          qNum: 'Q9.',
          question: '\n두피의 피지량이 갑자기 늘어났다',
          jbmbMemberInfo: jbmbMemberInfo,
        ));
      },
    );
    return surveyPageMock.build(context);
  }
}

/// 2022.03.08 이승훈
/// 설문조사 페이지 9
class SurveyPage9 extends StatelessWidget {
  final String qNum;
  final String question;
  final JBMBMemberInfo jbmbMemberInfo;

  const SurveyPage9({Key? key,
    required this.qNum,
    required this.question,
    required this.jbmbMemberInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: qNum,
      question: question,
      onPressedYes: () {
        JBMBSurveyCustomMotion().anyButtonPressed(context, SurveyPage10(
          qNum: 'Q10.',
          question: '\n비듬이 많아지고 두피가 가렵다',
          jbmbMemberInfo: jbmbMemberInfo,
        ));
      },
      onPressedNo: () {
        JBMBSurveyCustomMotion().anyButtonPressed(context, SurveyPage10(
          qNum: 'Q10.',
          question: '\n비듬이 많아지고 두피가 가렵다',
          jbmbMemberInfo: jbmbMemberInfo,
        ));
      },
    );
    return surveyPageMock.build(context);
  }
}

/// 2022.03.08 이승훈
/// 설문조사 페이지 10
class SurveyPage10 extends StatelessWidget {
  final String qNum;
  final String question;
  final JBMBMemberInfo jbmbMemberInfo;

  const SurveyPage10({Key? key,
    required this.qNum,
    required this.question,
    required this.jbmbMemberInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: qNum,
      question: question,
      onPressedYes: () {
        JBMBSurveyCustomMotion().anyButtonPressed(context, UploadImageGuidePage(
          jbmbMemberInfo: jbmbMemberInfo,
        ));
      },
      onPressedNo: () {
        JBMBSurveyCustomMotion().anyButtonPressed(context, UploadImageGuidePage(
          jbmbMemberInfo: jbmbMemberInfo,
        ));
      },
    );
    return surveyPageMock.build(context);
  }
}
