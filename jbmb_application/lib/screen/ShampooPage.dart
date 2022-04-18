import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jbmb_application/object/JBMBMemberInfo.dart';
import 'package:jbmb_application/service/JBMBMemberManager.dart';
import 'package:jbmb_application/widget/JBMBShampooListTile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../object/JBMBShampooResponseObject.dart';
import '../service/JBMBShampooManager.dart';
import '../widget/JBMBAppBars.dart';
import '../widget/LoginedNavigationDrawerWidget.dart';

/// 2022.03.08 이승훈
/// 두피에 따른 샴푸 검색 및 구매 페이지 유도
class ShampooPage extends StatefulWidget {
  final JBMBMemberManager memberManager;
  final JBMBShampooManager shampooManager;

  const ShampooPage(
      {Key? key, required this.memberManager, required this.shampooManager})
      : super(key: key);

  @override
  _ShampooPageState createState() => _ShampooPageState();
}

class _ShampooPageState extends State<ShampooPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final controller = ScrollController();
  // TODO : eliminate this variable
  // List<String> items = List.generate(15, (index) => '샴푸 ${index + 1}');
  List<JBMBShampooItems>? shampooItems;

  @override
  void initState() {
    super.initState();
    _initShampooList();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fetch();
      }
    });
  }

  /// initiate shampoo list from api
  _initShampooList() async{
    String tempToken = await widget.memberManager.jwtManager.getToken();
    JBMBShampooResponseObject? response = await widget.shampooManager.getShampoo(tempToken);
    if (response != null){
       setState(() {
         shampooItems = response.getShampooItemsList;
       });
    }
  }

  /// initiate shampoo list from api
  _addShampooList() async{
    String tempToken = await widget.memberManager.jwtManager.getToken();
    JBMBShampooResponseObject? response = await widget.shampooManager.getShampoo(tempToken);
    if (response != null){
      setState(() {
        shampooItems?.addAll(response.getShampooItemsList!.reversed);
      });
    }
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future fetch() async {
    _addShampooList();
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;

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
        body: Scrollbar(
          controller: controller,
          child: ListView.builder(
            controller: controller,
            padding: const EdgeInsets.all(8),
            itemCount: shampooItems == null ? 0 : shampooItems!.length + 1,
            itemBuilder: (context, index) {
              if (shampooItems != null && index < shampooItems!.length) {
                final item = shampooItems![index];
                return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      height: 180,
                      padding: const EdgeInsets.all(0),
                      child: Row(children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: Image.network(item.getImgLink!).image,
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
                                    Text(_resizeShampooName(item.getShampooName!),
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      children: <Widget>[
                                        const Text(
                                          '샴푸 유형 : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          getHairTypeStringByIntegerValue(widget.memberManager.memberInfo.getHairType!),
                                          style: const TextStyle(fontSize: 15.0),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        const Text(
                                          '브랜드 : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          item.getBrand!,
                                          style: const TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        const Text(
                                          '가격 : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          item.getLPrice!.toString() + "원",
                                          style: const TextStyle(fontSize: 15),
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
                                              onPressed: () {
                                                _searchShampooByURL(item.getPurchaseLink!);
                                              },
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

  _searchShampooByURL(String url) async {
    // url = url.replaceFirst("https://", "https://m");
    log(url);
    String encodedUrl = Uri.encodeFull(url);
    if (await canLaunch(encodedUrl)) {
      await launch(encodedUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("접속이 원활하지 않습니다."),)
      );
    }
  }

  _resizeShampooName(String shampooName) {
    if (shampooName.length > 38){
      return shampooName.substring(0, 38) + "...";
    } else {
      return shampooName;
    }
  }

  String getHairTypeStringByIntegerValue(int hairType){
    if (hairType == 0){
      return "건성";
    } else if (hairType == 1){
      return "지성";
    }
    return "";
  }
}
