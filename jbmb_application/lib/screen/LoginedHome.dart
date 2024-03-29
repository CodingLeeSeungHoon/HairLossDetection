import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jbmb_application/object/JBMBHairTypeUpdateRequestObject.dart';
import 'package:jbmb_application/screen/CommunityPage.dart';
import 'package:jbmb_application/screen/DiagnosisAlertPage.dart';
import 'package:jbmb_application/screen/HospitalPage.dart';
import 'package:jbmb_application/screen/ShampooPage.dart';
import 'package:jbmb_application/service/JBMBCommunityManager.dart';
import 'package:jbmb_application/service/JBMBDiagnoseManager.dart';
import 'package:jbmb_application/service/JBMBShampooManager.dart';
import 'package:jbmb_application/service/JBMBSurveyManager.dart';
import 'package:jbmb_application/widget/JBMBAppBars.dart';
import 'package:jbmb_application/widget/JBMBBigButton.dart';
import 'package:jbmb_application/widget/LoginedNavigationDrawerWidget.dart';
import '../object/JBMBMemberInfo.dart';
import '../service/JBMBMemberManager.dart';
import '../widget/JBMBDescription.dart';
import '../widget/JBMBOutlinedButton.dart';
import '../widget/NavigationDrawerWidget.dart';
import 'package:carousel_slider/carousel_slider.dart';

/// 로그인 이후 홈 메인 화면 구현
/// 2022.03.08 이승훈 개발
/// AppBar - 중간 문구 - 구분선 - 슬라이더(이미지 + 버튼) 구조
/// LoginedMainDescription, LoginedNavigationDrawerWidget 사용 주의
class LoginedHome extends StatefulWidget {
  // use this widget.memberManager in build function returns.
  JBMBMemberManager memberManager;

  LoginedHome({Key? key, required this.memberManager}) : super(key: key);

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

