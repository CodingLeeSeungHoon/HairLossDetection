import 'dart:convert';
import 'dart:developer';

import 'package:jbmb_application/object/JBMBDiagnosisRequestObject.dart';
import 'package:jbmb_application/object/JBMBDiagnosisResponseObject.dart';
import 'package:jbmb_application/object/JBMBMemberInfo.dart';
import 'package:http/http.dart' as http;

/// 2022.03.14 이승훈
/// Survey 컨트롤러
class JBMBSurveyManager {

  /// 각 설문조사 결과를 DB에 저장하는 메소드
  Future<bool> saveSurveyInput(int diagnosisID, String qNum, int answer, String jwtToken) async {
    int surveyNum = int.parse(qNum.substring(1, qNum.length - 1));
    try {
      JBMBSaveSurveyResponseObject response = await _trySaveSurveyResult(JBMBSaveSurveyRequestObject(diagnosisID, surveyNum, answer), jwtToken);
      if (response.getResultCode == 0){
        // success
        return true;
      } else {
        // failed
        return false;
      }
    } catch(e) {
      log('[JBMBSurveyManager] caught Exception : $e');
      return false;
    }
  }

  Future<JBMBSaveSurveyResponseObject> _trySaveSurveyResult(JBMBSaveSurveyRequestObject requestObject, String jwtToken) async {
    final response = await http.post(
      Uri.parse('http://jebalmobal.site/user/diagnosis/update_survey'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-AUTH-TOKEN': jwtToken
      },
      body: jsonEncode(requestObject.toJson()),
    );

    if (response.statusCode / 100 == 2) {
      log("[JBMBSurveyManager] API Response StatusCode 200");
      // log(jsonDecode(response.body));
      return JBMBSaveSurveyResponseObject.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      log(
          "[JBMBSurveyManager] API Response StatusCode is not 200, throw exception");
      throw Exception('[Error:Server] 서버 측 오류로 설문 진단 저장에 실패했습니다.');
    }
  }
}