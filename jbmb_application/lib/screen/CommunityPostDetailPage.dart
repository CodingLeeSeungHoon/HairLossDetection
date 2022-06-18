import "package:flutter/material.dart";
import 'package:jbmb_application/service/JBMBCommunityManager.dart';

import '../object/JBMBCommunityResponseObject.dart';
import '../service/JBMBMemberManager.dart';
import '../widget/JBMBAppBars.dart';
import '../widget/LoginedNavigationDrawerWidget.dart';
import 'CommunityCreatingPostPage.dart';

/// 2022.06.15 이한범
/// JBMB 커뮤니티 게시글 상세 내역을 보여줌
/// JBMBCommunityManager를 통해 DB상의 게시글을 불러옴.
class CommunityPostDetailPage extends StatefulWidget {
  final JBMBMemberManager memberManager;
  final JBMBCommunityManager communityManager;
  final JBMBPostDetailResponseObject postDetailResponseObject;
  final int postID;

  const CommunityPostDetailPage({Key? key, required this.memberManager, required this.communityManager
    , required this.postDetailResponseObject, required this.postID})
      : super(key: key);

  @override
  _CommunityPostDetailPageState createState() => _CommunityPostDetailPageState();
}

class _CommunityPostDetailPageState extends State<CommunityPostDetailPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final controller = ScrollController();
  final _commentTextEditController=TextEditingController();

  List<JBMBCommentItems>? commentList;

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
  _initPostList() async{
    if (widget.postDetailResponseObject != null){
      setState(() {
        commentList = widget.postDetailResponseObject.getCommentItemsList;
      });
    }
  }

  /// initiate community list from api
  _addPostList() async{
    if (widget.postDetailResponseObject != null){
      setState(() {
        commentList?.addAll(widget.postDetailResponseObject.getCommentItemsList!);
      });
    }
  }

  @override
  void dispose() {
    _commentTextEditController.dispose();
    super.dispose();
  }

  Future fetch() async {
    setState(() {
      _addPostList();
    });
  }

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
    final comments=widget.postDetailResponseObject.getCommentItemsList!;

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
        appBar: AppBar(
          title: Text(
            widget.postDetailResponseObject.getTitle!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // 글쓴이가 자기 자신이면 수정, 삭제 버튼 활성
          actions: widget.memberManager.memberInfo.getID == widget.postDetailResponseObject.getUserID
              ? <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1,
                        animation2) =>
                        CommunityCreatingPostPage(memberManager: widget.memberManager),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('삭제'),
                    content: Text(
                      '게시글을 삭제할까요?',
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          '취소',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                      ),
                      FlatButton(
                        child: Text(
                          '확인',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () async {
                          Navigator.of(ctx).pop(true);
                          try {
                            Navigator.pop(context);
                            await widget.communityManager.deletePost(widget.memberManager.jwtManager.jwt, widget.postID);
                          } catch (error) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "삭제하지 못했습니다.",
                                textAlign: TextAlign.center,
                              ),
                            ));
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ]
              : null,
        ),
        body: Stack(
          children: [
            Container(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    // 아이콘, 익명, datetime
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Color(0xffE6E6E6),
                        ),
                      ),
                      title: Text(widget.postDetailResponseObject.getUserID!),
                      subtitle: Text(widget.postDetailResponseObject.getDate!)
                    ),
                    // 제목
                    Container(
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      child: Text(
                        widget.postDetailResponseObject.getTitle!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textScaleFactor: 1.4,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    // 내용
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(widget.postDetailResponseObject.getContent!),
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
            Scrollbar(
              controller: controller,
              child: ListView.separated(
                controller: controller,
                padding: const EdgeInsets.all(8),
                itemCount: commentList==null ? 0 : commentList!.length + 1,
                itemBuilder: (context, index) {
                  if (commentList != null && index < commentList!.length) {
                    var item = commentList![index];
                    return Container(
                      height: 60,
                      child: ListTile(
                        leading: const Icon(
                          Icons.library_books_outlined,
                          color: Colors.grey,
                        ),
                        title: Text(item.getId!),
                        subtitle: Text(item.getComment! + "\n" + item.getDate!),
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
          ],
        ));
  }
}
