class FcmModel{
  String person;
  String token;
  FcmModel({this.token,this.person});

  FcmModel.fromJson(Map<String, dynamic> json) {
    token =json['token'];
    person =json['person'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> fcmData = new Map<String, dynamic>();
    fcmData['token']=this.token;
    fcmData['person']=this.person
    ;
return fcmData;
 }
}