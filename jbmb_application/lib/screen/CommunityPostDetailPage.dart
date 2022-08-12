import "package:flutter/material.dart";
import 'package:jbmb_application/service/JBMBCommunityManager.dart';
import 'package:jbmb_application/service/JBMBCommunityPostManager.dart';
import 'package:jbmb_application/widget/JBMBTextField.dart';

import '../object/JBMBCommunityResponseObject.dart';
import '../object/JBMBDefaultResponseObject.dart';
import '../service/JBMBMemberManager.dart';
import '../widget/JBMBAppBars.dart';
import '../widget/LoginedNavigationDrawerWidget.dart';
import 'CommunityCreatingPostPage.dart';
import 'CommunityPage.dart';

/// 2022.06.15 이한범
/// JBMB 커뮤니티 게시글 상세 내역을 보여줌
/// JBMBCommunityManager를 통해 DB상의 게시글을 불러옴.
class CommunityPostDetailPage extends StatefulWidget {
  final JBMBMemberManager memberManager;
  final JBMBCommunityManager communityManager;
  final JBMBPostDetailResponseObject postDetailResponseObject;
  final int postID;

  const CommunityPostDetailPage(
      {Key? key,
      required this.memberManager,
      required this.communityManager,
      required this.postDetailResponseObject,
      required this.postID})
      : super(key: key);

  @override
  _CommunityPostDetailPageState createState() =>
      _CommunityPostDetailPageState();
}

