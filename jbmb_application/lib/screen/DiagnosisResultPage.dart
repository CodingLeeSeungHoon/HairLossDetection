import 'package:flutter/material.dart';
import 'package:jbmb_application/object/JBMBMemberInfo.dart';
import 'package:jbmb_application/screen/LoginedHome.dart';
import 'package:jbmb_application/service/JBMBMemberManager.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../object/JBMBDiagnosisResponseObject.dart';
import '../widget/JBMBAppBars.dart';

class DiagnosisResultPage extends StatefulWidget {
  final JBMBMemberManager memberManager;
  final int way;
  final JBMBDiagnosisResultResponseObject resultObject;

  const DiagnosisResultPage(
      {Key? key,
      required this.memberManager,
      required this.way,
      required this.resultObject})
      : super(key: key);

  @override
  _DiagnosisResultPageState createState() => _DiagnosisResultPageState();
}

class _DiagnosisResultPageState extends State<DiagnosisResultPage> {
  DiagnosisConverter converter = DiagnosisConverter();

  @override
  Widget build(BuildContext context) {
    TextStyle mildTitleTextStyle = const TextStyle(
        decoration: TextDecoration.underline,
        fontSize: 23,
        color: Colors.black45,
        fontFamily: 'NanumGothic-Regular',
        fontWeight: FontWeight.bold);

    TextStyle titleTextStyle = const TextStyle(
        fontSize: 23,
        color: Colors.black,
        fontFamily: 'NanumGothic-Regular',
        fontWeight: FontWeight.bold);

    TextStyle textStyle = const TextStyle(
        fontSize: 17, color: Colors.black, fontFamily: 'NanumGothic-Regular');

    TextStyle indicatorTextStyle = const TextStyle(
        fontSize: 53,
        color: Colors.black54,
        fontFamily: 'NanumGothic-Regular',
        fontWeight: FontWeight.bold);

    // TODO : change this and change object including date
    String diagnosisDate = '(2022-03-10 18:30:23)';
    double phoneWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: JBMBTransparentAppbar(onPressedCancel: () {
            if (widget.way == 1) {
              Future.delayed(const Duration(milliseconds: 250), () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        LoginedHome(
                      memberManager: widget.memberManager,
                    ),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              });
            } else {
              Navigator.of(context).pop();
            }
          }),
          body: Scrollbar(
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      children: [
                        Text(widget.memberManager.memberInfo.getName!,
                            style: mildTitleTextStyle),
                        Text(" 님의", style: titleTextStyle)
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("진단 결과입니다.\n", style: titleTextStyle),
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    Row(
                      children: [
                        Text(
                          "\n",
                          style: textStyle,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.black,
                        ),
                        Text(
                          " 설문조사 결과\n" + diagnosisDate,
                          style: textStyle,
                        ),
                      ],
                    ),
                    SfRadialGauge(axes: <RadialAxis>[
                      RadialAxis(
                          minimum: 0,
                          maximum: 100,
                          showLabels: false,
                          showTicks: false,
                          axisLineStyle: const AxisLineStyle(
                            thickness: 0.2,
                            cornerStyle: CornerStyle.bothCurve,
                            color: Colors.black12,
                            thicknessUnit: GaugeSizeUnit.factor,
                          ),
                          pointers: <GaugePointer>[
                            RangePointer(
                              enableAnimation: true,
                              color: Colors.black45,
                              value: converter.getGaugeBySurveyCheckedCount(
                                  widget.resultObject.surveyResult!),
                              cornerStyle: CornerStyle.bothCurve,
                              width: 0.2,
                              sizeUnit: GaugeSizeUnit.factor,
                            )
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                positionFactor: 0.1,
                                angle: 90,
                                widget: Text(
                                  converter.getStateBySurveyCheckedCount(
                                      widget.resultObject.surveyResult!),
                                  style: indicatorTextStyle,
                                ))
                          ])
                    ]),
                    Text(
                        "설문조사 결과 체크 ${widget.resultObject.surveyResult}개로 ${converter.getStateBySurveyCheckedCount(widget.resultObject.surveyResult!)}입니다."),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          "\n",
                          style: textStyle,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.black,
                        ),
                        Text(
                          " AI 이미지 분석 결과\n" + diagnosisDate,
                          style: textStyle,
                        ),
                      ],
                    ),
                    SfRadialGauge(axes: <RadialAxis>[
                      RadialAxis(
                          minimum: 0,
                          maximum: 100,
                          showLabels: false,
                          showTicks: false,
                          axisLineStyle: const AxisLineStyle(
                            thickness: 0.2,
                            cornerStyle: CornerStyle.bothCurve,
                            color: Colors.black12,
                            thicknessUnit: GaugeSizeUnit.factor,
                          ),
                          pointers: const <GaugePointer>[
                            RangePointer(
                              enableAnimation: true,
                              color: Colors.black45,
                              // TODO : change variable
                              value: 70,
                              cornerStyle: CornerStyle.bothCurve,
                              width: 0.2,
                              sizeUnit: GaugeSizeUnit.factor,
                            )
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                positionFactor: 0.1,
                                angle: 90,
                                // TODO : change this
                                widget: Text(
                                  "정상",
                                  style: indicatorTextStyle,
                                ))
                          ])
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.arrow_back),
                        Text("양 쪽으로 스크롤 할 수 있습니다."),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(
                            label: Center(
                                child: Text(
                              'M0',
                              textAlign: TextAlign.center,
                            )),
                          ),
                          DataColumn(
                            label: Center(
                                child: Text(
                              'M1',
                              textAlign: TextAlign.center,
                            )),
                          ),
                          DataColumn(
                            label: Center(
                                child: Text(
                              'M2',
                              textAlign: TextAlign.center,
                            )),
                          ),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(
                              Center(
                                  child: Text(
                                '${widget.resultObject.percent![0]}%',
                                textAlign: TextAlign.center,
                              )),
                            ),
                            DataCell(
                              Center(
                                  child: Text(
                                '${widget.resultObject.percent![1]}%',
                                textAlign: TextAlign.center,
                              )),
                            ),
                            DataCell(
                              Center(
                                  child: Text(
                                '${widget.resultObject.percent![2]}%',
                                textAlign: TextAlign.center,
                              )),
                            ),
                          ])
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "\n",
                          style: textStyle,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.black,
                        ),
                        Text(
                          " 통합 결과\n",
                          style: textStyle,
                        ),
                      ],
                    ),
                    Container(
                      width: phoneWidth * 0.85,
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(color: Colors.black12),
                      child: const Text(
                          "- 설문 결과는 국민 건강 보험에서 제시한 기준을 토대로 만들어졌습니다.\n"
                          "- AI 이미지 분석의 경우, 이미지 업로드 가이드라인을 제대로 지키지 않으면 정상적이지 않은 결과가 나올 수 있습니다.\n"
                          "- AI 이미지 분석에서 좋은 결과가 있더라도, 설문조사의 결과가 좋지 않으면 탈모가 진행 중일 가능성이 높습니다.\n"
                          "- 본 진단은 법적인 의료 효력이 없기 때문에 정확한 진단은 가까운 병원을 내원하시기 바랍니다."),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: () {
          return Future(() => false);
        });
  }
}

/// 2022.04.07 이승훈
/// 설문조사 체크 수, 이미지 라벨, 총평을 화면 구성에 맞게 변환해주는 클래스
class DiagnosisConverter {
  String getStateBySurveyCheckedCount(int count) {
    if (count < 3) {
      return "정상";
    } else if (count < 4) {
      return "의심";
    } else if (count < 6) {
      return "진행";
    } else {
      return "위험";
    }
  }

  double getGaugeBySurveyCheckedCount(int count) {
    if (count < 3) {
      return 25;
    } else if (count < 4) {
      return 45;
    } else if (count < 6) {
      return 70;
    } else {
      return 90;
    }
  }

  String? getStateByLabel(int label){
    switch(label){
      case 0:
        return 'M0';
      case 1:
        return 'M1';
      case 2:
        return 'M2';
    }
    return null;
  }

  double getGaugeByLabel(int label){
    if (label == 0){
      return 30;
    } else if (label == 1) {
      return 60;
    } else {
      return 90;
    }
  }

  String? getWholeResult(int count, int label){

  }
}
