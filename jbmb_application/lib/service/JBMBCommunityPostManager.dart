
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:jbmb_application/object/JBMBCommunityRequestObject.dart';
import 'package:jbmb_application/object/JBMBDefaultResponseObject.dart';
import 'package:jbmb_application/service/JBMBMemberManager.dart';

/// 2022.06.20 이승훈
/// 커뮤니티 글, 댓글 게시용 매니저
class JBMBCommunityPostManager {
  JBMBMemberManager? memberManager;

  // constructor
  JBMBCommunityPostManager(this.memberManager);

  /// 제목 및 텍스트 입력 여부 확인 메소드
  bool checkBlank(String title, String text){
    if (title.isEmpty & text.isEmpty){
      return true;
    }
    return false;
  }

  /// 2022.06.21 이승훈
  /// public method
  /// 커뮤니티 게시판 글 쓰기 메소드
  uploadPostInCommunity(String jwtToken, String userID, String title, String text) async {
    try {
      JBMBDefaultResponseObject response = await _tryToUploadPost(jwtToken, JBMBPostingRequestObject(userID, title, text));
      if (response.getResultCode == 0){
        // 성공
        return true;
      } else {
        // 실패
        log('[JBMBCommunityPostManager] returned ResultCode is Failure Code');
        return false;
      }
    } catch (e) {
      log('[JBMBCommunityPostManager] caught Exception : $e');
      return false;
    }
  }

  /// 2022.06.21 이승훈
  /// private method
  /// 글 쓰기 API
  Future<JBMBDefaultResponseObject> _tryToUploadPost (String jwtToken, JBMBPostingRequestObject postingRequestObject) async {
    final response = await http.post(
      Uri.parse('http://jebalmobal.site/user/board/contents/post'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-AUTH-TOKEN': jwtToken
      },
      body: jsonEncode(postingRequestObject.toJson()),
    );

    if (response.statusCode / 100 == 2) {
      log("[JBMBCommunityPostManager] API Response StatusCode 200 (_tryToUploadPost)");
      // log(jsonDecode(response.body));
      return JBMBDefaultResponseObject.fromJson(
          jsonDecode(response.body));
    } else {
      log(
          "[JBMBCommunityPostManager] API Response StatusCode is not 200, throw exception (_tryToUploadPost)");
      throw Exception('[Error:Server] 서버 측 오류로 글 쓰기에 실패했습니다');
    }
  }

  /// 2022.06.21 이승훈
  /// public method
  /// 커뮤니티 게시판 수정 메소드
  editPostInCommunity(String jwtToken, int postID, String title, String text) async {
    try {
      JBMBDefaultResponseObject response = await _tryToEditPost(jwtToken, JBMBEditingRequestObject(postID, title, text));
      if (response.getResultCode == 0){
        // 성공
        return true;
      } else {
        // 실패
        log('[JBMBCommunityPostManager] returned ResultCode is Failure Code');
        return false;
      }
    } catch (e) {
      log('[JBMBCommunityPostManager] caught Exception : $e');
      return false;
    }
  }

  /// 2022.06.21 이승훈
  /// private method
  /// 글 수정 API
  Future<JBMBDefaultResponseObject> _tryToEditPost (String jwtToken, JBMBEditingRequestObject editingRequestObject) async {
    final response = await http.post(
      Uri.parse('http://jebalmobal.site/user/board/contents/post/edit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-AUTH-TOKEN': jwtToken
      },
      body: jsonEncode(editingRequestObject.toJson()),
    );

    if (response.statusCode / 100 == 2) {
      log("[JBMBCommunityPostManager] API Response StatusCode 200 (_tryToEditPost)");
      // log(jsonDecode(response.body));
      return JBMBDefaultResponseObject.fromJson(
          jsonDecode(response.body));
    } else {
      log(
          "[JBMBCommunityPostManager] API Response StatusCode is not 200, throw exception (_tryToEditPost)");
      throw Exception('[Error:Server] 서버 측 오류로 글 수정에 실패했습니다');
    }
  }

  /// 2022.06.22 이승훈
  /// public method
  /// 포스트에 댓글 남기기
  commentInPost(String jwtToken, String userID, int postID, String comment) async {
    try {
      JBMBDefaultResponseObject response = await _tryToComment(jwtToken, JBMBCommentRequestObject(userID, postID, comment));
      if (response.getResultCode == 0){
        // 성공
        return true;
      } else {
        // 실패
        log('[JBMBCommunityPostManager] returned ResultCode is Failure Code');
        return false;
      }
    } catch (e) {
      log('[JBMBCommunityPostManager] caught Exception : $e');
      return false;
    }
  }

  /// 2022.06.22 이승훈
  /// private method
  /// 글 수정 API
  Future<JBMBDefaultResponseObject> _tryToComment (String jwtToken, JBMBCommentRequestObject commentRequestObject) async {
    final response = await http.post(
      Uri.parse('http://jebalmobal.site/user/board/contents/comment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-AUTH-TOKEN': jwtToken
      },
      body: jsonEncode(commentRequestObject.toJson()),
    );

    if (response.statusCode / 100 == 2) {
      log("[JBMBCommunityPostManager] API Response StatusCode 200 (_tryToComment)");
      return JBMBDefaultResponseObject.fromJson(
          jsonDecode(response.body));
    } else {
      log(
          "[JBMBCommunityPostManager] API Response StatusCode is not 200, throw exception (_tryToComment)");
      throw Exception('[Error:Server] 서버 측 오류로 댓글 달기에 실패했습니다');
    }
  }
}