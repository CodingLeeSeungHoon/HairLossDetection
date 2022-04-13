import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jbmb_application/object/JBMBMemberInfo.dart';
import 'package:jbmb_application/screen/SurveyCustomPage.dart';
import 'package:jbmb_application/screen/UploadImageGuidePage.dart';
import 'package:jbmb_application/service/JBMBDiagnoseManager.dart';
import 'package:jbmb_application/service/JBMBMemberManager.dart';

/// 2022.03.14 이승훈
/// 설문조사 버튼 누른 후 모션 메소드화 (애니메이션 제거, 페이지 변환)
class JBMBSurveyCustomMotion {
  anyButtonPressed(BuildContext context, StatefulWidget widget) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => widget,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
  lastAnyButtonPressed(BuildContext context, StatelessWidget widget) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => widget,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}

/// 같은 동작 함수화
class AfterClickedButton {
  afterDo(
      BuildContext context,
      StatefulWidget widget,
      JBMBDiagnoseManager diagnoseManager,
      String qNum,
      int checked,
      String jwtToken) async {
    if (!diagnoseManager.isDiagnosisIDNull()) {
      bool retval = await diagnoseManager.surveyManager!.saveSurveyInput(
          diagnoseManager.getDiagnosisID!, qNum, checked, jwtToken);
      if (!retval) {
        log("[ERROR] Survey 저장 중 에러가 발생하였으나, 어플리케이션의 원활한 구동을 위해 넘어갑니다. : $qNum");
      }
      JBMBSurveyCustomMotion().anyButtonPressed(context, widget);
    }
  }
  afterLast(
      BuildContext context,
      StatelessWidget widget,
      JBMBDiagnoseManager diagnoseManager,
      String qNum,
      int checked,
      String jwtToken) async {
    if (!diagnoseManager.isDiagnosisIDNull()) {
      bool retval = await diagnoseManager.surveyManager!.saveSurveyInput(
          diagnoseManager.getDiagnosisID!, qNum, checked, jwtToken);
      if (!retval) {
        log("[ERROR] Survey 저장 중 에러가 발생하였으나, 어플리케이션의 원활한 구동을 위해 넘어갑니다. : $qNum");
      }
      JBMBSurveyCustomMotion().lastAnyButtonPressed(context, widget);
    }
  }
}

/// 2022.04.13 이승훈
/// 설문조사 페이지 1
/// change button click only one time
class SurveyPage1 extends StatefulWidget {
  final String qNum;
  final String question;
  final JBMBMemberManager memberManager;
  final JBMBDiagnoseManager diagnoseManager;

  const SurveyPage1({Key? key,
    required this.qNum,
    required this.question,
    required this.memberManager,
    required this.diagnoseManager})
      : super(key: key);

  @override
  _SurveyPage1State createState() => _SurveyPage1State();
}

class _SurveyPage1State extends State<SurveyPage1>{
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: widget.qNum,
      question: widget.question,
      onPressedYes: () async {
        if (!isClicked){
          setState(() {
            isClicked = true;
          });
          AfterClickedButton().afterDo(context, SurveyPage2(
            qNum: 'Q2.',
            question: '\n전보다 점점 이마가 넓어지는 느낌이 든다',
            memberManager: widget.memberManager,
            diagnoseManager: widget.diagnoseManager,
          ), widget.diagnoseManager, widget.qNum, 1, await widget.memberManager.jwtManager.getToken());
        } else {
          null;
        }
      },
      onPressedNo: () async {
        if (!isClicked){
          setState(() {
            isClicked = true;
          });
          AfterClickedButton().afterDo(context, SurveyPage2(
            qNum: 'Q2.',
            question: '\n전보다 점점 이마가 넓어지는 느낌이 든다',
            memberManager: widget.memberManager,
            diagnoseManager: widget.diagnoseManager,
          ), widget.diagnoseManager, widget.qNum, 0, await widget.memberManager.jwtManager.getToken());
        } else {
          null;
        }
      },
    );
    return surveyPageMock.build(context);
  }
}

/// 2022.03.08 이승훈
/// 설문조사 페이지 2
class SurveyPage2 extends StatefulWidget {
  final String qNum;
  final String question;
  final JBMBMemberManager memberManager;
  final JBMBDiagnoseManager diagnoseManager;

  const SurveyPage2({Key? key,
    required this.qNum,
    required this.question,
    required this.memberManager,
    required this.diagnoseManager})
      : super(key: key);

  @override
  _SurveyPage2State createState() => _SurveyPage2State();
}

