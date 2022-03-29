import "package:flutter/material.dart";
import 'package:jbmb_application/object/JBMBMemberInfo.dart';
import 'package:jbmb_application/widget/JBMBOutlinedButton.dart';

import '../service/JBMBMemberManager.dart';
import '../widget/JBMBAppBars.dart';
import '../widget/LoginedNavigationDrawerWidget.dart';

/// 2022.03.08 이승훈
/// JBMB 커뮤니티 페이지
/// ListView 형식으로 작성할 예정
/// JBMBCommunityManager를 통해 DB상의 게시글을 불러옴.
class CommunityPage extends StatefulWidget {
  final JBMBMemberManager memberManager;

  const CommunityPage({Key? key, required this.memberManager})
      : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final controller = ScrollController();
  List<String> items = List.generate(15, (index) => '글 ${index + 1}');

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
      items.addAll(['글 A', '글 B', '글 C', '글 D']);
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
            memberManager: widget.memberManager,
          ),
        ),
        // 전체 화면 바탕색 지정
        backgroundColor: Colors.white,
        appBar: JBMBAppBarWithBackButton(
          onPressedMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
          onPressedCancel: () => Navigator.pop(context),
        ),
        body: Stack(
          children: [
            Scrollbar(
              controller: controller,
              child: ListView.separated(
                controller: controller,
                padding: const EdgeInsets.all(8),
                itemCount: items.length + 1,
                itemBuilder: (context, index) {
                  if (index < items.length) {
                    final item = items[index];
                    return Container(
                      height: 60,
                      child: ListTile(
                        leading: const Icon(
                          Icons.library_books_outlined,
                          color: Colors.grey,
                        ),
                        title: Text(item),
                        subtitle: Text("\n2022-03-17 23:37:29"),
                        trailing: const Icon(Icons.double_arrow_rounded,
                            color: Colors.grey),
                        style: ListTileStyle.list,
                        onTap: () {},
                      ),
                    );
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
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  height: 10,
                  color: Colors.black45,
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 40),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    JBMBOutlinedButton(
                      iconData: Icons.brush,
                      buttonText: '게시글 작성',
                      onPressed: () {},
                    ),
                    JBMBOutlinedButton(
                      iconData: Icons.find_in_page_outlined,
                      buttonText: '게시글 검색',
                      onPressed: () {},
                    ),
                  ],
                )),
          ],
        ));
  }
}
