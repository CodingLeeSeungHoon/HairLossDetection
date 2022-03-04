
import 'package:jbmb_application/object/JBMBRegister.dart';
import 'package:jbmb_application/object/JBMBRegisterResult.dart';

/// 2022.03.03 이승훈
/// 회원가입에 대한 전반적인 로직을 포함한 클래스
class JBMBRegisterManager {

  /// JBMB에 회원가입을 할 수 있는 메소드
  /// Returns the new JBMBRegisterResult
  /// register in JBMB with [registerInput] when you passed validation
  JBMBRegisterResult registerJBMB(JBMBRegister registerInput){
    JBMBRegisterResult jbmbRegisterResult = JBMBRegisterResult();

    switch(validRegisterInput(registerInput)){
      case 0:
        // 유효성 검사 통과
        break;
      case 1:
        //
        break;
    }

    // api 찌를 것

    return JBMBRegisterResult();
  }

  /// [registerInput]내의 값을 통해 회원가입에 적합한지 유효성 검사하는 메소드
  /// Returns registerCode
  /// 0 : 유효성 검사 통과
  /// 1 :
  int validRegisterInput(JBMBRegister registerInput){
    return 0;
  }
}