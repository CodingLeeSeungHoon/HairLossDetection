import 'package:jbmb_application/object/JBMBDefaultResponseObject.dart';

/// 2022.04.06 이승훈
/// JBMBNewDiagnosisResponse
/// createNewDiagnosis 메소드에서 API를 통과할 때의 Response
class JBMBNewDiagnosisResponse extends JBMBDefaultResponseObject{
  // member variable
  int? diagnosisID;

  // super fromJson
  JBMBNewDiagnosisResponse.fromJson(Map<String, dynamic> json) :
        diagnosisID = json['diagnosisID'],
        super.fromJson(json);

  // getter
  int? get getDiagnosisID => diagnosisID;

}

/// 2022.04.06 이승훈
/// JBMBSaveSurveyResponseObject
/// 설문조사 저장 API를 통과할 때의 Response
class JBMBSaveSurveyResponseObject extends JBMBNewDiagnosisResponse{
  JBMBSaveSurveyResponseObject.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}

/// 2022.04.06 이승훈
/// JBMBSaveSurveyResponseObject
/// 설문조사 저장 API를 통과할 때의 Response
class JBMBSaveImageResponseObject extends JBMBNewDiagnosisResponse{
  JBMBSaveImageResponseObject.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}

/// 2022.04.06 이승훈
/// JBMBStartAnalysisResponseObject
/// 이미지, 설문조사를 모두 완료하고 분석을 시작할 때의 Response
class JBMBStartAnalysisResponseObject extends JBMBNewDiagnosisResponse{
  JBMBStartAnalysisResponseObject.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}