class _SurveyPage2State extends State<SurveyPage2>{
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: widget.qNum,
      question: widget.question,
      onPressedYes: () async {
        if (!isClicked){
          setState(() {
            isClicked = true;
          });
          AfterClickedButton().afterDo(context, SurveyPage3(
              qNum: 'Q3.',
              question: '\n가늘고 힘이 없는 머리가 빠지기 시작한다.',
              memberManager: widget.memberManager,
              diagnoseManager: widget.diagnoseManager
          ), widget.diagnoseManager, widget.qNum, 1, await widget.memberManager.jwtManager.getToken());
        } else {
          null;
        }
      },
      onPressedNo: () async {
        if (!isClicked){
          setState(() {
            isClicked = true;
          });
          AfterClickedButton().afterDo(context, SurveyPage3(
              qNum: 'Q3.',
              question: '\n가늘고 힘이 없는 머리가 빠지기 시작한다.',
              memberManager: widget.memberManager,
              diagnoseManager: widget.diagnoseManager
          ), widget.diagnoseManager, widget.qNum, 0, await widget.memberManager.jwtManager.getToken());
        } else {
          null;
        }
      },
    );
    return surveyPageMock.build(context);
  }
}

/// 2022.03.08 이승훈
/// 설문조사 페이지 3
class SurveyPage3 extends StatefulWidget {
  final String qNum;
  final String question;
  final JBMBMemberManager memberManager;
  final JBMBDiagnoseManager diagnoseManager;

  const SurveyPage3(
      {Key? key,
      required this.qNum,
      required this.question,
      required this.memberManager,
      required this.diagnoseManager})
      : super(key: key);

  @override
  _SurveyPage3State createState() => _SurveyPage3State();
}

class _SurveyPage3State extends State<SurveyPage3>{
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: widget.qNum,
      question: widget.question,
      onPressedYes: () async {
        if (!isClicked){
          setState(() {
            isClicked = true;
          });
          AfterClickedButton().afterDo(context, SurveyPage4(
              qNum: 'Q4.',
              question: '\n모발이 가늘고 부드러워진다.',
              memberManager: widget.memberManager,
              diagnoseManager: widget.diagnoseManager
          ), widget.diagnoseManager, widget.qNum, 1, await widget.memberManager.jwtManager.getToken());
        } else {
          null;
        }
      },
      onPressedNo: () async {
        if (!isClicked){
          setState(() {
            isClicked = true;
          });
          AfterClickedButton().afterDo(context, SurveyPage4(
              qNum: 'Q4.',
              question: '\n모발이 가늘고 부드러워진다.',
              memberManager: widget.memberManager,
              diagnoseManager: widget.diagnoseManager
          ), widget.diagnoseManager, widget.qNum, 0, await widget.memberManager.jwtManager.getToken());
        } else {
          null;
        }
      },
    );
    return surveyPageMock.build(context);
  }
}

/// 2022.03.08 이승훈
/// 설문조사 페이지 4
class SurveyPage4 extends StatefulWidget {
  final String qNum;
  final String question;
  final JBMBMemberManager memberManager;
  final JBMBDiagnoseManager diagnoseManager;

  const SurveyPage4({Key? key,
    required this.qNum,
    required this.question,
    required this.memberManager,
    required this.diagnoseManager})
      : super(key: key);

  @override
  _SurveyPage4State createState() => _SurveyPage4State();
}

class _SurveyPage4State extends State<SurveyPage4>{
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: widget.qNum,
      question: widget.question,
      onPressedYes: () async {
        if (!isClicked){
          setState(() {
            isClicked = true;
          });
          AfterClickedButton().afterDo(context, SurveyPage5(
              qNum: 'Q5.',
              question: '\n두피를 누르면 통증이 있다.',
              memberManager: widget.memberManager,
              diagnoseManager: widget.diagnoseManager
          ), widget.diagnoseManager, widget.qNum, 1, await widget.memberManager.jwtManager.getToken());
        } else {
          null;
        }
      },
      onPressedNo: () async {
        if (!isClicked){
          setState(() {
            isClicked = true;
          });
          AfterClickedButton().afterDo(context, SurveyPage5(
              qNum: 'Q5.',
              question: '\n두피를 누르면 통증이 있다.',
              memberManager: widget.memberManager,
              diagnoseManager: widget.diagnoseManager
          ), widget.diagnoseManager, widget.qNum, 0, await widget.memberManager.jwtManager.getToken());
        } else {
          null;
        }
      },
    );
    return surveyPageMock.build(context);
  }
}

/// 2022.03.08 이승훈
/// 설문조사 페이지 5
class SurveyPage5 extends StatefulWidget {
  final String qNum;
  final String question;
  final JBMBMemberManager memberManager;
  final JBMBDiagnoseManager diagnoseManager;

  const SurveyPage5({Key? key,
    required this.qNum,
    required this.question,
    required this.memberManager,
    required this.diagnoseManager})
      : super(key: key);

