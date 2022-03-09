/// 2022.03.08 이승훈
/// JBMBRegisterResult
/// 회원가입 API로부터 Return 받은 JSON을 객체화
class JBMBRegisterResult{
  int? _resultCode;
  String? _result;

  int? get getResultCode => _resultCode;
  set setResultCode(int resultCode) => {_resultCode = resultCode};

  String? get getResult => _result;
  set setResult(String result) => {_result = result};

}