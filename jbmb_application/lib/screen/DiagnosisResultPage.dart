import 'package:flutter/material.dart';
import 'package:jbmb_application/screen/LoginedHome.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DiagnosisResultPage extends StatefulWidget {
  const DiagnosisResultPage({Key? key}) : super(key: key);

  @override
  _DiagnosisResultPageState createState() => _DiagnosisResultPageState();
}

class _DiagnosisResultPageState extends State<DiagnosisResultPage> {
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

    String diagnosisDate = '(2022-03-10 18:30:23)';
    double phoneWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                Future.delayed(const Duration(milliseconds: 250), () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const LoginedHome(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                });
              },
            ),
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
          ),
          body: Scrollbar(
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      children: [
                        Text("민들레", style: mildTitleTextStyle),
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
                                widget: Text(
                                  "정상",
                                  style: indicatorTextStyle,
                                ))
                          ])
                    ]),
                    Text("설문조사 결과 체크 0개로 정상입니다."),
                    const SizedBox(height: 30,),
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
                      child: DataTable(columns: const [
                        DataColumn(label: Center(child: Text('정상', textAlign: TextAlign.center,)),),
                        DataColumn(label: Center(child: Text('초기 의심', textAlign: TextAlign.center,)),),
                        DataColumn(label: Center( child: Text('중기 의심', textAlign: TextAlign.center,)),),
                        DataColumn(label: Center(child: Text('말기 의심', textAlign: TextAlign.center,)),),
                      ], rows: const [
                        DataRow(cells: [
                          DataCell(Center(child: Text('99.00%', textAlign: TextAlign.center,)),),
                          DataCell(Center(child: Text('0.33%', textAlign: TextAlign.center,)),),
                          DataCell(Center(child: Text('0.33%', textAlign: TextAlign.center,)),),
                          DataCell(Center(child: Text('0.33%', textAlign: TextAlign.center,)),),
                        ])
                      ],),
                    ),
                    const SizedBox(height: 20,),
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