class _CommunityPostDetailPageState extends State<CommunityPostDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = ScrollController();
  final _commentTextEditController = TextEditingController();

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
  _initPostList() async {
    if (widget.postDetailResponseObject != null) {
      setState(() {
        commentList = widget.postDetailResponseObject.getCommentItemsList;
      });
    }
  }

  /// initiate community list from api
  _addPostList() async {
    setState(() {
      commentList?.addAll(widget.postDetailResponseObject.getCommentItemsList!);
    });
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
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;
    double phonePadding = MediaQuery.of(context).padding.top;

    // List<JBMBCommentItems>? comments =
    //    widget.postDetailResponseObject.getCommentItemsList;

    TextEditingController commentController = TextEditingController();
    String editComment = "";
    JBMBCommunityPostManager postManager =
        JBMBCommunityPostManager(widget.memberManager);

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        bottomSheet: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.grey[100],
          width: phoneWidth,
          height: phoneHeight * 0.09,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: phoneWidth * 0.78,
                height: phoneHeight * 0.06,
                child: JBMBTextField(
                    controller: commentController,
                    obsecure: false,
                    hintText: "눌러서 댓글을 작성하세요!"),
              ),
              IconButton(
                  onPressed: () async {
                    setState(() {
                      editComment = commentController.text;
                    });
                    String tempToken =
                        await widget.memberManager.jwtManager.getToken();
                    bool commentResponse = await postManager.commentInPost(
                        tempToken,
                        widget.memberManager.memberInfo.getID!,
                        widget.postID,
                        editComment);
                    if (commentResponse) {
                      JBMBPostDetailResponseObject? object = await widget
                          .communityManager
                          .getPostDetail(tempToken, widget.postID);
                      if (object != null) {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                CommunityPostDetailPage(
                                    memberManager: widget.memberManager,
                                    communityManager: widget.communityManager,
                                    postDetailResponseObject: object,
                                    postID: widget.postID),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("서버 측 오류로 댓글을 달지 못했습니다!")));
                    }
                  },
                  icon: const Icon(Icons.send))
            ],
          ),
        ),
        appBar: JBMBPostDetailPageAppbar(
          // 글쓴이가 자기 자신이면 수정, 삭제 버튼 활성
          actions: widget.memberManager.memberInfo.getID ==
                  widget.postDetailResponseObject.getUserID
              ? <Widget>[
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              CommunityCreatingPostPage(
                            memberManager: widget.memberManager,
                            postManager:
                                JBMBCommunityPostManager(widget.memberManager),
                            postId: widget.postID,
                            savedTitle:
                                widget.postDetailResponseObject.getTitle!,
                            savedContent:
                                widget.postDetailResponseObject.getContent!,
                          ),
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
                          title: const Text('삭제'),
                          content: const Text(
                            '게시글을 삭제할까요?',
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                '취소',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              onPressed: () {
                                Navigator.of(ctx).pop(false);
                              },
                            ),
                            TextButton(
                                child: Text(
                                  '확인',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                                onPressed: () async {
                                  Navigator.of(ctx).pop(true);
                                  JBMBDefaultResponseObject? response =
                                      await widget.communityManager.deletePost(
                                          await widget.memberManager.jwtManager
                                              .getToken(),
                                          widget.postID);

                                  if (response != null &&
                                      response.getResultCode == 0) {
                                    Navigator.of(context).pop();
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation1, animation2) =>
                                                CommunityPage(
                                                    memberManager:
                                                        widget.memberManager,
                                                    communityManager:
                                                        JBMBCommunityManager()),
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                        "삭제하지 못했습니다.",
                                        textAlign: TextAlign.center,
                                      ),
                                    ));
                                  }
                                }),
                          ],
                        ),
                      );
                    },
                  ),
                ]
              : null,
          onPressedCancel: () {
            Navigator.of(context).pop();
          },
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  // 아이콘, 익명, datetime
                  ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Color(0xffE6E6E6),
                        ),
                      ),
                      title: Text(widget.postDetailResponseObject.getUserID!),
                      subtitle: Text(widget.postDetailResponseObject.getDate!)),
                  // 제목
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    child: Text(
                      widget.postDetailResponseObject.getTitle!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
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
                  const SizedBox(
                    height: 1,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  if (commentList != null)
                    SizedBox(
                      height: phoneHeight * 0.55,
                      child: ListView.builder(
                          itemCount:
                              commentList == null ? 0 : commentList!.length + 1,
                          itemBuilder: (context, index) {
                            if (index < commentList!.length) {
                              final item = commentList![index];
                              return Card(
                                clipBehavior: Clip.antiAlias,
                                child: Container(
                                  padding: const EdgeInsets.all(11),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.getId!,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        item.getDate!,
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(item.getComment!),
                                      if (item.getId! ==
                                          widget.memberManager.memberInfo.getID)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 30,
                                              child: IconButton(
                                                onPressed: () async {
                                                  // 댓글 삭제 버튼
                                                  String tempToken =
                                                      await widget.memberManager
                                                          .jwtManager
                                                          .getToken();
                                                  JBMBDefaultResponseObject?
                                                      response = await widget
                                                          .communityManager
                                                          .deleteComment(
                                                              tempToken,
                                                              item.getCommentId!);
                                                  if (response == null) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    "댓글 삭제에 실패했습니다")));
                                                  } else {
                                                    // Navigator.of(context).pop();
                                                    JBMBPostDetailResponseObject?
                                                        object = await widget
                                                            .communityManager
                                                            .getPostDetail(
                                                                tempToken,
                                                                widget.postID);
                                                    if (object != null) {
                                                      Navigator.pushReplacement(
                                                        context,
                                                        PageRouteBuilder(
                                                          pageBuilder: (context,
                                                                  animation1,
                                                                  animation2) =>
                                                              CommunityPostDetailPage(
                                                                  memberManager:
                                                                      widget
                                                                          .memberManager,
                                                                  communityManager:
                                                                      widget
                                                                          .communityManager,
                                                                  postDetailResponseObject:
                                                                      object,
                                                                  postID: widget
                                                                      .postID),
                                                          transitionDuration:
                                                              Duration.zero,
                                                          reverseTransitionDuration:
                                                              Duration.zero,
                                                        ),
                                                      );
                                                    }
                                                  }
                                                },
                                                icon: const Icon(Icons.cancel),
                                                color: Colors.red[300],
                                                iconSize: 15,
                                                splashColor: Colors.red[100],
                                                splashRadius: 15,
                                              ),
                                            ),
                                          ],
                                        )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox(
                                height: 0,
                              );
                            }
                          }),
                    ),
                  SizedBox(
                    height: phoneHeight * 0.07,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
