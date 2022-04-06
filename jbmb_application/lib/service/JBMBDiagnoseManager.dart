import 'package:http/http.dart' as http;

import '../object/JBMBMemberInfo.dart';
import 'JBMBSurveyManager.dart';

/// 2022.03.27 이승훈
/// 진단 관련 API와 메소드를 관장하는 클래스
class JBMBDiagnoseManager {
  // member variable
  JBMBSurveyManager surveyManager;
  int? diagnosisID;

  // constructor
  JBMBDiagnoseManager(this.surveyManager);

  /// 매니저의 진단 아이디 상태 확인 메소드
  bool isDiagnosisIDNull() {
    return diagnosisID == null ? true : false;
  }

  /// 새로운 진단을 시작.
  /// returns the int (진단 번호)
  _createNewDiagnosis(JBMBMemberInfo memberInfo) async {
    return 0;
  }

}
