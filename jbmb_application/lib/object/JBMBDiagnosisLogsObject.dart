
class JBMBDiagnosisLogsObject{
  final int? _resultCode;
  final List<JBMBDiagnosisLog>? _diagnosisList;

  int? get getResultCode => _resultCode;
  List<JBMBDiagnosisLog>? get getDiagnosisList => _diagnosisList;

  JBMBDiagnosisLogsObject(this._resultCode, this._diagnosisList);

  factory JBMBDiagnosisLogsObject.fromJson(Map<String, dynamic> parsedJson){
    var list = parsedJson['diagnosisList'] as List;
    List<JBMBDiagnosisLog> diagnosisLogList = list.map((i) => JBMBDiagnosisLog.fromJson(i)).toList();

    return JBMBDiagnosisLogsObject(parsedJson['resultCode'], diagnosisLogList);
  }
}

class JBMBDiagnosisLog{
  final int _diagnosisID;
  final String _date;

  JBMBDiagnosisLog(this._diagnosisID, this._date);

  int get getDiagnosisID => _diagnosisID;
  String get getDate => _date;

  factory JBMBDiagnosisLog.fromJson(Map<String, dynamic> parsedJson){
    return JBMBDiagnosisLog(parsedJson['diagnosisID'], parsedJson['date']);
  }
}