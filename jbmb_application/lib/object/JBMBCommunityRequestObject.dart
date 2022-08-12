
class JBMBPostDetailRequestObject{
  int postID;

  JBMBPostDetailRequestObject(this.postID);

  // toJson
  Map<String, dynamic> toJson() =>
      {
        'postID': postID
      };
}

/// 2022.06.21 이승훈
/// 커뮤니티 글 쓰기 요청 오브젝트
class JBMBPostingRequestObject{
  String userID;
  String title;
  String text;

  JBMBPostingRequestObject(this.userID, this.title, this.text);

  // toJson
  Map<String, dynamic> toJson() =>
      {
        'userId': userID,
        'title': title,
        'text': text
      };
}

/// 2022.06.21 이승훈
/// 커뮤니티 글 수정 요청 오브젝트
class JBMBEditingRequestObject{
  int postId;
  String title;
  String text;

  JBMBEditingRequestObject(this.postId, this.title, this.text);

  // toJson
  Map<String, dynamic> toJson() =>
      {
        'postId': postId,
        'title': title,
        'text': text
      };
}

/// 2022.06.22 이승훈
/// 커뮤니티 댓글 요청 오브젝트
class JBMBCommentRequestObject{
  String userId;
  int postId;
  String comment;

  JBMBCommentRequestObject(this.userId, this.postId, this.comment);

  // toJson
  Map<String, dynamic> toJson() =>
      {
        'userId': userId,
        'postId': postId,
        'comment': comment
      };
}