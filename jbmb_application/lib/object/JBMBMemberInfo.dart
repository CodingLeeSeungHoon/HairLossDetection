/// 2022.03.08 이승훈
/// 회원가입 각 필드 값 모두 저장하는 객체, API RequestBody로 사용
/// [id] String userID
/// [passWord] String userPW
/// [name] String userName
/// [phoneNumber] String user phoneNumber
/// [email] String user email
/// [age] int user age
/// [sex] String user sex
/// [hairType] int user hairType
class JBMBMemberInfo {
  // member variable
  String? id;
  String? passWord;
  String? name;
  String? phoneNumber;
  String? email;
  int? age;
  String? sex;
  int? hairType;

  // empty constructor
  JBMBMemberInfo();

  // getter & setter
  String? get getID => id;

  set setID(String? inputID) => id = inputID;

  String? get getPW => passWord;

  set setPW(String? inputPW) => passWord = inputPW;

  String? get getName => name;

  set setName(String? inputName) => name = inputName;

  String? get getPhone => phoneNumber;

  set setPhone(String? inputPhone) => phoneNumber = inputPhone;

  String? get getEmail => email;

  set setEmail(String? inputEmail) => email = inputEmail;

  String? get getSex => sex;

  set setSex(String? inputSex) => sex = inputSex;

  int? get getAge => age;

  set setAge(int? inputAge) => age = inputAge;

  int? get getHairType => hairType;

  set setHairType(int? inputHairType) => hairType = inputHairType;

  // fromJson
  JBMBMemberInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        passWord = json['password'],
        name = json['name'],
        phoneNumber = json['phone'],
        sex = json['sex'] == 1 ? 'male' : 'female',
        age = json['age'],
        hairType = json['hairType'],
        email = json['email'];

  // toJson
  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'password': passWord,
        'name': name,
        'phone': phoneNumber,
        'sex': sex == 'male' ? 1 : 0,
        'age': age,
        'hairType': hairType,
        'email': email
      };

}
