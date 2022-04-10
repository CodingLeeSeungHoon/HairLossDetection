import 'dart:convert';
import 'dart:developer';

import 'package:jbmb_application/object/JBMBDefaultResponseObject.dart';
import 'package:jbmb_application/service/JBMBJwtManager.dart';

import '../object/JBMBMemberInfo.dart';
import 'package:http/http.dart' as http;


/// 2022.03.27 이승훈
/// LoginedHome 페이지 이후 페이지에서 관리되는 모든 회원 정보 관리는 해당 매니저를 통해서 이루어짐.
/// [JBMBMemberInfo]와 [JBMBJwtManager]를 통해 관리
class JBMBMemberManager {
  // member variable
  JBMBMemberInfo memberInfo;
  JBMBJwtManager jwtManager;

  // constructor
  JBMBMemberManager(this.memberInfo, this.jwtManager);

  // 헤어 타입을 가지고 있는지 확인
  bool hasHairType() {
    if (memberInfo.getHairType != null) {
      return true;
    } else {
      return false;
    }
  }

  /// update member info using api
  Future<JBMBDefaultResponseObject> _tryUpdateMemberInfo(
      JBMBMemberInfo jbmbMemberInfo) async {
    final response = await http.post(
      // TODO : change uri
      Uri.parse('http://jebalmobal.site/user/account/---'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(memberInfo.toJson()),
    );

    if (response.statusCode / 100 == 2) {
      log("[JBMBMemberManager] API Response StatusCode 200");
      log(jsonDecode(response.body));
      return JBMBDefaultResponseObject.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      log(
          "[JBMBMemberManager] API Response StatusCode is not 200, throw exception");
      throw Exception('[Error:Server] 서버 측 오류로 정보 업데이트에 실패했습니다.');
    }
  }

  /// 2022.03.27 이승훈
  /// JBMBMemberManager의 [memberInfo]를 최신화하는 메소드
  /// 샴푸 업데이트, 정보 변경에 사용
  Future<bool> updateMemberInfo(JBMBMemberInfo jbmbMemberInfo) async {
    try {
      // save server
      JBMBDefaultResponseObject response = await _tryUpdateMemberInfo(
          jbmbMemberInfo);
      // save instance
      memberInfo = jbmbMemberInfo;
      return true;
    } catch (e) {
      log('[JBMBMemberManager] caught Exception : $e');
      return false;
    }
  }

}
