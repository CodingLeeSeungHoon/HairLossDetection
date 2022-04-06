import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jbmb_application/widget/JBMBBigButton.dart';

import '../widget/JBMBAppBars.dart';

/// 2022.03.08 이승훈
/// 설문조사 페이지 클래스화
class SurveyCustomPage {
  // question number with 'Q' + number + '.'
  final String qNum;

  // question script
  final String question;

  // when press button 'O'
  final VoidCallback? onPressedYes;

  // when press button 'X'
  final VoidCallback? onPressedNo;

  const SurveyCustomPage({
    Key? key,
    required this.qNum,
    required this.question,
    this.onPressedYes,
    this.onPressedNo
  });

  /// build Custom Survey UI in this [context]
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: JBMBAppBarWithOutMenu(),
          body: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          qNum,
                          style: const TextStyle(
                              fontFamily: 'NanumGothic-Regular',
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          question,
                          style: const TextStyle(
                            fontFamily: 'NanumGothic-Regular',
                            fontSize: 26,
                          ),
                        ),
                      ],
                    )
                ),
                Divider(thickness: 2,),
                Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        JBMBBigButton(
                          buttonText: 'O', onPressed: onPressedYes,),
                        JBMBBigButton(buttonText: 'X',
                          onPressed: onPressedNo,
                          backgroundColor: Colors.white,
                          elementColor: Colors.black,),
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
