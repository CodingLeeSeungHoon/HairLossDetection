
class JBMBShampooRequestObject{
  int callCnt;
  int hairType;

  JBMBShampooRequestObject(this.callCnt, this.hairType);

  // toJson
  Map<String, dynamic> toJson() =>
      {
        'callCnt': callCnt,
        'hairType': hairType
      };
}