
class JBMBCommunityRequestObject{
  int callCnt;

  JBMBCommunityRequestObject(this.callCnt);

  // toJson
  Map<String, dynamic> toJson() =>
      {
        'callCnt': callCnt
      };
}

class JBMBPostDetailRequestObject{
  int postID;

  JBMBPostDetailRequestObject(this.postID);

  // toJson
  Map<String, dynamic> toJson() =>
      {
        'postID': postID
      };
}