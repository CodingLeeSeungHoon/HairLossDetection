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
          child: SingleChildScrollView(
            child: Container(
              // 가운데 정렬
              alignment: AlignmentDirectional.center,
              // 패딩과 마진 값
              padding: EdgeInsets.all(phonePadding * 0.33),
              margin: EdgeInsets.all(phonePadding * 0.33),
              // 내부 위젯 레이아웃 세로 배치
            ),
          ),
        ));
  }
}
