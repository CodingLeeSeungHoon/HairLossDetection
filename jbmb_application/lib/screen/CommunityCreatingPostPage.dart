import "package:flutter/material.dart";
import 'package:jbmb_application/widget/JBMBOutlinedButton.dart';

import '../service/JBMBMemberManager.dart';
import '../widget/JBMBAppBars.dart';
import '../widget/LoginedNavigationDrawerWidget.dart';

/// 2022.06.15 이한범
/// JBMB 커뮤니티 게시글 작성 페이지
/// 게시글의 수정 또한 담당
/// JBMBCommunityManager를 통해 DB상의 게시글을 불러옴.
class CommunityCreatingPostPage extends StatefulWidget {
  final JBMBMemberManager memberManager;

  const CommunityCreatingPostPage({Key? key, required this.memberManager})
      : super(key: key);

  @override
  _CommunityCreatingPostPageState createState() => _CommunityCreatingPostPageState();
}

class _CommunityCreatingPostPageState extends State<CommunityCreatingPostPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
        // sideDrawer
        endDrawer: Container(
          width: phoneWidth * 0.55,
          child: LoginedNavigationDrawerWidget(
            memberManager: widget.memberManager,
          ),
        ),
        // 전체 화면 바탕색 지정
        backgroundColor: Colors.white,
        appBar: JBMBAppBarWithBackButton(
          onPressedMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
          onPressedCancel: () => Navigator.pop(context),
        ),
        body: Stack()
    );
  }
}
