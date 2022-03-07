import "package:flutter/material.dart";

import '../widget/NavigationDrawerWidget.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

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
        child: NavigationDrawerWidget(),
      ),
      // 전체 화면 바탕색 지정
      backgroundColor: Colors.white,
      appBar: AppBar(
        // 최상단 앱 바
        title: const Text(
          "제발모발",
          style: TextStyle(
              fontSize: 23,
              color: Colors.black,
              fontFamily: 'Gugi-Regular',
              fontWeight: FontWeight.bold),
        ),
        // AppBar 내 요소 가운데 정렬
        centerTitle: true,
        // AppBar 그림자 제거
        elevation: 0,
        // AppBar 바탕색 설정
        backgroundColor: Colors.white,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black,), onPressed: () => Navigator.pop(context),),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
          )
        ],
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
