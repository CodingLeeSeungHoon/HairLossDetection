import "package:flutter/material.dart";
import 'package:jbmb_application/service/JBMBCommunityPostManager.dart';
import 'package:jbmb_application/widget/JBMBOutlinedButton.dart';

import '../service/JBMBMemberManager.dart';
import '../widget/JBMBAppBars.dart';
import '../widget/LoginedNavigationDrawerWidget.dart';

/// 2022.06.20 이승훈
/// JBMB 커뮤니티 게시글 작성 페이지
/// 게시글의 수정 또한 담당
/// JBMBCommunityManager를 통해 DB상의 게시글을 불러옴.
class CommunityCreatingPostPage extends StatefulWidget {
  final JBMBMemberManager memberManager;
  final JBMBCommunityPostManager postManager;
  final int? postId;
  final String? savedTitle;
  final String? savedContent;

  const CommunityCreatingPostPage(
      {Key? key, required this.memberManager, required this.postManager, this.postId, this.savedTitle, this.savedContent})
      : super(key: key);

  @override
  _CommunityCreatingPostPageState createState() =>
      _CommunityCreatingPostPageState();
}

class _CommunityCreatingPostPageState extends State<CommunityCreatingPostPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();

  String title = "";
  String text = "";
  bool isEdit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (checkEdit()){
      title = widget.savedTitle!;
      text = widget.savedContent!;

      titleController.text = title;
      textController.text = text;

      isEdit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;
    double phonePadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      key: _scaffoldKey,
      // 전체 화면 바탕색 지정
      backgroundColor: Colors.white,
      appBar: JBMBTransparentLogoAppbar(
        onPressedCancel: () {
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(hintText: '제목을 입력해주세요'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: textController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 25,
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0)),
                      hintText: '내용을 입력해주세요.',
                      fillColor: Colors.grey[300],
                      filled: true),
                ),
                const SizedBox(
                  height: 20,
                ),
                JBMBOutlinedButton(
                  buttonText: '글 쓰기',
                  iconData: Icons.textsms,
                  onPressed: () async {
                    setState(() {
                      title = titleController.text;
                      text = textController.text;
                    });

                    if (widget.postManager.checkBlank(title, text)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("제목 및 내용을 입력해주세요."),
                      ));
                    } else {
                      if (isEdit == false){
                        // 새로 작성 모드
                        String tempToken =
                        await widget.memberManager.jwtManager.getToken();
                        bool uploadResponse = await widget.postManager
                            .uploadPostInCommunity(
                            tempToken,
                            widget.memberManager.memberInfo.getID!,
                            title,
                            text);
                        if (uploadResponse == true){
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("게시글 업로드에 성공했습니다!"),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("게시글 업로드에 실패했습니다."),
                          ));
                        }
                      } else {
                        // 편집 모드
                        String tempToken =
                        await widget.memberManager.jwtManager.getToken();
                        bool editResponse = await widget.postManager.editPostInCommunity(tempToken, widget.postId!, title, text);
                        if (editResponse == true){
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("게시글 수정에 성공했습니다!"),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("게시글 수정에 실패했습니다."),
                          ));
                        }
                      }
                    }
                  },
                ),
              ],
            )),
      ),
    );
  }

  bool checkEdit(){
    if (widget.postId != null && widget.savedContent != null && widget.savedTitle != null){
      return true;
    } else {
      return false;
    }
  }
}