    return WillPopScope(
        child: Scaffold(
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
            appBar: JBMBAppBar(
                onPressedMenu: () =>
                    _scaffoldKey.currentState?.openEndDrawer()),
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
                    LoginedMainDescription(
                      userName: widget.memberManager.memberInfo.getName!,
                    ),
                    SizedBox(
                      height: phoneHeight * 0.02,
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.black45,
                    ),
                    SizedBox(
                      height: phoneHeight * 0.03,
                    ),
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
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
                                    MenuTextByIndex(
                                      index: _current,
                                    ),
                                    SizedBox(
                                      height: phoneHeight * 0.03,
                                    ),
                                    JBMBOutlinedButton(
                                      buttonText:
                                          getButtonTextByIndex(_current),
                                      iconData: getIconDataByIndex(_current),
                                      onPressed: () {
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
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == index
                                  ? Colors.black
                                  : Colors.grey),
                        );
                      }),
                    )
                  ],
                ))),
        onWillPop: () {
          return Future(() => false);
        });
  }

  /// Move Page by [currentIndex] when clicked CarouselSlider Button
  Future<void> movePageByCurrentIndex(int currentIndex) async {
    switch (currentIndex) {
      case 0:
        JBMBSurveyManager surveyManager = JBMBSurveyManager();
        JBMBDiagnoseManager diagnoseManager =
            JBMBDiagnoseManager(surveyManager);

        String tempToken = await widget.memberManager.jwtManager.getToken();
        int retval = await diagnoseManager.createNewDiagnosis(
            widget.memberManager.memberInfo, tempToken);
        // log("retval : " + retval.toString());
        if (retval != -1) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DiagnosisAlertPage(
              memberManager: widget.memberManager,
              diagnoseManager: diagnoseManager,
            ),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
            children: const [
              Icon(
                Icons.check,
                color: Colors.red,
              ),
              Text("서버상의 문제로, 진단을 시작할 수 없습니다.\n"
                  "잠시 후에 다시 시도해주세요."),
            ],
          )));
        }
        break;
      case 1:
        // 헤어 타입 유무 확인 후 bottom sheet or shampoo page로 변환
        int? hasHairType = widget.memberManager.memberInfo.getHairType;
        if (hasHairType == null) {
          showModalBottomSheet(
              context: context, builder: (context) => buildSheet());
        } else {
          switch (hasHairType) {
            case 0:
              // 건성
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShampooPage(
                  memberManager: widget.memberManager,
                  shampooManager: JBMBShampooManager(hasHairType),
                ),
              ));
              break;
            case 1:
              // 지성
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShampooPage(
                  memberManager: widget.memberManager,
                  shampooManager: JBMBShampooManager(hasHairType),
                ),
              ));
              break;
          }
        }
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HospitalPage(
            memberManager: widget.memberManager,
          ),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CommunityPage(
            memberManager: widget.memberManager,
            communityManager: JBMBCommunityManager(),
          ),
        ));
        break;
    }
  }

  /// 샴푸 bottomSheet 생성하는 메소드
  Widget buildSheet() => Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "당신의\n두피 타입을\n선택해주세요.\n",
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.black54,
                    fontFamily: 'NanumGothic-Regular',
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.info_outline),
                    tooltip:
                        '\n일반적으로 두피 역시 피부이기 때문에 \n건성 피부는 건성 두피, 지성 피부는 지성 두피를\n 가질 확률이 높습니다.\n'
                        '건성 두피는 각질과 비듬이 많은 두피,\n지성 두피는 유분이 많은 두피를 의미합니다.\n'
                        '샴푸를 한 지 반나절 내에 기름지고 축 가라앉는다면 지성,\n 비듬이나 각질 가루가 많이 떨어지는 두피는 건성입니다.\n',
                  ),
                  const Text("지성 두피와 건성 두피에 대해 \n알고 싶다면 버튼을 꾹 누르세요")
                ],
              ),
              const Divider(
                thickness: 2,
              ),
            ],
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              JBMBBigButton(
                buttonText: '지성',
                onPressed: () async {
                  JBMBHairTypeUpdateRequestObject request =
                      JBMBHairTypeUpdateRequestObject(
                          widget.memberManager.memberInfo.getID, 1);
                  bool retval =
                      await widget.memberManager.updateHairType(request);
                  if (retval) {
                    // success to save hair type
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShampooPage(
                        memberManager: widget.memberManager,
                        shampooManager: JBMBShampooManager(widget.memberManager.memberInfo.getHairType),
                      ),
                    ));
                  } else {
                    // failed to save hair type
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "서버가 원활하지 않아 두피 유형이 저장되지 않았습니다.\n잠시 후에 다시 시도해주세요")));
                  }
                },
              ),
              JBMBBigButton(
                buttonText: '건성',
                backgroundColor: Colors.white,
                elementColor: Colors.black45,
                onPressed: () async {
                  // TODO : save hair type codes
                  JBMBHairTypeUpdateRequestObject request =
                      JBMBHairTypeUpdateRequestObject(
                          widget.memberManager.memberInfo.getID, 0);
                  bool retval =
                      await widget.memberManager.updateHairType(request);
                  if (retval) {
                    // success to save hair type
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShampooPage(
                        memberManager: widget.memberManager,
                        shampooManager: JBMBShampooManager(widget.memberManager.memberInfo.getHairType),
                      ),
                    ));
                  } else {
                    // failed to save hair type
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "서버가 원활하지 않아 두피 유형이 저장되지 않았습니다.\n잠시 후에 다시 시도해주세요")));
                  }
                },
              )
            ],
          ))
        ],
      ));

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

/// get CarouselSlider Menu Text By [index]
class MenuTextByIndex extends StatelessWidget {
  final int index;

  const MenuTextByIndex({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double fontSize = 13.0;
    const Color color = Colors.black87;
    const String fontFamily = 'NanumGothic-Regular';
    Column retval = Column();

    switch (index) {
      case 0:
        retval = Column(
          children: const [
            Text(
              "자가진단 및 AI 이미지 진단으로\n"
              "간단하게 탈모 상태를 알아보세요",
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: fontSize,
                color: color,
              ),
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
}
