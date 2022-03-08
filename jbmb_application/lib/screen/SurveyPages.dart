import 'package:flutter/material.dart';
import 'package:jbmb_application/screen/SurveyCustomPage.dart';

class SurveyPage1 extends StatelessWidget {
  final String qNum;
  final String question;

  const SurveyPage1({Key? key, required this.qNum, required this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: qNum,
      question: question,
      onPressedYes: () {
        Future.delayed(const Duration(milliseconds: 250), (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const SurveyPage2(
                qNum: 'Q2.',
                question: '\n전보다 점점 이마가 넓어지는 느낌이 든다',
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        });
      },
      onPressedNo: () {
        Future.delayed(const Duration(milliseconds: 250), (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const SurveyPage2(
                qNum: 'Q2.',
                question: '\n전보다 점점 이마가 넓어지는 느낌이 든다',
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        });
      },
    );
    return surveyPageMock.build(context);
  }
}

class SurveyPage2 extends StatelessWidget {
  final String qNum;
  final String question;

  const SurveyPage2({Key? key, required this.qNum, required this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: qNum,
      question: question,
      onPressedYes: () {
        Future.delayed(const Duration(milliseconds: 250), (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const SurveyPage3(
                qNum: 'Q3.',
                question: '\n가늘고 힘이 없는 머리가 빠지기 시작한다.',
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        });
      },
      onPressedNo: () {
        Future.delayed(const Duration(milliseconds: 250), (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const SurveyPage3(
                qNum: 'Q3.',
                question: '\n가늘고 힘이 없는 머리가 빠지기 시작한다.',
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        });
      },
    );
    return surveyPageMock.build(context);
  }
}

class SurveyPage3 extends StatelessWidget {
  final String qNum;
  final String question;

  const SurveyPage3({Key? key, required this.qNum, required this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: qNum,
      question: question,
      onPressedYes: () {
        Future.delayed(const Duration(milliseconds: 250), (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const SurveyPage4(
                qNum: 'Q4.',
                question: '\n모발이 가늘고 부드러워진다.',
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        });
      },
      onPressedNo: () {
        Future.delayed(const Duration(milliseconds: 250), (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const SurveyPage4(
                qNum: 'Q4.',
                question: '\n모발이 가늘고 부드러워진다.',
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        });
      },
    );
    return surveyPageMock.build(context);
  }
}

class SurveyPage4 extends StatelessWidget {
  final String qNum;
  final String question;

  const SurveyPage4({Key? key, required this.qNum, required this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: qNum,
      question: question,
      onPressedYes: () {
        Future.delayed(const Duration(milliseconds: 250), (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const SurveyPage5(
                qNum: 'Q5.',
                question: '\n두피를 누르면 통증이 있다.',
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        });
      },
      onPressedNo: () {
        Future.delayed(const Duration(milliseconds: 250), (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const SurveyPage5(
                qNum: 'Q5.',
                question: '\n두피를 누르면 통증이 있다.',
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        });
      },
    );
    return surveyPageMock.build(context);
  }
}

class SurveyPage5 extends StatelessWidget {
  final String qNum;
  final String question;

  const SurveyPage5({Key? key, required this.qNum, required this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: qNum,
      question: question,
      onPressedYes: () {
        Future.delayed(const Duration(milliseconds: 250), (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const SurveyPage6(
                qNum: 'Q6.',
                question: '\n앞 머리와 뒷 머리의 굵기 차이가 있다',
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        });
      },
      onPressedNo: () {
        Future.delayed(const Duration(milliseconds: 250), (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const SurveyPage6(
                qNum: 'Q6.',
                question: '\n앞 머리와 뒷 머리의 굵기 차이가 있다',
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        });
      },
    );
    return surveyPageMock.build(context);
  }
}

class SurveyPage6 extends StatelessWidget {
  final String qNum;
  final String question;

  const SurveyPage6({Key? key, required this.qNum, required this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: qNum,
      question: question,
      onPressedYes: () {
        Future.delayed(const Duration(milliseconds: 250), (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const SurveyPage7(
                qNum: 'Q7.',
                question: '\n몸의 털이 갑자기 굵어진다',
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        });
      },
      onPressedNo: () {
        Future.delayed(const Duration(milliseconds: 250), (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const SurveyPage7(
                qNum: 'Q7.',
                question: '\n몸의 털이 갑자기 굵어진다',
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        });
      },
    );
    return surveyPageMock.build(context);
  }
}

class SurveyPage7 extends StatelessWidget {
  final String qNum;
  final String question;

  const SurveyPage7({Key? key, required this.qNum, required this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: qNum,
      question: question,
      onPressedYes: () {
        Future.delayed(const Duration(milliseconds: 250), (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const SurveyPage8(
                qNum: 'Q8.',
                question: '\n이마라인과 정수리 부분의 유난히 번들거린다',
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        });
      },
      onPressedNo: () {
        Future.delayed(const Duration(milliseconds: 250), (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const SurveyPage8(
                qNum: 'Q8.',
                question: '\n이마라인과 정수리 부분의 유난히 번들거린다',
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        });
      },
    );
    return surveyPageMock.build(context);
  }
}

class SurveyPage8 extends StatelessWidget {
  final String qNum;
  final String question;

  const SurveyPage8({Key? key, required this.qNum, required this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: qNum,
      question: question,
      onPressedYes: () {
        Future.delayed(const Duration(milliseconds: 250), (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const SurveyPage9(
                qNum: 'Q9.',
                question: '\n두피의 피지량이 갑자기 늘어났다',
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        });
      },
      onPressedNo: () {
        Future.delayed(const Duration(milliseconds: 250), (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const SurveyPage9(
                qNum: 'Q9.',
                question: '\n두피의 피지량이 갑자기 늘어났다',
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        });
      },
    );
    return surveyPageMock.build(context);
  }
}

class SurveyPage9 extends StatelessWidget {
  final String qNum;
  final String question;

  const SurveyPage9({Key? key, required this.qNum, required this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: qNum,
      question: question,
      onPressedYes: () {
        Future.delayed(const Duration(milliseconds: 250), (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const SurveyPage10(
                qNum: 'Q10.',
                question: '\n비듬이 많아지고 두피가 가렵다',
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        });
      },
      onPressedNo: () {
        Future.delayed(const Duration(milliseconds: 250), (){
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const SurveyPage10(
                qNum: 'Q10.',
                question: '\n비듬이 많아지고 두피가 가렵다',
              ),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        });
      },
    );
    return surveyPageMock.build(context);
  }
}

class SurveyPage10 extends StatelessWidget {
  final String qNum;
  final String question;

  const SurveyPage10({Key? key, required this.qNum, required this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SurveyCustomPage surveyPageMock = SurveyCustomPage(
      qNum: qNum,
      question: question,
      onPressedYes: () {
      },
      onPressedNo: () {
      },
    );
    return surveyPageMock.build(context);
  }
}
