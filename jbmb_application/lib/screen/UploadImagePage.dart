import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jbmb_application/screen/DiagnosisResultPage.dart';
import 'package:jbmb_application/service/JBMBDiagnoseManager.dart';
import 'package:jbmb_application/service/JBMBMemberManager.dart';
import 'package:jbmb_application/widget/JBMBOutlinedButton.dart';
import 'package:jbmb_application/widget/JBMBUploadedImage.dart';

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
                          if (imageUrl != '')
                            JBMBOutlinedButton(
                              buttonText: '제출하기',
                              iconData: Icons.subject,
                              onPressed: () async {
                                // TODO : submit images and get result
                                bool imgRetVal = await widget.diagnoseManager
                                    .submitImageUrl(
                                        imageUrl,
                                        widget.memberManager.jwtManager
                                            .getToken());
                                if (imgRetVal){
                                  bool analRetVal = await widget.diagnoseManager.startAnalysis(widget.memberManager.jwtManager.getToken());
                                  if (analRetVal) {
                                    // when success submit image and start analysis
                                    Future.delayed(
                                        const Duration(milliseconds: 250), () {
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder:
                                              (context, animation1, animation2) =>
                                              DiagnosisResultPage(
                                                memberManager: widget.memberManager,
                                                way: 1,
                                              ),
                                          transitionDuration: Duration.zero,
                                          reverseTransitionDuration: Duration.zero,
                                        ),
                                      );
                                    });
                                  } else {
                                    log("[DIAGNOSE ERROR] failed start analysis");
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("분석 시작에 실패했습니다.")));
                                  }
                                } else {
                                  log("[IMG ERROR] failed submit ImageURL");
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("이미지 제출에 실패했습니다.")));
                                  // may be go to main page?
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
}