  @override
  _SurveyPage5State createState() => _SurveyPage5State();
}

class _SurveyPage5State extends State<SurveyPage5>{
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: widget.qNum,
      question: widget.question,
      onPressedYes: () async {
        if(!isClicked){
          setState(() {
            isClicked = true;
          });
          AfterClickedButton().afterDo(context, SurveyPage6(
              qNum: 'Q6.',
              question: '\n앞 머리와 뒷 머리의 굵기 차이가 있다',
              memberManager: widget.memberManager,
              diagnoseManager: widget.diagnoseManager
          ), widget.diagnoseManager, widget.qNum, 1, await widget.memberManager.jwtManager.getToken());
        } else {
          null;
        }
      },
      onPressedNo: () async {
        if(!isClicked){
          setState(() {
            isClicked = true;
          });
          AfterClickedButton().afterDo(context, SurveyPage6(
              qNum: 'Q6.',
              question: '\n앞 머리와 뒷 머리의 굵기 차이가 있다',
              memberManager: widget.memberManager,
              diagnoseManager: widget.diagnoseManager
          ), widget.diagnoseManager, widget.qNum, 0, await widget.memberManager.jwtManager.getToken());
        } else {
          null;
        }
      },
    );
    return surveyPageMock.build(context);
  }
}

/// 2022.03.08 이승훈
/// 설문조사 페이지 6
class SurveyPage6 extends StatefulWidget {
  final String qNum;
  final String question;
  final JBMBMemberManager memberManager;
  final JBMBDiagnoseManager diagnoseManager;

  const SurveyPage6({Key? key,
    required this.qNum,
    required this.question,
    required this.memberManager,
    required this.diagnoseManager})
      : super(key: key);

  @override
  _SurveyPage6State createState() => _SurveyPage6State();
}

class _SurveyPage6State extends State<SurveyPage6>{
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: widget.qNum,
      question: widget.question,
      onPressedYes: () async {
        if(!isClicked){
          setState(() {
            isClicked = true;
          });
          AfterClickedButton().afterDo(context, SurveyPage7(
              qNum: 'Q7.',
              question: '\n몸의 털이 갑자기 굵어진다',
              memberManager: widget.memberManager,
              diagnoseManager: widget.diagnoseManager
          ), widget.diagnoseManager, widget.qNum, 1, await widget.memberManager.jwtManager.getToken());
        } else {
          null;
        }
      },
      onPressedNo: () async {
        if (!isClicked) {
          setState(() {
            isClicked = true;
          });
          AfterClickedButton().afterDo(context, SurveyPage7(
              qNum: 'Q7.',
              question: '\n몸의 털이 갑자기 굵어진다',
              memberManager: widget.memberManager,
              diagnoseManager: widget.diagnoseManager
          ), widget.diagnoseManager, widget.qNum, 0, await widget.memberManager.jwtManager.getToken());
        } else {
          null;
        }
      },
    );
    return surveyPageMock.build(context);
  }
}

/// 2022.03.08 이승훈
/// 설문조사 페이지 7
class SurveyPage7 extends StatefulWidget {
  final String qNum;
  final String question;
  final JBMBMemberManager memberManager;
  final JBMBDiagnoseManager diagnoseManager;

  const SurveyPage7({Key? key,
    required this.qNum,
    required this.question,
    required this.memberManager,
    required this.diagnoseManager})
      : super(key: key);

  @override
  _SurveyPage7State createState() => _SurveyPage7State();
}

class _SurveyPage7State extends State<SurveyPage7>{
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: widget.qNum,
      question: widget.question,
      onPressedYes: () async {
        if(!isClicked){
          setState(() {
            isClicked = true;
          });
          AfterClickedButton().afterDo(context, SurveyPage8(
              qNum: 'Q8.',
              question: '\n이마라인과 정수리 부분의 유난히 번들거린다',
              memberManager: widget.memberManager,
              diagnoseManager: widget.diagnoseManager
          ), widget.diagnoseManager, widget.qNum, 1, await widget.memberManager.jwtManager.getToken());
        } else {
          null;
        }
      },
      onPressedNo: () async {
        if (!isClicked){
          setState(() {
            isClicked = true;
          });
          AfterClickedButton().afterDo(context, SurveyPage8(
              qNum: 'Q8.',
              question: '\n이마라인과 정수리 부분의 유난히 번들거린다',
              memberManager: widget.memberManager,
              diagnoseManager: widget.diagnoseManager
          ), widget.diagnoseManager, widget.qNum, 0, await widget.memberManager.jwtManager.getToken());
        } else {
          null;
        }
      },
    );
    return surveyPageMock.build(context);
  }
}

