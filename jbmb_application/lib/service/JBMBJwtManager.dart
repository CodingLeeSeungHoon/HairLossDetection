import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JBMBJwtManager {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final String jwt = 'jwt';

  saveToken(String jwtToken) async {
    storage.write(key: jwt, value: jwtToken);
  }

  getToken() async {
    return storage.read(key: jwt);
  }
}
