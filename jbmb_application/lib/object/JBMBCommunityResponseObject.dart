
import 'dart:developer';

import 'package:flutter/material.dart';

/// 2022.06.16 이한범
/// community API response object
class JBMBCommunityResponseObject {
  // member variable
  final List<JBMBCommunityItems>? _communityItemsList;
  int resultCode;

  // constructor
  JBMBCommunityResponseObject(this._communityItemsList, this.resultCode);

  // getter
  List<JBMBCommunityItems>? get getPostItemsList => _communityItemsList;

  // factory func : fromJson
  factory JBMBCommunityResponseObject.fromJson(Map<String, dynamic> parsedJson){
    int resultCode = parsedJson['resultCode'] as int;
    var list = parsedJson['postList'] as List;
    List<JBMBCommunityItems> PostList = list.map((i) => JBMBCommunityItems.fromJson(i)).toList();

    return JBMBCommunityResponseObject(PostList, resultCode);
  }
}

/// 2022.06.16
/// Community object
/// 게시글 정보를 담고 있는 객체
class JBMBCommunityItems {
  // member variable
  final String? _title;
  final String? _userId;
  final int? _postId;
  final String? _date;

  // constructor
  JBMBCommunityItems(this._title, this._userId, this._postId, this._date);

  // Getter
  String? get getTitle => _title;

  String? get getUserId => _userId;

  int? get getPostId => _postId;

  String? get getDate => _date;

  // factory func : fromJson
  factory JBMBCommunityItems.fromJson(Map<String, dynamic> parsedJson){
    return JBMBCommunityItems(
        parsedJson['title'], parsedJson['userId'], parsedJson['postId'], parsedJson['createdAt']);
  }

}

/// 2022.06.16
/// 게시글 상세 정보 객체
class JBMBPostDetailResponseObject {
  // member variable
  final int? _resultCode;
  final String? _title;
  final String? _content;
  final String? _userID;
  final String? _date;
  final List<JBMBCommentItems>? _commentItemsList;

  // constructor
  JBMBPostDetailResponseObject(this._resultCode, this._title, this._content,
      this._userID, this._date, this._commentItemsList);

  // getter
  String? get getTitle => _title;
  String? get getContent => _content;
  String? get getUserID => _userID;
  String? get getDate => _date;
  List<JBMBCommentItems>? get getCommentItemsList => _commentItemsList;

  // factory func : fromJson
  factory JBMBPostDetailResponseObject.fromJson(Map<String, dynamic> parsedJson){
    int resultCode = parsedJson['resultCode'] as int;
    String title = parsedJson['title'] as String;
    String content = parsedJson['content'] as String;
    String userId = parsedJson['userId'] as String;
    String createdAt = parsedJson['createdAt'] as String;

    log(resultCode.toString() + title + content + userId + createdAt);

    try {
      var list = parsedJson['commentList'] as List;
      List<JBMBCommentItems> commentItemsList = list.map((i) => JBMBCommentItems.fromJson(i)).toList();
      return JBMBPostDetailResponseObject(resultCode, title, content, userId, createdAt, commentItemsList);
    } catch(e) {
      return JBMBPostDetailResponseObject(resultCode, title, content, userId, createdAt, null);
    }
  }
}

/// 2022.06.16
/// 게시글에 달린 댓글 객체
class JBMBCommentItems {
  // member variable
  final int? _commentId;
  final String? _id;
  final String? _comment;
  final String? _date;


  // constructor
  JBMBCommentItems(this._commentId, this._id, this._comment, this._date);

  // Getter
  String? get getId => _id;

  String? get getComment => _comment;

  String? get getDate => _date;

  int? get getCommentId => _commentId;

  // factory func : fromJson
  factory JBMBCommentItems.fromJson(Map<String, dynamic> parsedJson){
    return JBMBCommentItems(
        parsedJson['commentId'], parsedJson['userId'], parsedJson['comment'], parsedJson['createdAt']);
  }

}