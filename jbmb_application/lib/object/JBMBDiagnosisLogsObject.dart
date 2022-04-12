
class JBMBDiagnosisLogsObject{
  final int? _resultCode;
  final List<JBMBDiagnosisLog>? _diagnosisList;

  JBMBDiagnosisLogsObject.fromJson(Map<String, dynamic> json):
      _resultCode = json['resultCode'],
      _diagnosisList = json['diagnosisList'];

  int? get getResultCode => _resultCode;
  List<JBMBDiagnosisLog>? get getDiagnosisList => _diagnosisList;

}

class JBMBDiagnosisLog{
  final int _diagnosisID;
  final String _date;

  JBMBDiagnosisLog(this._diagnosisID, this._date);

  JBMBDiagnosisLog.fromJson(Map<String, dynamic> json)
      : _diagnosisID = json['diagnosisID'],
        _date = json['date'];

  int get getDiagnosisID => _diagnosisID;
  String get getDate => _date;
}