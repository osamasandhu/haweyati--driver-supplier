class SigninModel{


  String username;
  String password;

  SigninModel({this.password,this.username});



  SigninModel.fromJson(Map<String, dynamic> json) {
    username =json['username'];
    password =json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> signData = new Map<String, dynamic>();
    signData['username']=this.username;
    signData['password']=this.password
    ;
    return signData;
  }
}