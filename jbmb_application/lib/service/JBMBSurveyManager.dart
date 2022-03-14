import 'package:jbmb_application/object/JBMBMemberInfo.dart';

/// 2022.03.14 이승훈
/// Survey 컨트롤러
class JBMBSurveyManager{
  
  /// 각 설문조사 결과를 DB에 저장하는 메소드
  saveSurveyInput(int surveyId, String qNum, bool answer){
    int surveyNum = int.parse(qNum.substring(1, qNum.length-1));

  }
  
  /// 새로운 설문조사 DB Row를 생성하고, surveyId를 얻어온다.
  int getNewSurveyId(JBMBMemberInfo memberInfo){
    return 0;
  }
}