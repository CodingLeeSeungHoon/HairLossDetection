import 'package:flutter/material.dart';
import 'package:jbmb_application/screen/DiagnosisResultPage.dart';
import 'package:jbmb_application/widget/JBMBOutlinedButton.dart';
import 'package:jbmb_application/widget/JBMBUploadedImage.dart';

import '../object/JBMBMemberInfo.dart';
import '../widget/JBMBAppBars.dart';

class UploadImagePage extends StatefulWidget {
  final JBMBMemberInfo jbmbMemberInfo;
  const UploadImagePage({
    Key? key,
    required this.jbmbMemberInfo
  }) : super(key: key);

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
                              SizedBox(height: 10,),
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
                          JBMBUploadedImage(
                            onFileChanged: (imageUrl) {
                              setState(() {
                                this.imageUrl = imageUrl;
                              });
                            },
                          ),
                          if (imageUrl != '')
                            JBMBOutlinedButton(
                              buttonText: '제출하기',
                              iconData: Icons.subject,
                              onPressed: () {
                                Future.delayed(const Duration(milliseconds: 250), (){
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation1, animation2) => DiagnosisResultPage(jbmbMemberInfo: widget.jbmbMemberInfo, way: 1,),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                                });
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
