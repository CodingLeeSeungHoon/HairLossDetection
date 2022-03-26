import 'package:flutter/material.dart';
import 'package:jbmb_application/object/JBMBMemberInfo.dart';
import 'package:jbmb_application/widget/JBMBShampooListTile.dart';

import '../widget/JBMBAppBars.dart';
import '../widget/LoginedNavigationDrawerWidget.dart';

/// 2022.03.08 이승훈
/// 두피에 따른 샴푸 검색 및 구매 페이지 유도
class ShampooPage extends StatefulWidget {
  final JBMBMemberInfo jbmbMemberInfo;

  const ShampooPage({Key? key, required this.jbmbMemberInfo}) : super(key: key);

  @override
  _ShampooPageState createState() => _ShampooPageState();
}

class _ShampooPageState extends State<ShampooPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final controller = ScrollController();
  List<String> items = List.generate(15, (index) => '샴푸 ${index + 1}');

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
      items.addAll(['샴푸 A', '샴푸 B', '샴푸 C', '샴푸 D']);
    });
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;
    double phonePadding = MediaQuery.of(context).padding.top;

    return Scaffold(
        key: _scaffoldKey,
        // sideDrawer
        endDrawer: Container(
          width: phoneWidth * 0.55,
          child: LoginedNavigationDrawerWidget(
            jbmbMemberInfo: widget.jbmbMemberInfo,
          ),
        ),
        // 전체 화면 바탕색 지정
        backgroundColor: Colors.white,
        appBar: JBMBAppBarWithBackButton(
          onPressedMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
          onPressedCancel: () => Navigator.pop(context),
        ),
        body: Scrollbar(
          controller: controller,
          child: ListView.builder(
            controller: controller,
            padding: const EdgeInsets.all(8),
            itemCount: items.length + 1,
            itemBuilder: (context, index) {
              if (index < items.length) {
                final item = items[index];
                return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      height: 150,
                      padding: const EdgeInsets.all(0),
                      child: Row(children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        Image.asset("images/shampoo.png").image,
                                    )),
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Expanded(
                            flex: 14,
                            child: Container(
                                padding: const EdgeInsets.only(top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(item,
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      children: const <Widget>[
                                        Text(
                                          '샴푸 유형 : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "지성",
                                          style: TextStyle(fontSize: 15.0),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: const <Widget>[
                                        Text(
                                          '평점 : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Icon(Icons.star_outlined, color: Colors.yellow,),
                                        Text(
                                          '(5/5)',
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: const <Widget>[
                                        Text(
                                          '가격 : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          '10,000원',
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          TextButton(
                                              onPressed: (){},
                                              child: const Text("구매 페이지로 연결")),
                                        ],
                                      ),
                                    )
                                  ],
                                )))
                      ]),
                    ));
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
          ),
        ));
  }
}
