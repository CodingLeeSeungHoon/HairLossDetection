/// 2022.03.27 이승훈
/// Login API 요청 후 응답 변수들을 포함하고 있는 오브젝트
/// [getResultCode] 결과 코드 : {0: 성공, 1: 존재하지 않은 ID, 2: 비밀번호 오류, 3: 서버 오류}
/// [getJWT] JWT Token
/// [getID] User ID
class JBMBLoginResponseObject {
  // constructor
  JBMBLoginResponseObject();

  // member variable
  int? _resultCode;
  String? _jwt;
  String? _id;

  // getter & setter
  String? get getID => _id;

  set setID(String? id) => _id = id;

  String? get getJWT => _jwt;

  set setJWT(String? jwt) => _jwt = jwt;

  int? get getResultCode => _resultCode;
  
  set setResultCode(int? resultCode) => _resultCode = resultCode;

  // fromJson
  JBMBLoginResponseObject.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _jwt = json['jwt'],
        _resultCode = json['resultCode'];
}
