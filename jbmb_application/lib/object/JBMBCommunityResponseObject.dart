
/// 2022.06.16 이한범
/// community API response object
class JBMBCommunityResponseObject {
  // member variable
  final List<JBMBCommunityItems>? _CommunityItemsList;

  // constructor
  JBMBCommunityResponseObject(this._CommunityItemsList);

  // getter
  List<JBMBCommunityItems>? get getPostItemsList => _CommunityItemsList;

  // factory func : fromJson
  factory JBMBCommunityResponseObject.fromJson(Map<String, dynamic> parsedJson){
    var list = parsedJson['items'] as List;
    List<JBMBCommunityItems> PostList = list.map((i) => JBMBCommunityItems.fromJson(i)).toList();

    return JBMBCommunityResponseObject(PostList);
  }
}

/// 2022.06.16
/// Community object
/// 게시글 정보를 담고 있는 객체
class JBMBCommunityItems {
  // member variable
  final String? _title;
  final String? _author;
  final int? _postId;
  final String? _date;

  // constructor
  JBMBCommunityItems(this._title, this._author, this._postId, this._date);

  // Getter
  String? get getTitle => _title;

  String? get getAuthor => _author;

  int? get getPostId => _postId;

  String? get getDate => _date;

  // factory func : fromJson
  factory JBMBCommunityItems.fromJson(Map<String, dynamic> parsedJson){
    return JBMBCommunityItems(
        parsedJson['title'], parsedJson['userName'], parsedJson['postId'], parsedJson['createdAt']);
  }

}

/// 2022.06.16
/// 게시글 상세 정보 객체
class JBMBPostDetailResponseObject {
  // member variable
  final String? _title;
  final String? _content;
  final String? _userID;
  final String? _date;
  final List<JBMBCommentItems>? _CommentItemsList;

  // constructor
  JBMBPostDetailResponseObject(this._title, this._content,
      this._userID, this._date, this._CommentItemsList);

  // getter
  String? get getTitle => _title;
  String? get getContent => _content;
  String? get getUserID => _userID;
  String? get getDate => _date;
  List<JBMBCommentItems>? get getCommentItemsList => _CommentItemsList;

  // factory func : fromJson
  factory JBMBPostDetailResponseObject.fromJson(Map<String, dynamic> parsedJson){
    var list = parsedJson['items'] as List;
    List<JBMBCommentItems> _CommentItemsList = list.map((i) => JBMBCommentItems.fromJson(i)).toList();

    return JBMBPostDetailResponseObject(parsedJson['title'], parsedJson['text'],
        parsedJson['userID'], parsedJson['createdAt'], _CommentItemsList);
  }
}

/// 2022.06.16
/// 게시글에 달린 댓글 객체
class JBMBCommentItems {
  // member variable
  final String? _id;
  final String? _comment;
  final String? _date;

  // constructor
  JBMBCommentItems(this._id, this._comment, this._date);

  // Getter
  String? get getId => _id;

  String? get getComment => _comment;

  String? get getDate => _date;

  // factory func : fromJson
  factory JBMBCommentItems.fromJson(Map<String, dynamic> parsedJson){
    return JBMBCommentItems(
        parsedJson['userID'], parsedJson['comment'], parsedJson['createdAt']);
  }

}