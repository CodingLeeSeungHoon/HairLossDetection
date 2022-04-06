/// 2022.03.14 이승훈
/// 로그인 텍스트 필드에서 아이디와 비밀번호를 담는 오브젝트
/// [id] userID
/// [pw] userPW
class JBMBLoginRequestObject {
  // member variable
  String? _id;
  String? _pw;

  // getter & setter
  String? get getID => _id;

  set setID(String? id) => _id = id;

  String? get getPW => _pw;

  set setPW(String? pw) => _pw = pw;

  // toJson
  Map<String, dynamic> toJson() =>
      {
        'id': _id,
        'password': _pw
      };
}