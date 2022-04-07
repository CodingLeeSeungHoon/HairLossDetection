import 'package:flutter/material.dart';
import 'package:jbmb_application/object/JBMBMemberInfo.dart';
import 'package:jbmb_application/screen/UploadImagePage.dart';
import 'package:jbmb_application/service/JBMBDiagnoseManager.dart';
import 'package:jbmb_application/service/JBMBMemberManager.dart';
import 'package:jbmb_application/widget/JBMBOutlinedButton.dart';

import '../widget/JBMBAppBars.dart';

class UploadImageGuidePage extends StatelessWidget {
  final JBMBMemberManager memberManager;
  final JBMBDiagnoseManager diagnoseManager;

  const UploadImageGuidePage({
    Key? key,
    required this.memberManager,
    required this.diagnoseManager
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery
        .of(context)
        .size
        .width;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: JBMBAppBarWithOutMenu(),
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                              "\n이미지 업로드\n"
                                  "가이드라인 ",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: phoneWidth / 3,
                              width: phoneWidth / 3,
                              child: Image.asset('images/takephoto.png'),
                            ),
                            SizedBox(
                              height: phoneWidth / 3,
                              width: phoneWidth / 3,
                              child: Image.asset('images/forehead.png'),
                            )
                          ],
                        ),
                        const Text("카메라 이용 방법\n"
                            "1) 이마라인이 전부 보이게 헤어밴드를 착용하고 정면 방향으로 사진을 촬영합니다.\n"
                            "2) 촬영 이후, 편집 모드에서 이마 부분(눈썹 위 기준) 이미지를 편집해줍니다.\n\n"
                            "앨범 업로드 이용 방법\n"
                            "1) 이마라인이 전부 보이는 정면 방향 이미지를 선택합니다.\n"
                            "2) 선택 이후, 편집 모드에서 이마 부분(눈썹 위 기준) 이미지를 편집해줍니다.\n"),
                        JBMBOutlinedButton(
                          buttonText: '인지 완료',
                          iconData: Icons.check,
                          onPressed: () {
                            Future.delayed(const Duration(milliseconds: 250),
                                    () {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                          UploadImagePage(
                                            memberManager: memberManager,
                                            diagnoseManager: diagnoseManager
                                          ),
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                    ),
                                  );
                                });
                          },
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
        onWillPop: () {
          return Future(() => false);
        });
  }
}
