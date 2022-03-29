/// 2022.03.08 이승훈
/// JBMBRegisterResult
/// 회원가입 최종 결과 Object (텍스트 필드 유효성 + API 아이디 중복 모두 확인된 최종 결과)
/// [getResultCode] 최종 회원가입 응답코드 ->
/// {0: 완료,
/// 1: 빈 칸 혹은 유효하지 않은 필드,
/// 2: 4자리 이상 ID/PW,
/// 3: 유효하지 않은 핸드폰 번호,
/// 4: 유효하지 않은 이메일 형식,
/// 5: 중복된 아이디,
/// 6: 회원가입 실패}
class JBMBRegisterResult {
  int? _resultCode;
  String? _result;

  int? get getResultCode => _resultCode;

  set setResultCode(int resultCode) => {_resultCode = resultCode};

  String? get getResult => _result;

  set setResult(String? result) => {_result = result};
}

/// 2022.03.22 이승훈
/// JBMBRegisterResponseObject
/// Register API Response
/// [getResultCode] 서버로부터 받아온 응답 코드, {0 : 성공, 1: 중복된 아이디, 2: 실패}
class JBMBRegisterResponseObject {
  int _resultCode;

  int get getResultCode => _resultCode;

  set setResultCode(int resultCode) => {_resultCode = resultCode};

  JBMBRegisterResponseObject.fromJson(Map<String, dynamic> json)
      : _resultCode = json['resultCode'];
}
