import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jbmb_application/object/JBMBDiagnosisLogsObject.dart';
import 'package:jbmb_application/service/JBMBDiagnoseLogManager.dart';
import 'package:jbmb_application/service/JBMBDiagnoseManager.dart';
import '../object/JBMBDiagnosisResponseObject.dart';
import '../object/JBMBMemberInfo.dart';
import '../service/JBMBMemberManager.dart';
import '../widget/JBMBAppBars.dart';
import '../widget/LoginedNavigationDrawerWidget.dart';
import 'DiagnosisResultPage.dart';

class DiagnosisLogPage extends StatefulWidget {
  final JBMBMemberManager memberManager;
  final JBMBDiagnoseLogManager diagnoseLogManager;
  final JBMBDiagnoseManager diagnoseManager;

  const DiagnosisLogPage(
      {Key? key,
      required this.memberManager,
      required this.diagnoseLogManager,
      required this.diagnoseManager})
      : super(key: key);

  @override
  _DiagnosisLogPageState createState() => _DiagnosisLogPageState();
}

class _DiagnosisLogPageState extends State<DiagnosisLogPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final controller = ScrollController();

  // TODO : change type List<String> to List<JBMBDiagnosisLog>
  JBMBDiagnosisLogsObject? logsObject;
  List<String> items = List.generate(15, (index) => '진료기록 ${index + 1}');
  List<JBMBDiagnosisLog>? logItems;


  @override
  void initState() {
    super.initState();
    _getLogsObject(widget.memberManager.memberInfo.getID!);
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        // fetch();
      }
    });
  }

  /// init logItems
  void _getLogsObject(String userID) async {
    String tempToken = await widget.memberManager.jwtManager.getToken();
    JBMBDiagnosisLogsObject? response = await widget.diagnoseLogManager.getDiagnosisLogByUserID(tempToken, userID);
    if (response?.getDiagnosisList != null){
      setState(() {
        logItems = response?.getDiagnosisList;
        print(logItems?.length);
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // Future fetch() async {
  //   // TODO : change add rest logs
  //   setState(() {
  //     items.addAll(['진료기록 A', '진료기록 B', '진료기록 C', '진료기록 D']);
  //   });
  // }



  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;
    double phonePadding = MediaQuery.of(context).padding.top;

    return Scaffold(
        key: _scaffoldKey,
        endDrawer: SizedBox(
          width: phoneWidth * 0.55,
          child: LoginedNavigationDrawerWidget(
            memberManager: widget.memberManager,
          ),
        ),
        backgroundColor: Colors.white,
        appBar: JBMBAppBarWithBackButton(
          onPressedMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
          onPressedCancel: () => Navigator.pop(context),
        ),
        body: Scrollbar(
          controller: controller,
          child: ListView.separated(
            controller: controller,
            padding: const EdgeInsets.all(8),
            itemCount: logItems == null ? 0 : logItems!.length + 1,
            itemBuilder: (context, index) {
              if (logItems != null && index < logItems!.length) {
                var item = logItems![index];
                return Container(
                  height: 60,
                  child: ListTile(
                    leading: const Icon(
                      Icons.library_books_outlined,
                      color: Colors.grey,
                    ),
                    title: Text(widget.memberManager.memberInfo.getName! + "님의 진단 기록 (" + (index+1).toString() + "회차)"),
                    subtitle: Text("진단번호 : " + item.getDiagnosisID.toString() + "\n" + item.getDate),
                    trailing: const Icon(Icons.double_arrow_rounded,
                        color: Colors.grey),
                    style: ListTileStyle.list,
                    onTap: () async {
                      // TODO : Make JBMBDiagnosisResultResponseObject by Manager, diagnosisID in Logs List
                      String tempToken = await widget.memberManager.jwtManager.getToken();
                      JBMBDiagnosisResultResponseObject? object = await widget.diagnoseManager.getDiagnosisResultByDiagnosisID(tempToken, item.getDiagnosisID);
                      if (object != null){
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                DiagnosisResultPage(
                                    memberManager: widget.memberManager,
                                    way: 2,
                                    resultObject: object),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      }
                    },
                  ),
                );
              }
              else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Text("회원님의 진단 기록이 더 이상 존재하지 않습니다. \n진단을 새로 시작해주세요.", textAlign: TextAlign.center,),
                  ),
                );
              }
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              height: 10,
              color: Colors.black45,
            ),
          ),
        ));
  }
}
