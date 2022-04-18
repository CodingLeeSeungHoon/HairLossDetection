
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:jbmb_application/object/JBMBShampooRequestObject.dart';
import 'package:jbmb_application/object/JBMBShampooResponseObject.dart';

/// 2022.04.18 이승훈
/// 샴푸 관련 API를 사용하기 위한 매니저 인스턴스
/// 샴푸페이지 입장 전, 생성자로 생성 후 접근.
class JBMBShampooManager{
  final int? hairType;
  int callCnt = 1;

  // constructor
  JBMBShampooManager(this.hairType);

  /// public method
  /// 샴푸 목록을 가져올 수 있는 메소드
  /// 호출 시마다 자동으로 다음 20개의 목록을 가져올 수 있다.
  getShampoo(String jwtToken) async {
    try{
      JBMBShampooRequestObject request = JBMBShampooRequestObject(callCnt, hairType!);
      JBMBShampooResponseObject response = await _tryToGetShampooListByCount(jwtToken, request);
      callCnt += 1;
      return response;
    } catch (e){
      log('[JBMBShampooManager] caught Exception : $e');
      return null;
    }
  }

  /// private method
  /// 샴푸 목록 리턴 API 호출
  Future<JBMBShampooResponseObject> _tryToGetShampooListByCount(String jwtToken, JBMBShampooRequestObject request) async {
    final response = await http.post(
      Uri.parse('http://jebalmobal.site/user/shampoo/shampoo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-AUTH-TOKEN': jwtToken
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode / 100 == 2) {
      log("[JBMBShampooManager] API Response StatusCode 200 (_tryToGetShampooListByCount)");
      return JBMBShampooResponseObject.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      log(
          "[JBMBShampooManager] API Response StatusCode is not 200, throw exception (_tryToGetShampooListByCount)");
      throw Exception('[Error:Server] 서버 측 오류로 샴푸 리스트 불러오기에 실패했습니다.');
    }
  }
}