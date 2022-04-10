
/// 2022.04.06 이승훈
/// Save Survey 시 API를 요청하기 위해 사용하는 오브젝트
class JBMBSaveSurveyRequestObject {
  // member variable
  int? diagnosisID;
  int? surveyNum;
  int? checked;

  // constructor
  JBMBSaveSurveyRequestObject(this.diagnosisID, this.surveyNum, this.checked);

  // getter & setter
  int? get getDiagnosisID => diagnosisID;
  set setDiagnosisID(int? _diagnosisID) => diagnosisID = _diagnosisID;

  int? get getSurveyNum => surveyNum;
  set setSurveyNum(int? _surveyNum) => surveyNum = _surveyNum;

  int? get getChecked => checked;
  set setChecked(int? _checked) => checked = _checked;

  // toJson
  Map<String, dynamic> toJson() =>
      {
        'diagnosisID': diagnosisID,
        'surveyNum' : surveyNum,
        'checked' : checked
      };
}

/// 2022.04.06 이승훈
/// Save ImageUrl 시 API를 요청하기 위해 사용하는 오브젝트
class JBMBSaveImageUrlRequestObject {
  // member variable
  int? diagnosisID;
  String? imageLink;

  // getter & setter
  int? get getDiagnosisID => diagnosisID;
  set setDiagnosisID(int? _diagnosisID) => diagnosisID = _diagnosisID;

  String? get getImageLink => imageLink;
  set setSurveyNum(String? _imageLink) => imageLink = _imageLink;

  // constructor
  JBMBSaveImageUrlRequestObject(this.diagnosisID, this.imageLink);

  // toJson
  Map<String, dynamic> toJson() =>
      {
        'diagnosisID': diagnosisID,
        'imageLink' : imageLink,
      };

}