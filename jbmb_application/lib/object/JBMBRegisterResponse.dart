/// 2022.03.08 이승훈
/// JBMBRegisterResult
/// 회원가입 최종 결과 Object (텍스트 필드 유효성 + API 아이디 중복 모두 확인된 최종 결과)
class JBMBRegisterResult{
  int? _resultCode;
  late String _result;

  int? get getResultCode => _resultCode;
  set setResultCode(int resultCode) => {_resultCode = resultCode};

  String get getResult => _result;
  set setResult(String result) => {_result = result};

}

/// 2022.03.22 이승훈
/// JBMBRegisterResponseObject
/// Register API Response
class JBMBRegisterResponseObject{
  int _resultCode;

  int get getResultCode => _resultCode;
  set setResultCode(int resultCode) => {_resultCode = resultCode};

  JBMBRegisterResponseObject.fromJson(Map<String, dynamic> json)
      : _resultCode = json['resultCode'];
}