import 'package:flutter/material.dart';
import 'package:jbmb_application/object/JBMBMemberInfo.dart';
import 'package:jbmb_application/object/JBMBRegisterResult.dart';

/// 2022.03.03 이승훈
/// 회원가입에 대한 전반적인 로직을 포함한 클래스
class JBMBRegisterManager {

  /// JBMB에 회원가입을 할 수 있는 메소드
  /// Returns the new JBMBRegisterResult
  /// register in JBMB with [registerInput] when you passed validation
  JBMBRegisterResult registerJBMB(JBMBMemberInfo registerInput){
    JBMBRegisterResult jbmbRegisterResult = JBMBRegisterResult();
    bool isInputValid = false;

    switch(validRegisterInput(registerInput)){
      case 0:
        // 유효성 검사 통과
        isInputValid = true;
        break;
      case 1:
        // 필드 중 null 값 존재
        jbmbRegisterResult.setResultCode = 1;
        jbmbRegisterResult.setResult = "  빈 칸이 존재하거나, 유효하지 않은 입력입니다.";
        break;
      case 2:
        // ID/PW 유효성 불통
        jbmbRegisterResult.setResultCode = 2;
        jbmbRegisterResult.setResult = "  ID/PW를 4자리 이상 입력해주세요.";
        break;
      case 3:
        // 핸드폰 번호 유효성 불통
        jbmbRegisterResult.setResultCode = 3;
        jbmbRegisterResult.setResult = "  유효하지 않은 핸드폰 번호입니다.";
        break;
      case 4:
        // 이메일 정규표현식 유효성 불통
        jbmbRegisterResult.setResultCode = 4;
        jbmbRegisterResult.setResult = "  유효하지 않은 이메일 형식입니다.";
        break;
    }

    if (isInputValid){
      // TODO : api 찌를 것
      jbmbRegisterResult.setResultCode = 0;
      jbmbRegisterResult.setResult = "  회원가입이 완료되었습니다.";
    }

    return jbmbRegisterResult;
  }

  /// [registerInput]내의 값을 통해 회원가입에 적합한지 유효성 검사하는 메소드
  /// Returns registerCode
  /// 0 : 유효성 검사 통과
  /// 1 : 필드 중 null 값이 존재
  /// 2 : ID / PW 4자리 이상 입력
  /// 3 : 핸드폰 번호 11자리, 앞 010 유지 확인
  /// 4 : 이메일 양식 맞는지 확인
  int validRegisterInput(JBMBMemberInfo registerInput){
    String? inputID = registerInput.getID;
    String? inputPW = registerInput.getPW;
    String? inputPhone = registerInput.getPhone;
    String? inputEmail = registerInput.getEmail;
    String? inputSex = registerInput.getSex;
    String? inputName = registerInput.getName;
    int? inputAge = registerInput.getAge;
    bool isNull = false;

    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    List<String?> inputValues = [inputID, inputPW, inputPhone, inputEmail, inputSex, inputName];
    for (var element in inputValues) {
      if (element == null || inputAge == null){
        isNull = true;
        break;
      }
    }
    
    // Null check for all elements
    if (isNull){
      return 1;
    }
    // inputID와 inputPW 4자리 이상 입력 권장
    else if (inputID!.length < 4 && inputPW!.length < 4){
      return 2;
    }
    // 핸드폰 번호 유효성 체크
    else if (inputPhone!.length != 11 || inputPhone.substring(0, 3) != "010"){
      return 3;
    }
    // 이메일 양식 확인
    else if (!regExp.hasMatch(inputEmail!)){
      return 4;
    }
    // 모든 유효성 검사 통과
    return 0;
  }


}