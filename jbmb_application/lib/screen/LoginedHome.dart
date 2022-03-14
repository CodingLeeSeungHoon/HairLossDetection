import 'package:flutter/material.dart';
import 'package:jbmb_application/screen/CommunityPage.dart';
import 'package:jbmb_application/screen/DiagnosisAlertPage.dart';
import 'package:jbmb_application/screen/HospitalPage.dart';
import 'package:jbmb_application/screen/ShampooPage.dart';
import 'package:jbmb_application/widget/LoginedMainDescription.dart';
import 'package:jbmb_application/widget/LoginedNavigationDrawerWidget.dart';
import 'package:jbmb_application/widget/MainDescription.dart';
import '../object/JBMBMemberInfo.dart';
import '../widget/JBMBOutlinedButton.dart';
import '../widget/NavigationDrawerWidget.dart';
import 'package:carousel_slider/carousel_slider.dart';

/// 로그인 이후 홈 메인 화면 구현
/// 2022.03.08 이승훈 개발
/// AppBar - 중간 문구 - 구분선 - 슬라이더(이미지 + 버튼) 구조
/// LoginedMainDescription, LoginedNavigationDrawerWidget 사용 주의
class LoginedHome extends StatefulWidget {
  // use this widget.jbmbMemberInfo in build function returns.
  JBMBMemberInfo jbmbMemberInfo;

  LoginedHome({
    Key? key,
    required this.jbmbMemberInfo
  }) : super(key: key);

  @override
  _LoginedHomeState createState() => _LoginedHomeState();

}

class _LoginedHomeState extends State<LoginedHome> {
  int _current = 0;
  List imgList = [
    'images/hair-comb.png',
    'images/shampoo.png',
    'images/hospital.png',
    'images/community.png'
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;
    double phonePadding = MediaQuery.of(context).padding.top;

    return WillPopScope(child: Scaffold(
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
            padding: EdgeInsets.all(phonePadding * 0.33),
            margin: EdgeInsets.all(phonePadding * 0.33),
            // 내부 위젯 레이아웃 세로 배치
            child: Column(
              children: <Widget>[
                LoginedMainDescription(userName: widget.jbmbMemberInfo.getName!,),
                SizedBox(
                  height: phoneHeight * 0.02,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black45,
                ),
                SizedBox(height: phoneHeight * 0.03,),
                CarouselSlider(
                  options: CarouselOptions(
                    height: phoneHeight * 0.55,
                    initialPage: 0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                    enableInfiniteScroll: false,
                    // autoPlay: true,
                    // autoPlayCurve: Curves.easeIn,
                  ),
                  items: imgList.map((imgUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  imgUrl,
                                  width: phoneWidth * 0.5,
                                  height: phoneWidth * 0.5,
                                ),
                                SizedBox(
                                  height: phoneHeight * 0.02,
                                ),
                                getMenuTextByIndex(_current),
                                SizedBox(
                                  height: phoneHeight * 0.03,
                                ),
                                JBMBOutlinedButton(
                                  buttonText: getButtonTextByIndex(_current),
                                  iconData: getIconDataByIndex(_current),
                                  onPressed: (){
                                    movePageByCurrentIndex(_current);
                                  },
                                ),
                              ],
                            ));
                      },
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: phoneHeight * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map<Widget>(imgList, (index, url) {
                    return Container(
                      width: phoneWidth * 0.04,
                      height: phoneHeight * 0.014,
                      margin:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                          _current == index ? Colors.black : Colors.grey),
                    );
                  }),
                )
              ],
            ))),
        onWillPop: (){
      return Future(() => false);
        });
  }

  /// Move Page by [currentIndex] when clicked CarouselSlider Button
  void movePageByCurrentIndex(int currentIndex){
    switch(currentIndex) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DiagnosisAlertPage(jbmbMemberInfo: widget.jbmbMemberInfo,),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ShampooPage(jbmbMemberInfo: widget.jbmbMemberInfo,),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HospitalPage(jbmbMemberInfo: widget.jbmbMemberInfo,),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CommunityPage(jbmbMemberInfo: widget.jbmbMemberInfo,),
        ));
        break;
    }
  }

  /// display Button Text by [index]
  String getButtonTextByIndex(int index) {
    String retval = "";
    switch (index) {
      case 0:
        retval = "무료 진단 받기";
        break;
      case 1:
        retval = "추천 샴푸 보기";
        break;
      case 2:
        retval = "주변 병원 탐색";
        break;
      case 3:
        retval = "JBMB 커뮤니티";
        break;
    }
    return retval;
  }

  /// get CarouselSlider Menu Text By [index]
  Column getMenuTextByIndex(int index) {
    Column retval = Column();
    const double fontSize = 13.0;
    const Color color = Colors.black87;
    const String fontFamily = 'NanumGothic-Regular';

    switch (index) {
      case 0:
        retval = Column(
          children: const [
            Text(
              "자가진단 및 AI 이미지 진단으로\n"
                  "간단하게 탈모 상태를 알아보세요",
              style: TextStyle(
                  fontFamily: fontFamily, fontSize: fontSize, color: color,),
              textAlign: TextAlign.center,
            ),
          ],
        );
        break;
      case 1:
        retval = Column(
          children: const [
            Text(
              "자신의 두피 타입에 따라\n"
                  "적절한 샴푸를 추천해드려요",
              style: TextStyle(
                  fontFamily: fontFamily, fontSize: fontSize, color: color),
              textAlign: TextAlign.center,
            ),
          ],
        );
        break;
      case 2:
        retval = Column(
          children: const [
            Text(
              "근처 탈모 전문 병원을\n"
                  "찾아보세요",
              style: TextStyle(
                  fontFamily: fontFamily, fontSize: fontSize, color: color),
              textAlign: TextAlign.center,
            ),
          ],
        );
        break;
      case 3:
        retval = Column(
          children: const [
            Text(
              "비슷한 고민이 있는 회원들과\n"
                  "다양한 이야기를 나눠요",
              style: TextStyle(
                  fontFamily: fontFamily, fontSize: fontSize, color: color),
              textAlign: TextAlign.center,
            ),
          ],
        );
        break;
    }
    return retval;
  }

  /// get CarouselSlider ButtonIcon By [index]
  IconData? getIconDataByIndex(int index) {
    IconData? retval;
    switch (index) {
      case 0:
      // 무료 진단
        retval = Icons.check_box_rounded;
        return retval;
      case 1:
      // 샴푸 추천
        retval = Icons.find_in_page_rounded;
        return retval;
      case 2:
      // 병원 추천
        retval = Icons.local_hospital;
        return retval;
      case 3:
      // 커뮤니티
        retval = Icons.group;
        return retval;
    }
    return retval;
  }
}
