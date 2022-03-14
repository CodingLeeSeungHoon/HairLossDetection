
import 'package:jbmb_application/object/JBMBMemberInfo.dart';

import '../object/JBMBLoginInput.dart';
import '../object/JBMBLoginResult.dart';

/// 2022.03.14 이승훈
/// 로그인 컨트롤러
class JBMBLoginManager{

  /// 로그인 요청하는 메소드
  /// ID, PW 담고 있는 [loginInput]을 파라미터로 받고,
  /// 로그인 결과(JBMBLoginResult)를 리턴한다.
  JBMBLoginResult requestLogin(JBMBLoginInput loginInput){
    JBMBLoginResult jbmbLoginResult = JBMBLoginResult();

    if (checkLoginField(loginInput)){

    }

    return jbmbLoginResult;
  }

  /// Login 페이지의 텍스트 필드 유효성을 확인하는 메소드
  bool checkLoginField(JBMBLoginInput loginInput){
    if (loginInput.getID != null && loginInput.getPW != null){
      return true;
    }
    return false;
  }

  /// requestLogin의 코드가 승인인 경우 호출되는 메소드
  /// [UserID]를 통해 MemberInfo를 DB로부터 받아오는 메소드
  /// LoginedHome에 MemberInfo를 넘겨주기 위해 존재.
  JBMBMemberInfo getMemberInfoByUserID(String UserID){
    JBMBMemberInfo memberInfo = JBMBMemberInfo();
    memberInfo.setID = 'andy8569';
    memberInfo.setPW = 'gg112828273';
    memberInfo.setSex = 'male';
    memberInfo.setAge = 25;
    memberInfo.setEmail = 'free_minkya@naver.com';
    memberInfo.setPhone = '01068538569';
    memberInfo.setName = '이승훈';
    return memberInfo;
  }
}