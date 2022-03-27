import 'package:http/http.dart' as http;

import '../object/JBMBMemberInfo.dart';

/// 2022.03.27 이승훈
/// 진단 관련 API와 메소드를 관장하는 클래스
class JBMBDiagnoseManager {
  /// DB에 null이 포함된 진단 기록을 폐기.
  _checkNonActiveDiagnosisLog(JBMBMemberInfo memberInfo) async {
    final response = await http.post(Uri.parse('https://jebalmobal.site/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
    );

    if (response.statusCode == 201){

    }
  }

  /// 새로운 진단을 시작.
  /// returns the int (진단 번호)
  _createNewDiagnosis(JBMBMemberInfo memberInfo) async {
    return 0;
  }
}
