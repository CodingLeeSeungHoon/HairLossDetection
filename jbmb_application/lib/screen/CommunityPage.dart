import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:jbmb_application/screen/CommunityCreatingPostPage.dart';
import 'package:jbmb_application/service/JBMBCommunityManager.dart';
import 'package:jbmb_application/service/JBMBCommunityPostManager.dart';
import 'package:jbmb_application/widget/JBMBOutlinedButton.dart';
import 'package:jbmb_application/object/JBMBCommunityResponseObject.dart';

import '../service/JBMBMemberManager.dart';
import '../widget/JBMBAppBars.dart';
import '../widget/LoginedNavigationDrawerWidget.dart';
import 'CommunityPostDetailPage.dart';

/// 2022.03.08 이승훈
/// JBMB 커뮤니티 페이지
/// ListView 형식으로 작성할 예정
/// JBMBCommunityManager를 통해 DB상의 게시글을 불러옴.
class CommunityPage extends StatefulWidget {
  final JBMBMemberManager memberManager;
  final JBMBCommunityManager communityManager;

  const CommunityPage(
      {Key? key, required this.memberManager, required this.communityManager})
      : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = ScrollController();
  List<JBMBCommunityItems>? communityItems;

  @override
  void initState() {
    super.initState();
    _initPostList();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fetch();
      }
    });
  }

  /// initiate community list from api
  _initPostList() async {
    String tempToken = await widget.memberManager.jwtManager.getToken();
    JBMBCommunityResponseObject? response =
        await widget.communityManager.getPostList(tempToken);
    if (response != null) {
      setState(() {
        communityItems = response.getPostItemsList;
      });
    }
  }

  /// initiate community list from api
  _addPostList() async {
    String tempToken = await widget.memberManager.jwtManager.getToken();
    JBMBCommunityResponseObject? response =
        await widget.communityManager.getPostList(tempToken);
    if (response != null) {
      setState(() {
        communityItems?.addAll(response.getPostItemsList!);
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future fetch() async {
    setState(() {
      _addPostList();
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
        appBar: JBMBCommunityAppBar(
          onPressedMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
          onPressedCancel: () => Navigator.pop(context),
        ),
        body: Stack(
          children: [
            if (communityItems == null)
              Container(
                alignment: Alignment.center,
                child: const Text("커뮤니티 내 게시글이 없습니다!"),
              ),
            Scrollbar(
              controller: controller,
              child: ListView.separated(
                controller: controller,
                padding: const EdgeInsets.all(8),
                itemCount:
                    communityItems == null ? 0 : communityItems!.length + 1,
                itemBuilder: (context, index) {
                  if (communityItems != null &&
                      index < communityItems!.length) {
                    var item = communityItems![index];
                    return Container(
                      height: 60,
                      child: ListTile(
                        leading: const Icon(
                          Icons.library_books_outlined,
                          color: Colors.grey,
                        ),
                        title: Text(item.getTitle!),
                        subtitle: Text(item.getUserId! + "\n" + item.getDate!),
                        trailing: const Icon(Icons.double_arrow_rounded,
                            color: Colors.grey),
                        style: ListTileStyle.list,
                        onTap: () async {
                          String tempToken =
                              await widget.memberManager.jwtManager.getToken();
                          JBMBPostDetailResponseObject? object = await widget
                              .communityManager
                              .getPostDetail(tempToken, item.getPostId);
                          if (object != null) {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        CommunityPostDetailPage(
                                            memberManager: widget.memberManager,
                                            communityManager:
                                                JBMBCommunityManager(),
                                            postDetailResponseObject: object,
                                            postID: item.getPostId!),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          }
                        },
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
                      onPressed: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            fullscreenDialog: true,
                            builder: (context) {
                              return CommunityCreatingPostPage(
                                memberManager: widget.memberManager,
                                postManager: JBMBCommunityPostManager(
                                    widget.memberManager),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                )),
          ],
        ));
  }
}
