
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:jbmb_application/object/JBMBCommunityRequestObject.dart';
import 'package:jbmb_application/object/JBMBCommunityResponseObject.dart';
import 'package:jbmb_application/object/JBMBDefaultResponseObject.dart';

/// 2022.06.16 이한범
/// 커뮤니티 관련 API를 사용하기 위한 매니저 인스턴스
class JBMBCommunityManager{
  int callCnt = 1;

  // constructor
  JBMBCommunityManager();

  /// public method
  /// 게시글 목록을 가져올 수 있는 메소드
  /// 호출 시마다 자동으로 다음 20개의 목록을 가져올 수 있다.
  getPostList(String jwtToken) async {
    try{
      JBMBCommunityResponseObject response = await _tryToGetPostListByCount(jwtToken, callCnt);
      callCnt += 1;
      return response;
    } catch (e){
      log('[JBMBCommunityManager] caught Exception : $e');
      return null;
    }
  }

  /// private method
  /// 게시글 목록 리턴 API 호출
  Future<JBMBCommunityResponseObject> _tryToGetPostListByCount(String jwtToken, int callCnt) async {
    final response = await http.get(
      Uri.parse('http://jebalmobal.site/user/board/list?callCnt=$callCnt'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-AUTH-TOKEN': jwtToken
      },
    );

    if (response.statusCode / 100 == 2) {
      log("[JBMBCommunityManager] API Response StatusCode 200 (_tryToGetPostListByCount)");
      return JBMBCommunityResponseObject.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      log(
          "[JBMBCommunityManager] API Response StatusCode is not 200, throw exception (_tryToGetPostListByCount)");
      throw Exception('[Error:Server] 서버 측 오류로 게시글 리스트 불러오기에 실패했습니다.');
    }
  }

  /// public method
  /// 게시글 내용을 가져올 수 있는 메소드
  getPostDetail(String jwtToken, postId) async {
    try{
      JBMBPostDetailResponseObject response = await _tryToGetPostDetailByPostID(jwtToken, postId!);
      return response;
    } catch (e){
      log('[JBMBCommunityManager] caught Exception : $e');
      return null;
    }
  }

  /// private method
  /// 게시글 내용 리턴 API 호출
  Future<JBMBPostDetailResponseObject> _tryToGetPostDetailByPostID(String jwtToken, int postID) async {
    final response = await http.get(
      Uri.parse('http://jebalmobal.site/user/board/contents?postId=$postID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-AUTH-TOKEN': jwtToken
      }
    );

    if (response.statusCode / 100 == 2) {
      log("[JBMBCommunityManager] API Response StatusCode 200 (_tryToGetPostDetailByPostID)");
      return JBMBPostDetailResponseObject.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      log(
          "[JBMBCommunityManager] API Response StatusCode is not 200, throw exception (_tryToGetPostDetailByPostID)");
      throw Exception('[Error:Server] 서버 측 오류로 게시글 내용 불러오기에 실패했습니다.');
    }
  }

  /// public method
  /// 게시글 삭제 메소드
  deletePost(String jwtToken, int postID) async {
    try{
      JBMBDefaultResponseObject response = await _tryDeletePost(jwtToken, postID);
      return response;
    } catch (e){
      log('[JBMBCommunityManager] caught Exception : $e');
      return null;
    }
  }

  Future<JBMBDefaultResponseObject> _tryDeletePost(String jwtToken, int postID) async {
    final response = await http.post(
      Uri.parse('http://jebalmobal.site/user/board/contents/post/delete'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-AUTH-TOKEN': jwtToken
      },
      body: jsonEncode({'postId': postID}),
    );

    if (response.statusCode / 100 == 2) {
      log("[JBMBCommunityManager] API Response StatusCode 200");
      return JBMBDefaultResponseObject.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      log(
          "[JBMBCommunityManager] API Response StatusCode is not 200, throw exception");
      throw Exception('[Error:Server] 서버 측 오류로 글 삭제에 실패했습니다.');
    }
  }

  /// 2022.06.22 이승훈
  /// 댓글 삭제 public method
  deleteComment(String jwtToken, int commentId) async {
    try{
      JBMBDefaultResponseObject response = await _tryDeleteComment(jwtToken, commentId);
      return response;
    } catch (e){
      log('[JBMBCommunityManager] caught Exception : $e');
      return null;
    }
  }

  /// 2022.06.22 이승훈
  /// 댓글 삭제 private method with API
  Future<JBMBDefaultResponseObject> _tryDeleteComment(String jwtToken, int commentId) async {
    final response = await http.post(
      Uri.parse('http://jebalmobal.site/user/board/contents/comment/delete'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-AUTH-TOKEN': jwtToken
      },
      body: jsonEncode({'commentId': commentId}),
    );

    if (response.statusCode / 100 == 2) {
      log("[JBMBCommunityManager] API Response StatusCode 200");
      return JBMBDefaultResponseObject.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      log(
          "[JBMBCommunityManager] API Response StatusCode is not 200, throw exception");
      throw Exception('[Error:Server] 서버 측 오류로 댓글 삭제에 실패했습니다.');
    }
  }
}