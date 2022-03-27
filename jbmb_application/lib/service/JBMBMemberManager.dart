import 'package:jbmb_application/service/JBMBJwtManager.dart';

import '../object/JBMBMemberInfo.dart';

/// 2022.03.27 이승훈
/// LoginedHome 페이지 이후 페이지에서 관리되는 모든 회원 정보 관리는 해당 매니저를 통해서 이루어짐.
/// [JBMBMemberInfo]와 [JBMBJwtManager]를 통해 관리
class JBMBMemberManager {
  // member variable
  JBMBMemberInfo memberInfo;
  JBMBJwtManager jwtManager;

  // constructor
  JBMBMemberManager(this.memberInfo, this.jwtManager);

  // 헤어 타입을 가지고 있는지 확인
  bool hasHairType() {
    if (memberInfo.getHairType != null) {
      return true;
    } else {
      return false;
    }
  }

  /// 2022.03.27 이승훈
  /// JBMBMemberManager의 [memberInfo]를 최신화하는 메소드
  updateMemberInfo(JBMBMemberInfo jbmbMemberInfo) {

  }
}