/// 2022.03.08 이승훈
/// 설문조사 페이지 8
class SurveyPage8 extends StatefulWidget {
  final String qNum;
  final String question;
  final JBMBMemberManager memberManager;
  final JBMBDiagnoseManager diagnoseManager;

  const SurveyPage8({Key? key,
    required this.qNum,
    required this.question,
    required this.memberManager,
    required this.diagnoseManager})
      : super(key: key);

  @override
  _SurveyPage8State createState() => _SurveyPage8State();
}

class _SurveyPage8State extends State<SurveyPage8>{
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: widget.qNum,
      question: widget.question,
      onPressedYes: () async {
        if(!isClicked){
          setState(() {
            isClicked = true;
          });
          AfterClickedButton().afterDo(context, SurveyPage9(
              qNum: 'Q9.',
              question: '\n두피의 피지량이 갑자기 늘어났다',
              memberManager: widget.memberManager,
              diagnoseManager: widget.diagnoseManager
          ), widget.diagnoseManager, widget.qNum, 1, await widget.memberManager.jwtManager.getToken());
        } else {
          null;
        }
      },
      onPressedNo: () async {
        if(!isClicked){
          setState(() {
            isClicked = true;
          });
          AfterClickedButton().afterDo(context, SurveyPage9(
              qNum: 'Q9.',
              question: '\n두피의 피지량이 갑자기 늘어났다',
              memberManager: widget.memberManager,
              diagnoseManager: widget.diagnoseManager
          ), widget.diagnoseManager, widget.qNum, 0, await widget.memberManager.jwtManager.getToken());
        } else {
          null;
        }
      },
    );
    return surveyPageMock.build(context);
  }
}

/// 2022.03.08 이승훈
/// 설문조사 페이지 9
class SurveyPage9 extends StatefulWidget {
  final String qNum;
  final String question;
  final JBMBMemberManager memberManager;
  final JBMBDiagnoseManager diagnoseManager;

  const SurveyPage9({Key? key,
    required this.qNum,
    required this.question,
    required this.memberManager,
    required this.diagnoseManager})
      : super(key: key);

  @override
  _SurveyPage9State createState() => _SurveyPage9State();
}

class _SurveyPage9State extends State<SurveyPage9>{
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: widget.qNum,
      question: widget.question,
      onPressedYes: () async {
        if(!isClicked){
          setState(() {
            isClicked = true;
          });
          AfterClickedButton().afterDo(context, SurveyPage10(
              qNum: 'Q10.',
              question: '\n비듬이 많아지고 두피가 가렵다',
              memberManager: widget.memberManager,
              diagnoseManager: widget.diagnoseManager
          ), widget.diagnoseManager, widget.qNum, 1, await widget.memberManager.jwtManager.getToken());
        } else {
          null;
        }
      },
      onPressedNo: () async {
        if(!isClicked){
          setState(() {
            isClicked = true;
          });
          AfterClickedButton().afterDo(context, SurveyPage10(
              qNum: 'Q10.',
              question: '\n비듬이 많아지고 두피가 가렵다',
              memberManager: widget.memberManager,
              diagnoseManager: widget.diagnoseManager
          ), widget.diagnoseManager, widget.qNum, 0, await widget.memberManager.jwtManager.getToken());
        } else {
          null;
        }
      },
    );
    return surveyPageMock.build(context);
  }
}

/// 2022.03.08 이승훈
/// 설문조사 페이지 10
class SurveyPage10 extends StatefulWidget {
  final String qNum;
  final String question;
  final JBMBMemberManager memberManager;
  final JBMBDiagnoseManager diagnoseManager;

  const SurveyPage10({Key? key,
    required this.qNum,
    required this.question,
    required this.memberManager,
    required this.diagnoseManager})
      : super(key: key);

  @override
  _SurveyPage10State createState() => _SurveyPage10State();
}

class _SurveyPage10State extends State<SurveyPage10>{
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: widget.qNum,
      question: widget.question,
      onPressedYes: () async {
        if(!isClicked){
          setState(() {
            isClicked = true;
          });
          AfterClickedButton().afterLast(context, UploadImageGuidePage(
            memberManager: widget.memberManager,
            diagnoseManager: widget.diagnoseManager,
          ), widget.diagnoseManager, widget.qNum, 1, await widget.memberManager.jwtManager.getToken());
        } else {
          null;
        }
      },
      onPressedNo: () async {
        if(!isClicked){
          setState(() {
            isClicked = true;
          });
          AfterClickedButton().afterLast(context, UploadImageGuidePage(
            memberManager: widget.memberManager,
            diagnoseManager: widget.diagnoseManager,
          ), widget.diagnoseManager, widget.qNum, 0, await widget.memberManager.jwtManager.getToken());
        } else {
          null;
        }
      },
    );
    return surveyPageMock.build(context);
  }
}
