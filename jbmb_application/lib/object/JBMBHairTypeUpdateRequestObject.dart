
class JBMBHairTypeUpdateRequestObject {
  // member variable
  String? id;
  int? hairType;

  // constructor
  JBMBHairTypeUpdateRequestObject(this.id, this.hairType);

  // toJson
  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'hairType': hairType,
      };

  // Getter & Setter
  String? get getID => id;
  set setID(String? inputID) => id = inputID;

  int? get getHairType => hairType;
  set setHairType(int? inputHairType) => hairType = inputHairType;

}