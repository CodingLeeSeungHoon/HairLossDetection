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

    String diagnosisDate = widget.resultObject.getDate!;
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
                                  widget.resultObject.getSurveyResult!),
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
                                      widget.resultObject.getSurveyResult!),
                                  style: indicatorTextStyle,
                                ))
                          ])
                    ]),
                    Text(
                        "설문조사 결과 체크 ${widget.resultObject.getSurveyResult}개로 ${converter.getStateBySurveyCheckedCount(widget.resultObject.getSurveyResult!)}입니다."),
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
                          pointers: <GaugePointer>[
                            RangePointer(
                              enableAnimation: true,
                              color: Colors.black45,
                              value: converter.getGaugeByLabel(converter.getLabelByPercent(widget.resultObject.getPercent!)),
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
                                  converter.getStateByLabel(converter.getLabelByPercent(widget.resultObject.getPercent!)),
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
                                '${widget.resultObject.getPercent![0]}%',
                                textAlign: TextAlign.center,
                              )),
                            ),
                            DataCell(
                              Center(
                                  child: Text(
                                '${widget.resultObject.getPercent![1]}%',
                                textAlign: TextAlign.center,
                              )),
                            ),
                            DataCell(
                              Center(
                                  child: Text(
                                '${widget.resultObject.getPercent![2]}%',
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
                    converter.getWholeResult(widget.resultObject.getSurveyResult!, converter.getLabelByPercent(widget.resultObject.getPercent!)),
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

  /// 설문조사 체크 수 기준으로 설문조사 결과를 불러오는 메소드
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

  /// 설문조사 체크 수 기준으로 게이지 양을 받아올 수 있는 메소드
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

  /// classification label에 따라서 진단 결과를 받아올 수 있는 메소드
  String getStateByLabel(int label){
    if (label == 0){
      return 'M0';
    } else if (label == 1){
      return 'M1';
    } else {
      return 'M2';
    }
  }

  /// classification label에 따라서 게이지 양을 받아올 수 있는 메소드
  double getGaugeByLabel(int label){
    if (label == 0){
      return 30;
    } else if (label == 1) {
      return 60;
    } else {
      return 90;
    }
  }

  /// 설문조사 count와 classification label을 기준으로
  /// 통합 결과를 불러올 수 있는 메소드
  Text getWholeResult(int count, int label){
    String text = "";
    switch(label){
      case 0:
        if (count < 3){
          // M0 진단, 설문조사 정상
          text = "설문조사와 이미지 분류 진단 모두 정상 판정입니다. "
              "M0은 BASP(한국형 탈모 진단법)의 정상 범주에 속하는 것으로, 정상적인 이마라인을 가진 상태를 의미합니다. "
              "지금의 두피와 모발을 잘 관리해 유지하시기 바랍니다. \n"
              "권장드리는 사항으로는, 일반적인 샴푸를 사용하지 않고, 자신의 두피에 맞는 샴푸를 선택해 관리한다면 "
              "오랫동안 현 상태를 유지할 수 있을 것으로 보입니다.\n"
              "경고 : 본 진단은 의료적 효력이 없으므로 무조건적으로 신뢰할 수 없으며, "
              "추가적인 진단이 필요하다고 느낀다면 꼭 근처 병원을 방문하시기를 권장드립니다.";
        } else {
          // M0 진단이지만, 설문조사 탈모 의심 이상
          text = "이미지 분류 진단의 경우 정상이지만, 설문조사의 경우 '의심' 이상이 나왔습니다. "
              "M0은 BASP(한국형 탈모 진단법)의 정상 범주에 속하는 것으로, 정상적인 이마라인을 가진 상태를 의미합니다. "
              "그러나, 설문조사 결과에 따르면, 탈모가 진행 중이거나, 의심되는 상황입니다. "
              "이미지 분류 진단은 촬영한 각도에 따라 많은 영향을 받기 때문에 재촬영으로 추가 진단을 받고, "
              "근처 병원을 내원하시어 진료를 꼭 받는 것을 권장드립니다. 탈모는 조기 치료가 가장 중요합니다. \n"
              "권장 드리는 사항으로는, 가까운 병원 혹은 탈모 관리센터 내원하시길 바랍니다. 또한 일반적인 샴푸를 사용한다면,"
              "두피 타입에 맞는 건성/지성 '두피샴푸'로 변경하고, 주기적인 '스케일링'을 받는 것을 권장드립니다.\n"
              "경고 : 본 진단은 의료적 효력이 없으므로 무조건적으로 신뢰할 수 없으며, "
              "추가적인 진단이 필요하다고 느낀다면 꼭 근처 병원을 방문하시기를 권장드립니다.";
        }
        break;
      case 1:
        if (count < 3){
          // M1 진단, 설문조사의 경우 정상
          text = "회원님의 상태가 M1으로 분류되었습니다."
              "M1은 BASP(한국형 탈모 진단법)의 탈모 초기에 속하는 것으로, 정상적인 이마라인보다 끝 부분이 살짝 올라와 "
              "작은 M자의 형태를 갖는 것을 의미합니다. 그러나, 이미지 분류 진단은 촬영한 각도에 따라 많은 영향을 받기 때문에 "
              "재촬영으로 추가 진단을 받고, 근처 병원을 내원하시어 진료를 꼭 받는 것을 권장드립니다. 탈모는 조기 치료가 가장 중요합니다. \n"
              "권장 드리는 사항으로는, 가까운 병원 혹은 탈모 관리센터 내원하시길 바랍니다. 또한 일반적인 샴푸를 사용한다면,"
              "두피 타입에 맞는 건성/지성 '두피샴푸'로 변경하고, 주기적인 '스케일링'을 받는 것을 권장드립니다.\n"
              "경고 : 본 진단은 의료적 효력이 없으므로 무조건적으로 신뢰할 수 없으며, "
              "추가적인 진단이 필요하다고 느낀다면 꼭 근처 병원을 방문하시기를 권장드립니다.";
        } else {
          // M1 진단
          text = "회원님의 상태가 M1으로 분류되었습니다. "
              "M1은 BASP(한국형 탈모 진단법)의 탈모 초기에 속하는 것으로, 정상적인 이마라인보다 끝 부분이 살짝 올라와 "
              "작은 M자의 형태를 갖는 것을 의미합니다. 근처 병원을 내원하시어 진료를 꼭 받는 것을 권장드립니다. 탈모는 조기 치료가 가장 중요합니다. \n"
              "설문조사의 경우에도 탈모로 의심되기에 빠른 관리가 필요할 것으로 보입니다. "
              "권장 드리는 사항으로는, 가까운 병원 혹은 탈모 관리센터 내원하시길 바랍니다. 또한 일반적인 샴푸를 사용한다면,"
              "두피 타입에 맞는 건성/지성 '두피샴푸'로 변경하고, 주기적인 '스케일링'을 받는 것을 권장드립니다.\n"
              "경고 : 본 진단은 의료적 효력이 없으므로 무조건적으로 신뢰할 수 없으며, "
              "추가적인 진단이 필요하다고 느낀다면 꼭 근처 병원을 방문하시기를 권장드립니다.";
        }
        break;
      case 2:
        if (count == 0){
          // M2 진단, 설문조사의 경우 정상
          text = "회원님의 상태가 M2로 분류되었습니다. "
              "M2은 BASP(한국형 탈모 진단법)의 탈모 중~후반기에 속하는 것으로, 정상적인 이마라인보다 끝 부분이 도드라지게 올라와 "
              "M자의 형태를 갖는 것을 의미합니다. 근처 병원을 내원하시어 진료를 꼭 받는 것을 권장드립니다. \n"
              "또한, 설문에서는 탈모에 해당되는 내용이 하나도 확인되지 않아 재촬영해 다시 자가 진단 받는 것을 권장합니다. "
              "권장 드리는 사항으로는, 가까운 병원 혹은 탈모 관리센터 내원하시길 바랍니다. 또한 일반적인 샴푸를 사용한다면,"
              "두피 타입에 맞는 건성/지성 '두피샴푸'로 변경하고, 주기적인 '스케일링'을 받는 것을 권장드립니다. "
              "전문의에게 전문 의약품을 처방 받고, 심각한 경우 모발 이식을 고려하는 것도 좋은 방법입니다.\n"
              "경고 : 본 진단은 의료적 효력이 없으므로 무조건적으로 신뢰할 수 없으며, "
              "추가적인 진단이 필요하다고 느낀다면 꼭 근처 병원을 방문하시기를 권장드립니다.";
        } else {
          // M2 진단
          text = "회원님의 상태가 M2로 분류되었습니다. "
              "M2은 BASP(한국형 탈모 진단법)의 탈모 중~후반기에 속하는 것으로, 정상적인 이마라인보다 끝 부분이 도드라지게 올라와 "
              "M자의 형태를 갖는 것을 의미합니다. 근처 병원을 내원하시어 진료를 꼭 받는 것을 권장드립니다. \n"
              "설문조사의 경우에도 탈모로 의심되기에 빠른 관리가 필요할 것으로 보입니다. "
              "권장 드리는 사항으로는, 가까운 병원 혹은 탈모 관리센터 내원하시길 바랍니다. 또한 일반적인 샴푸를 사용한다면,"
              "두피 타입에 맞는 건성/지성 '두피샴푸'로 변경하고, 주기적인 '스케일링'을 받는 것을 권장드립니다. "
              "전문의에게 전문 의약품을 처방 받고, 심각한 경우 모발 이식을 고려하는 것도 좋은 방법입니다.\n"
              "경고 : 본 진단은 의료적 효력이 없으므로 무조건적으로 신뢰할 수 없으며, "
              "추가적인 진단이 필요하다고 느낀다면 꼭 근처 병원을 방문하시기를 권장드립니다.";
        }
        break;
    }
    return Text(text);
  }

  /// resultObject 객체 내의 percent List를 통해
  /// classification label을 불러 올 수 있는 메소드
  int getLabelByPercent(List<double> percent){
    double tempPercent = -1;
    int tempLabel = -1;
    for (var i = 0; i < percent.length; i++){
      if (tempPercent < percent[i]){
        tempPercent = percent[i];
        tempLabel = i;
      }
    }
    return tempLabel;
  }
}
