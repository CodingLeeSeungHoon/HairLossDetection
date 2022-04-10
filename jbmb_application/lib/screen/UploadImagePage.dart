import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jbmb_application/object/JBMBDiagnosisResponseObject.dart';
import 'package:jbmb_application/screen/DiagnosisResultPage.dart';
import 'package:jbmb_application/service/JBMBDiagnoseManager.dart';
import 'package:jbmb_application/service/JBMBMemberManager.dart';
import 'package:jbmb_application/widget/JBMBOutlinedButton.dart';
import 'package:jbmb_application/widget/JBMBUploadedImage.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../object/JBMBMemberInfo.dart';
import '../widget/JBMBAppBars.dart';

class UploadImagePage extends StatefulWidget {
  final JBMBMemberManager memberManager;
  final JBMBDiagnoseManager diagnoseManager;

  const UploadImagePage(
      {Key? key, required this.memberManager, required this.diagnoseManager})
      : super(key: key);

  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  String imageUrl = '';
  int loadingState = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: JBMBAppBarWithOutMenu(),
          body: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "탈모로 의심가는 이미지를\n"
                                "촬영하거나 갤러리에서 \n업로드 해주세요.",
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.black54,
                                    fontFamily: 'NanumGothic-Regular',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 2,
                              )
                            ],
                          ))),
                  Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (loadingState == 0)
                            JBMBUploadedImageWidget(
                              onFileChanged: (imageUrl) {
                                setState(() {
                                  this.imageUrl = imageUrl;
                                  log("[imageURL] " + this.imageUrl);
                                });
                              },
                              diagnosisID: widget.diagnoseManager.diagnosisID,
                              userID: widget.memberManager.memberInfo.getID,
                            ),
                          if (loadingState == 1) ...[
                            const Text("제발모발 서버에 이미지를 저장 중 입니다."),
                            const Text("잠시만 기다려주세요."),
                            StepIndicator(
                              currentStep: 0,
                            )
                          ],
                          if (loadingState == 2) ...[
                            const Text("결과를 분석 및 저장 중 입니다."),
                            const Text("최대 20초정도 소요될 수 있습니다."),
                            StepIndicator(
                              currentStep: 1,
                            )
                          ],
                          if (loadingState == 3) ...[
                            const Text("결과를 불러오고 있습니다."),
                            const Text("잠시만 기다려주세요."),
                            StepIndicator(
                              currentStep: 2,
                            )
                          ],
                          if (imageUrl != '')
                            JBMBOutlinedButton(
                              buttonText: '제출하기',
                              iconData: Icons.subject,
                              onPressed: () async {
                                var object = await doAfterSubmit(
                                    context,
                                    widget.diagnoseManager,
                                    widget.memberManager,
                                    imageUrl);
                                if (object[1] == 0) {
                                  Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation1, animation2) =>
                                                DiagnosisResultPage(
                                          memberManager: widget.memberManager,
                                          resultObject: object[0]
                                              as JBMBDiagnosisResultResponseObject,
                                          way: 1,
                                        ),
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ));
                                } else {
                                  doActionByErrorCode(
                                      context, object[1] as int);
                                }
                              },
                            )
                        ],
                      ))
                ],
              )),
        ),
        onWillPop: () {
          return Future(() => false);
        });
  }

  /// 2022.04.07 이승훈
  /// do this action after clicked submit button
  /// 1. submitImageUrl
  /// 2. startAnalysis
  /// 3. getDiagnosisResultDirectly
  /// with step progress indicator
  Future<List<Object?>> doAfterSubmit(
      BuildContext context,
      JBMBDiagnoseManager diagnoseManager,
      JBMBMemberManager memberManager,
      String imageURL) async {
    setState(() {
      loadingState = 1;
    });
    bool imgRetVal = await diagnoseManager.submitImageUrl(
        imageURL, memberManager.jwtManager.getToken());
    if (imgRetVal) {
      setState(() {
        loadingState = 2;
      });
      bool analRetVal = await diagnoseManager
          .startAnalysis(memberManager.jwtManager.getToken());
      if (analRetVal) {
        // when success submit image and start analysis
        setState(() {
          loadingState = 3;
        });
        JBMBDiagnosisResultResponseObject? object = diagnoseManager
            .getDiagnosisResultDirectly(memberManager.jwtManager.getToken());
        if (object != null) {
          return [object, 0];
        } else {
          setState(() {
            loadingState = 0;
          });
          log("[DIAGNOSE ERROR] failed getting analysis data");
          return [null, 3];
        }
      } else {
        setState(() {
          loadingState = 0;
        });
        log("[DIAGNOSE ERROR] failed start analysis");
        return [null, 2];
      }
    } else {
      setState(() {
        loadingState = 0;
      });
      log("[IMG ERROR] failed submit ImageURL");
      return [null, 1];
    }
  }

  /// 2022.04.07 이승훈
  /// doAfterSubmit에서 나온 ErrorCode에 따른 스낵바 액션
  doActionByErrorCode(BuildContext context, int errorCode) {
    switch (errorCode) {
      case 1:
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("이미지 제출에 실패했습니다.")));
        break;
      case 2:
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("분석 시작에 실패했습니다.")));
        break;
      case 3:
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("데이터 불러오기에 실패했습니다.")));
        break;
    }
  }
}


/// 2022.04.07 이승훈
/// 로딩 인디케이터
class StepIndicator extends StatelessWidget {
  int currentStep;

  StepIndicator({Key? key, required this.currentStep}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StepProgressIndicator(
      totalSteps: 3,
      currentStep: currentStep,
      size: 20,
      selectedColor: Colors.black,
      unselectedColor: Colors.grey,
      customStep: (index, color, _) => color == Colors.black
          ? Container(
              color: color,
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            )
          : Container(
              color: color,
              child: const Icon(
                Icons.remove,
              ),
            ),
    );
  }
}
