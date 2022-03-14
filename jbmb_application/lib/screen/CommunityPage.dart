import "package:flutter/material.dart";
import 'package:jbmb_application/object/JBMBMemberInfo.dart';

import '../widget/JBMBAppBars.dart';
import '../widget/LoginedNavigationDrawerWidget.dart';

/// 2022.03.08 이승훈
/// JBMB 커뮤니티 페이지
/// ListView 형식으로 작성할 예정
/// JBMBCommunityManager를 통해 DB상의 게시글을 불러옴.
class CommunityPage extends StatefulWidget {
  final JBMBMemberInfo jbmbMemberInfo;
  const CommunityPage({
    Key? key,
    required this.jbmbMemberInfo
  }) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
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
        child: LoginedNavigationDrawerWidget(jbmbMemberInfo: widget.jbmbMemberInfo,),
      ),
      // 전체 화면 바탕색 지정
      backgroundColor: Colors.white,
      appBar: JBMBAppBarWithBackButton(
        onPressedMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
        onPressedCancel: () => Navigator.pop(context),
      ),
      body: Container(
        // 가운데 정렬
        alignment: AlignmentDirectional.center,
        // 패딩과 마진 값
        padding: EdgeInsets.all(phonePadding * 0.33),
        margin: EdgeInsets.all(phonePadding * 0.33),
        // 내부 위젯 레이아웃 세로 배치
        child: Column(),
      ),
    );
  }
}
