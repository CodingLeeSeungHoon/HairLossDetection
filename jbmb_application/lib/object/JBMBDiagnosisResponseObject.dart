import 'dart:ffi';

import 'package:jbmb_application/object/JBMBDefaultResponseObject.dart';

/// 2022.04.06 이승훈
/// JBMBNewDiagnosisResponse
/// createNewDiagnosis 메소드에서 API를 통과할 때의 Response
class JBMBNewDiagnosisResponse extends JBMBDefaultResponseObject {
  // member variable
  int? diagnosisID;

  // super fromJson
  JBMBNewDiagnosisResponse.fromJson(Map<String, dynamic> json)
      : diagnosisID = json['diagnosisID'],
        super.fromJson(json);

  // getter
  int? get getDiagnosisID => diagnosisID;
}

/// 2022.04.06 이승훈
/// JBMBSaveSurveyResponseObject
/// 설문조사 저장 API를 통과할 때의 Response
class JBMBSaveSurveyResponseObject extends JBMBNewDiagnosisResponse {
  JBMBSaveSurveyResponseObject.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);
}

/// 2022.04.06 이승훈
/// JBMBSaveSurveyResponseObject
/// 설문조사 저장 API를 통과할 때의 Response
class JBMBSaveImageResponseObject extends JBMBNewDiagnosisResponse {
  JBMBSaveImageResponseObject.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);
}

/// 2022.04.06 이승훈
/// JBMBStartAnalysisResponseObject
/// 이미지, 설문조사를 모두 완료하고 분석을 시작할 때의 Response
class JBMBStartAnalysisResponseObject extends JBMBNewDiagnosisResponse {
  JBMBStartAnalysisResponseObject.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);
}

/// 2022.04.07 이승훈
/// JBMBDiagnosisResultResponseObject
/// 진단 결과 페이지에 띄울 진단 결과를 받아오는 Response Object
class JBMBDiagnosisResultResponseObject extends JBMBDefaultResponseObject {
  // member variable
  int? surveyResult;
  List<double>? percent;

  // constructor
  JBMBDiagnosisResultResponseObject(this.surveyResult, this.percent) : super(0);

  // fromJson function
  JBMBDiagnosisResultResponseObject.fromJson(Map<String, dynamic> json)
      : surveyResult = json['surveyResult'],
        percent = json['percent'],
        super.fromJson(json);

  // getter
  int? get getSurveyResult => surveyResult;
  set setSurveyResult(int? _surveyResult) => surveyResult = _surveyResult;

  List<double>? get getPercent => percent;
  set setPercent(List<double>? _percent) => percent = _percent;

  // null check method
  bool isSurveyResultNull() {
    return surveyResult == null ? true : false;
  }

  bool isPercentNull() {
    return percent == null ? true : false;
  }
}
