import 'package:flutter/cupertino.dart';

/// 2022.03.08 이승훈
/// JBMBMemberInfo
/// 회원가입 각 필드 값 모두 저장하는 객체, API RequestBody로 JSON Parsing을 거쳐 사용될 예정
class JBMBMemberInfo {
  String? id;
  String? passWord;
  String? name;
  String? phoneNumber;
  String? email;
  int? age;
  String? sex;
  int? hairType;

  /// empty constructor
  JBMBMemberInfo();

  /// getter, setter
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

  /// fromJson
  JBMBMemberInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        passWord = json['passWord'],
        name = json['name'],
        phoneNumber = json['phoneNumber'],
        sex = json['sex'],
        age = json['age'],
        hairType = json['hairType'];

  /// toJson
  Map<String, dynamic> toJson() => {
    'id' : id,
    'passWord' : passWord,
    'name' : name,
    'phoneNumber' : phoneNumber,
    'sex' : sex,
    'age' : age,
    'hairType' : hairType
  };

}
