/// 2022.03.08 이승훈
/// JBMBRegister
/// 회원가입 각 필드 값 모두 저장하는 객체, API RequestBody로 JSON Parsing을 거쳐 사용될 예정
class JBMBRegister{
  String? _id;
  String? _pw;
  String? _name;
  String? _phone;
  String? _email;
  int? _age;
  String? _sex;

  String? get getID => _id;
  set setID(String id) => _id = id;

  String? get getPW => _pw;
  set setPW(String pw) => _pw = pw;

  String? get getName => _name;
  set setName(String name) => _name = name;

  String? get getPhone => _phone;
  set setPhone(String phone) => _phone = phone;

  String? get getEmail => _email;
  set setEmail(String email) => _email = email;

  String? get getSex => _sex;
  set setSex(String sex) => _sex = sex;

  int? get getAge => _age;
  set setAge(int age) => _age = age;

}