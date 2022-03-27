class JBMBLogoutResponseObject{
  // member variable
  int? _resultCode;

  // getter & setter
  int? get getResultCode => _resultCode;

  set setResultCode(int? resultCode) => _resultCode = resultCode;

  // fromJson
  JBMBLogoutResponseObject.fromJson(Map<String, dynamic> json)
      : _resultCode = json['resultCode'];
}