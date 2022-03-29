import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// 2022.03.28 이승훈
/// JWT Token에 대한 관리를 할 수 있는 클래스
class JBMBJwtManager {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final String jwt = 'jwt';

  /// [jwtToken]을 파라미터로 받아 storage에 저장하는 메소드
  saveToken(String jwtToken) async {
    storage.write(key: jwt, value: jwtToken);
  }

  /// [jwtToken]을 리턴 받을 수 있는 메소드.
  getToken() async {
    return storage.read(key: jwt);
  }
}
