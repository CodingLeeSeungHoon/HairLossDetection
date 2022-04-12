import 'dart:convert';
import 'dart:developer';

import 'package:jbmb_application/object/JBMBDiagnosisLogsObject.dart';
import 'package:http/http.dart' as http;

/// 2022.04.12 이승훈
/// 진단 로그를 관리하는 매니저 클래스
class JBMBDiagnoseLogManager {

  /// public method
  /// UserID를 기반으로 진단 히스토리 로그를 모두 가져온다.
  /// returns the JBMBDiagnosisLogsObject?
  getDiagnosisLogByUserID(String jwtToken, String userID) async {
    try {
      JBMBDiagnosisLogsObject response = await _tryToGetDiagnosisLogByUserID(jwtToken, userID);
      return response;
    } catch (e) {
      log('[JBMBDiagnoseLogManager] caught Exception : $e');
      return null;
    }
  }

  /// private method
  /// 진단 히스토리를 불러오는 API
  Future<JBMBDiagnosisLogsObject> _tryToGetDiagnosisLogByUserID(
      String jwtToken, String userID) async {
    final response = await http.get(
      Uri.parse('http://jebalmobal.site/user/diagnosis/date_list/$userID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-AUTH-TOKEN': jwtToken
      },
    );

    if (response.statusCode / 100 == 2) {
      log("[JBMBDiagnoseLogManager] API Response StatusCode 200 (_tryToGetDiagnosisLogByUserID)");
      log(jsonDecode(response.body));
      return JBMBDiagnosisLogsObject.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      log("[JBMBDiagnoseLogManager] API Response StatusCode is not 200, throw exception (_tryToGetDiagnosisLogByUserID)");
      throw Exception('[Error:Server] 서버 측 오류로 진단 결과 목록 불러오기에 실패했습니다.');
    }
  }
}
