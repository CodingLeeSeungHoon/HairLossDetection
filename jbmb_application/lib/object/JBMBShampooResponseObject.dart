
/// 2022.04.18 이승훈
/// searchShampoo API response object
/// 샴푸 목록을 리턴 받는 API response 객체
class JBMBShampooResponseObject {
  // member variable
  final List<JBMBShampooItems>? _shampooItemsList;

  // constructor
  JBMBShampooResponseObject(this._shampooItemsList);

  // getter
  List<JBMBShampooItems>? get getShampooItemsList => _shampooItemsList;

  // factory func : fromJson
  factory JBMBShampooResponseObject.fromJson(Map<String, dynamic> parsedJson){
    var list = parsedJson['items'] as List;
    List<JBMBShampooItems> shampooList = list.map((i) => JBMBShampooItems.fromJson(i)).toList();

    return JBMBShampooResponseObject(shampooList);
  }
}

/// 2022.04.18 이승훈
/// Shampoo object
/// 샴푸 내부 정보를 담고 있는 객체
class JBMBShampooItems {
  // member variable
  final String? _shampooName;
  final String? _purchaseLink;
  final String? _imgLink;
  final int? _lprice;
  final String? _brand;

  // constructor
  JBMBShampooItems(this._shampooName, this._purchaseLink, this._imgLink, this._lprice, this._brand);

  // Getter
  String? get getShampooName => _shampooName;

  String? get getPurchaseLink => _purchaseLink;

  String? get getImgLink => _imgLink;

  int? get getLPrice => _lprice;

  String? get getBrand => _brand;

  // factory func : fromJson
  factory JBMBShampooItems.fromJson(Map<String, dynamic> parsedJson){
    return JBMBShampooItems(
        parsedJson['title'], parsedJson['link'], parsedJson['image'],
        parsedJson['lprice'], parsedJson['brand']);
  }

}