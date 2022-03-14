import "package:flutter/material.dart";
import 'package:jbmb_application/object/JBMBMemberInfo.dart';

import '../widget/LoginedNavigationDrawerWidget.dart';

/// 2022.03.08 이승훈
/// 위치 기반 탈모 전문 병원 안내 페이지
/// NaverMapsAPI 사용
class HospitalPage extends StatefulWidget {
  final JBMBMemberInfo jbmbMemberInfo;
  const HospitalPage({
    Key? key,
    required this.jbmbMemberInfo
  }) : super(key: key);

  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
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
