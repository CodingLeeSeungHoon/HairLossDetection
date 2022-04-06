import 'package:jbmb_application/object/JBMBDefaultResponseObject.dart';

class JBMBServeyRequestObject {
  // member variable
  int? _surveyNum;

  // TODO : refactoring variable
  int? _checked;

  // getter & setter
  int? get getSurveyNum => _surveyNum;

  set setSurveyNum(int? surveyNum) => _surveyNum = surveyNum;

  int? get getChecked => _checked;

  set setChecked(int? checked) => _checked = checked;

  // toJson
  Map<String, dynamic> toJson() =>
      {
        'surveyNum': _surveyNum,
        'checked': _checked,
      };
}