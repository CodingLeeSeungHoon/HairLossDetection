import 'package:flutter/material.dart';
import 'package:jbmb_application/widget/MainDescription.dart';
import '../widget/ClickableButton.dart';
import '../widget/NavigationDrawerWidget.dart';

class Home extends StatefulWidget {
  /// 홈 메인 화면 구현
  /// 2022.02.27 이승훈 개발
  /// AppBar - 중간 문구 - 구분선 - 슬라이더(이미지 + 버튼) 구조

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        // sideDrawer
        endDrawer: Container(
          width: 230,
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
        // AppBar를 제외한 나머지 위젯 (중간문구 - 구분선 - 슬라이더)
        body: Container(
            // 가운데 정렬
            alignment: AlignmentDirectional.center,
            // 패딩과 마진 값
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            // 내부 위젯 레이아웃 세로 배치
            child: Column(
              children: const [
                // TODO: MainDescription 로그인 여부에 따라 내용 변경
                MainDescription(),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black45,
                ),
                SizedBox(
                  height: 20,
                ),
                // TODO: Slider 구현 필요
                ClickableButton(buttonText: '무료 진단 받기'),
              ],
            )));
  }
}
