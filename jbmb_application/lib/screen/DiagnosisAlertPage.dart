import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jbmb_application/screen/LoginedHome.dart';
import 'package:jbmb_application/screen/SurveyPage1.dart';

import '../widget/JBMBBigLogo.dart';

class DiagnosisAlertPage extends StatefulWidget {
  const DiagnosisAlertPage({Key? key}) : super(key: key);

  @override
  _DiagnosisAlertPageState createState() => _DiagnosisAlertPageState();
}

class _DiagnosisAlertPageState extends State<DiagnosisAlertPage> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;
    double phonePadding = MediaQuery.of(context).padding.top;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                Future.delayed(const Duration(milliseconds: 300), () {
                  Navigator.pop(context);
                });
              },
            ),
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            title: const Text(
              "제발모발",
              style: TextStyle(
                  fontSize: 23,
                  color: Colors.black,
                  fontFamily: 'Gugi-Regular',
                  fontWeight: FontWeight.bold),
            ),
            // AppBar 내 요소 가운데 정렬
            centerTitle: true,
            // AppBar 그림자 제거
          ),
          body: Scrollbar(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  JBMBBigLogo(),
                  Stepper(
                    physics: NeverScrollableScrollPhysics(),
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
                        content:
                            Text('제발모발(JBMB)에서 제공하는 자가진단 서비스는 공식적인 의료법에 의한 진단이 아닌 '
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
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SurveyPage1(),
                        ));
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
                                  title: Text("주의"),
                                  content: Text("현재 화면을 나가시겠습니까?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("아니오")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => LoginedHome(),
                                          ));
                                        },
                                        child: Text("네")),
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
