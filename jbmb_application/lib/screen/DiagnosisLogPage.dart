import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../object/JBMBDiagnosisResponseObject.dart';
import '../object/JBMBMemberInfo.dart';
import '../service/JBMBMemberManager.dart';
import '../widget/JBMBAppBars.dart';
import '../widget/LoginedNavigationDrawerWidget.dart';
import 'DiagnosisResultPage.dart';

class DiagnosisLogPage extends StatefulWidget {
  final JBMBMemberManager memberManager;

  const DiagnosisLogPage({Key? key, required this.memberManager})
      : super(key: key);

  @override
  _DiagnosisLogPageState createState() => _DiagnosisLogPageState();
}

class _DiagnosisLogPageState extends State<DiagnosisLogPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final controller = ScrollController();
  List<String> items = List.generate(15, (index) => '진료기록 ${index + 1}');

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fetch();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future fetch() async {
    setState(() {
      items.addAll(['진료기록 A', '진료기록 B', '진료기록 C', '진료기록 D']);
    });
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery
        .of(context)
        .size
        .width;
    double phoneHeight = MediaQuery
        .of(context)
        .size
        .height;
    double phonePadding = MediaQuery
        .of(context)
        .padding
        .top;

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
            itemCount: items.length + 1,
            itemBuilder: (context, index) {
              if (index < items.length) {
                final item = items[index];
                return Container(
                  height: 60,
                  child: ListTile(
                    leading: const Icon(
                      Icons.library_books_outlined, color: Colors.grey,),
                    title: Text(item),
                    subtitle: Text("\n2022-03-17 23:37:29"),
                    trailing: const Icon(
                        Icons.double_arrow_rounded, color: Colors.grey),
                    style: ListTileStyle.list,
                    onTap: () {
                      Future.delayed(const Duration(milliseconds: 250), () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                DiagnosisResultPage(
                                  memberManager: widget.memberManager,
                                  way: 2,
                                  resultObject: JBMBDiagnosisResultResponseObject(0, [99.9, 0.01, 0])
                                ),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      });
                    },
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.black45,
                    ),
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
