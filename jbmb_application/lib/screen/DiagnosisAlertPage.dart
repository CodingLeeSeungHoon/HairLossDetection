import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jbmb_application/object/JBMBMemberInfo.dart';
import 'package:jbmb_application/screen/LoginedHome.dart';
import 'package:jbmb_application/screen/SurveyCustomPage.dart';
import 'package:jbmb_application/screen/SurveyPages.dart';
import 'package:jbmb_application/service/JBMBDiagnoseManager.dart';
import 'package:jbmb_application/service/JBMBMemberManager.dart';

import '../widget/JBMBAppBars.dart';
import '../widget/JBMBBigLogo.dart';

/// 2022.03.08 이승훈
/// 무료 자가진단 입장 시, 주의사항에 대해 설명하는 페이지
class DiagnosisAlertPage extends StatefulWidget {
  final JBMBMemberManager memberManager;
  final JBMBDiagnoseManager diagnoseManager;

  const DiagnosisAlertPage(
      {Key? key, required this.memberManager, required this.diagnoseManager})
      : super(key: key);

  @override
  _DiagnosisAlertPageState createState() => _DiagnosisAlertPageState();
}

class _DiagnosisAlertPageState extends State<DiagnosisAlertPage> {
  // Stepper Index
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // Disable BackButton
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: JBMBTransparentAppbar(onPressedCancel: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Future.delayed(const Duration(milliseconds: 300), () {
              Navigator.pop(context);
            });
          }),
          body: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const JBMBBigLogo(),
                  Stepper(
                    // physics: const NeverScrollableScrollPhysics(),
                    // Custom Stepper Button - controlsBuilder
                    controlsBuilder: (context, controlBuilder) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextButton(
                            onPressed: controlBuilder.onStepContinue,
                            child: const Text(
                              "확인",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: controlBuilder.onStepCancel,
                            child: const Text(
                              "취소",
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      );
                    },
                    steps: const [
                      Step(
                          title: Text('1. 진단 순서 안내'),
                          content: Text('진단 순서는 다음과 같습니다. \n\n'
                              '1) 10가지의 O, X 형식으로 이루어진 설문조사\n'
                              '2) 탈모 의심 이미지 촬영 혹은 업로드\n\n'
                              '모든 입력이 끝나면 설문조사 결과와 이미지 분석의 결과를 '
                              '보실 수 있습니다. 모든 과정을 완료한 진단에 대해서는 '
                              '자가진단 기록에 들어가시면 다시 보실 수 있습니다.\n')),
                      Step(
                          title: Text('2. 정보 제공 동의'),
                          content: Text(
                              '제발모발(JBMB)은 사용자의 설문조사 결과와 이미지 데이터를 저장합니다.\n\n'
                              '정보 제공 동의를 해야 본 서비스를 이용할 수 있으며, '
                              '진단 이외의 목적으로 사용하지 않을 것을 약속드립니다.\n')),
                      Step(
                        title: Text('3. 진단 유의 사항'),
                        content: Text(
                            '제발모발(JBMB)에서 제공하는 자가진단 서비스는 공식적인 의료법에 의한 진단이 아닌 '
                            'AI 이미지 분류를 통한 자가 진단이므로 의료적 효력이 없습니다. \n\n'
                            '따라서 정확한 진료와 치료를 위해서는 가까운 병원을 내원하는 것을 권장합니다.\n\n'
                            '최종 확인 버튼을 누르면, 자가진단이 시작됩니다.\n'),
                      )
                    ],
                    currentStep: _currentStep,
                    onStepContinue: () {
                      if (_currentStep != 2) {
                        setState(() {
                          _currentStep += 1;
                        });
                      } else {
                        // when confirm all step
                        Navigator.pop(context);
                        // delay for button animation
                        Future.delayed(const Duration(milliseconds: 250), () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  SurveyPage1(
                                qNum: 'Q1.',
                                question: '\n하루에 빠지는 모발 양이 100개 이상이다.',
                                memberManager: widget.memberManager,
                                diagnoseManager: widget.diagnoseManager,
                              ),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );
                        });
                      }
                    },
                    onStepCancel: () {
                      if (_currentStep != 0) {
                        setState(() {
                          _currentStep -= 1;
                        });
                      } else {
                        showDialog(
                            context: context,
                            builder: (_) => CupertinoAlertDialog(
                                  // ios friendly - CupertinoAlertDialog
                                  title: const Text("주의"),
                                  content: const Text("현재 화면을 나가시겠습니까?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("아니오")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => LoginedHome(
                                              memberManager:
                                                  widget.memberManager,
                                            ),
                                          ));
                                        },
                                        child: const Text("네")),
                                  ],
                                ));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () {
          return Future(() => false);
        });
  }
}
