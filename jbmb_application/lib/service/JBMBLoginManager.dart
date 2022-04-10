import 'dart:developer';

import 'package:jbmb_application/object/JBMBDefaultResponseObject.dart';
import 'package:jbmb_application/object/JBMBMemberInfo.dart';

import '../object/JBMBLoginRequestObject.dart';
import '../object/JBMBLoginResponseObject.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// 2022.03.14 이승훈
/// 로그인 컨트롤러
class JBMBLoginManager {
  /// 로그인 요청하는 메소드
  /// ID, PW 담고 있는 [loginInput]을 파라미터로 받고,
  /// 로그인 결과(JBMBLoginResult)를 리턴한다.
  Future<JBMBLoginResponseObject> requestLogin(
      JBMBLoginRequestObject loginInput) async {
    JBMBLoginResponseObject jbmbLoginResult = JBMBLoginResponseObject();
    if (_checkLoginField(loginInput)) {
      try {
        JBMBLoginResponseObject response = await _tryLogin(loginInput);
        return response;
      } catch (e) {
        log("[JBMBLoginManager] JBMB Server Error (RequestCode Not 200)");
        jbmbLoginResult.setResultCode = 3;
      }
    }
    return jbmbLoginResult;
  }

  /// Login 페이지의 텍스트 필드 유효성을 확인하는 메소드
  bool _checkLoginField(JBMBLoginRequestObject loginInput) {
    if (loginInput.getID != null && loginInput.getPW != null) {
      return true;
    }
    return false;
  }

  /// use Login API
  Future<JBMBLoginResponseObject> _tryLogin(
      JBMBLoginRequestObject loginRequestObject) async {
    log(jsonEncode(loginRequestObject.toJson()));
    final response = await http.post(
      Uri.parse('http://jebalmobal.site/user/account/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(loginRequestObject.toJson()),
    );


    // check response
    // log(response.statusCode.toString());
    // log(response.body);

    if (response.statusCode / 100 == 2) {
      log("[JBMBLoginManager] API Response StatusCode 200 (tryLogin)");
      return JBMBLoginResponseObject.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      log(
          "[JBMBLoginManager] API Response StatusCode is not 200 (tryLogin), throw Exception");
      throw Exception('[Error:Server] 서버 측 오류로 로그인에 실패했습니다.');
    }
  }

  /// requestLogin의 코드가 승인인 경우 호출되는 메소드
  /// [jwtToken]를 통해 MemberInfo를 DB로부터 받아오는 메소드
  /// LoginedHome에 MemberInfo를 넘겨주기 위해 존재.
  Future<JBMBMemberInfo> getMemberInfoByToken(String jwtToken) async {
    JBMBMemberInfo memberInfo = await _tryGetMemberInfo(jwtToken);
    return memberInfo;
  }

  /// get MemberInfo using API
  Future<JBMBMemberInfo> _tryGetMemberInfo(String jwtToken) async {
    final response = await http.get(
      Uri.parse('http://jebalmobal.site/user/account/info'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-AUTH-TOKEN': jwtToken
      },
    );

    // check response
    // log(response.statusCode.toString());
    // log(response.body);

    if (response.statusCode / 100 == 2) {
      log("[JBMBLoginManager] API Response StatusCode 200 (tryGetMemberInfo)");
      return JBMBMemberInfo.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      log(
          "[JBMBLoginManager] API Response StatusCode is not 200 (tryGetMemberInfo), throw Exception");
      throw Exception('[Error:Server] 서버 측 오류로 회원정보 얻어오기를 실패했습니다.');
    }
  }

  /// try Logout using API
  Future<JBMBDefaultResponseObject> tryLogout(String jwtToken) async {
    final response = await http.post(
      Uri.parse('http://jebalmobal.site/user/account/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-AUTH-TOKEN': jwtToken
      },
    );

    // check response
    // log(response.statusCode.toString());
    // log(response.body);

    if (response.statusCode / 100 == 2) {
      log("[JBMBLoginManager] API Response StatusCode 200 (tryLogout)");
      return JBMBDefaultResponseObject.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      int statusCode = response.statusCode;
      log(
          "[JBMBLoginManager] API Response StatusCode is not 200 (tryLogout), throw Exception");
      throw Exception('[Error:Server] Logout StatusCode : $statusCode');
    }
  }
}
