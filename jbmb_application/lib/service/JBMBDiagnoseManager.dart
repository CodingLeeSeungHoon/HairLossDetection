import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:jbmb_application/object/JBMBDiagnosisRequestObject.dart';
import 'package:jbmb_application/object/JBMBDiagnosisResponseObject.dart';

import '../object/JBMBMemberInfo.dart';
import 'JBMBSurveyManager.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// 2022.03.27 이승훈
/// 진단 관련 API와 메소드를 관장하는 클래스
class JBMBDiagnoseManager {
  // member variable
  JBMBSurveyManager surveyManager;
  int? diagnosisID;

  // constructor
  JBMBDiagnoseManager(this.surveyManager);

  // getter
  int? get getDiagnosisID => diagnosisID;

  /// 매니저의 진단 아이디 상태 확인 메소드
  bool isDiagnosisIDNull() {
    return diagnosisID == null ? true : false;
  }

  /// public method
  /// 제출한 결과를 바탕으로 분석 시작
  startAnalysis(String jwtToken) async {
    try {
      JBMBStartAnalysisResponseObject response = await _tryAnalysis(jwtToken);
      if (response.getResultCode != null && response.getResultCode == 0){
        // success
        return true;
      }
      return false;
    } catch (e) {
      log('[JBMBDiagnoseManager] caught Exception : $e');
      return false;
    }
  }

  Future<JBMBStartAnalysisResponseObject> _tryAnalysis(String jwtToken) async {
    final response = await http.post(
      Uri.parse('http://jebalmobal.site/user/diagnosis/hair_loss_detection'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-AUTH-TOKEN': jwtToken
      },
      body: jsonEncode("{'diagnosisID' : $diagnosisID}"),
    );

    if (response.statusCode / 100 == 2) {
      log("[JBMBDiagnoseManager] API Response StatusCode 200 (_tryAnalysis)");
      log(jsonDecode(response.body));
      return JBMBStartAnalysisResponseObject.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      log(
          "[JBMBDiagnoseManager] API Response StatusCode is not 200, throw exception (_tryAnalysis)");
      throw Exception('[Error:Server] 서버 측 오류로 진단 분석에 실패했습니다.');
    }
  }

  /// public method
  /// ImageUrl을 제출하기 위한 메소드
  submitImageUrl(String imageUrl, String jwtToken) async {
    try {
      JBMBSaveImageUrlRequestObject request = JBMBSaveImageUrlRequestObject(diagnosisID, imageUrl);
      JBMBSaveImageResponseObject response = await _trySubmitImageUrl(request, jwtToken);
      if (response.getResultCode != null && response.getResultCode == 0){
        return true;
      } else {
        return false;
      }
    } catch(e) {
      log('[JBMBDiagnoseManager] caught Exception : $e');
      return false;
    }
  }

  /// ImageUrl Server API
  Future<JBMBSaveImageResponseObject> _trySubmitImageUrl(JBMBSaveImageUrlRequestObject requestObject, String jwtToken) async {
    final response = await http.post(
      Uri.parse('http://jebalmobal.site/user/diagnosis/image_link'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-AUTH-TOKEN': jwtToken
      },
      body: jsonEncode(requestObject.toJson()),
    );

    if (response.statusCode / 100 == 2) {
      log("[JBMBDiagnoseManager] API Response StatusCode 200 (_trySubmitImageUrl)");
      log(jsonDecode(response.body));
      return JBMBSaveImageResponseObject.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      log(
          "[JBMBDiagnoseManager] API Response StatusCode is not 200, throw exception (_trySubmitImageUrl)");
      throw Exception('[Error:Server] 서버 측 오류로 이미지 제출에 실패했습니다.');
    }
  }

  /// 새로운 진단을 시작.
  /// returns the int (진단 번호)
  createNewDiagnosis(JBMBMemberInfo memberInfo, String jwtToken) async {
    try {
      JBMBNewDiagnosisResponse response = await _tryInitDiagnosis(memberInfo.getID!, jwtToken);
      switch (response.getResultCode){
        case 0:
          // success
          if (response.getDiagnosisID != null) {
            diagnosisID = response.getDiagnosisID;
          }
          return response.getDiagnosisID ?? -1 ;
        case 1:
          // success & no inactive
          if (response.getDiagnosisID != null) {
            diagnosisID = response.getDiagnosisID;
          }
          return response.getDiagnosisID ?? -1;
        case 2:
          // failed (wrong userID)
          log('[JBMBDiagnoseManager] caught Exception : wrong userID');
          return -1;
      }
    } catch (e) {
      log('[JBMBDiagnoseManager] caught Exception : $e');
      return -1;
    }
  }

  /// 진단 시작 API 사용
  /// 1. inactive 상태의 log 삭제
  /// 2. 새로운 진단 번호 생성 및 리턴
  Future<JBMBNewDiagnosisResponse> _tryInitDiagnosis(String userID, String jwtToken) async {
    final response = await http.post(
      Uri.parse('http://jebalmobal.site/user/diagnosis/disabled'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-AUTH-TOKEN': jwtToken
      },
      body: jsonEncode("{'id': '$userID'}"),
    );

    if (response.statusCode / 100 == 2) {
      log("[JBMBDiagnoseManager] API Response StatusCode 200 (_tryInitDiagnosis)");
      log(jsonDecode(response.body));
      return JBMBNewDiagnosisResponse.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      log(
          "[JBMBDiagnoseManager] API Response StatusCode is not 200, throw exception (_tryInitDiagnosis)");
      throw Exception('[Error:Server] 서버 측 오류로 새로운 진단 아이디 생성에 실패했습니다.');
    }
  }
}
