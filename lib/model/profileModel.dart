class ProfileModel {
  String sId;
  String name;
  String email;
  String contact;
  String username;
  String password;

  List<Images> images;


  ProfileModel(
      {
        this.sId,
        this.name,
        this.images,
        this.password,this.username,this.email,this.contact
      });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    password = json['password'];
    username= json['username'];
    email= json['email'];
    contact = json['contact'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String name;
  String path;

  Images({this.name, this.path});

  Images.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['path'] = this.path;
    return data;
  }
}

