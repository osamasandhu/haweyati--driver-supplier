class DriverModel {
  Vehicle vehicle;
  String status;
  String sId;
  Profile profile;
  String license;
  Location location;
  String city;
  int iV;
  String profileId;

  DriverModel(
      {this.vehicle,
        this.profileId,
        this.status,
        this.sId,
        this.profile,
        this.license,
        this.location,
        this.city,
        this.iV});

  DriverModel.fromJson(Map<String, dynamic> json) {
    vehicle =
    json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
    status = json['status'];
    sId = json['_id'];
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    license = json['license'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    city = json['city'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle.toJson();
    }
    data['status'] = this.status;
    data['_id'] = this.sId;
//    if (this.profile != null) {
//      data['profile'] = this.profile.toJson();
//    }
    data['license'] = this.license;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['city'] = this.city;
    data['profile'] = this.profileId;
//    data['__v'] = this.iV;
    return data;
  }
}

class Vehicle {
  String name;
  String model;
  String identificationNo;

  Vehicle({this.name, this.model, this.identificationNo});

  Vehicle.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    model = json['model'];
    identificationNo = json['identificationNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['model'] = this.model;
    data['identificationNo'] = this.identificationNo;
    return data;
  }
}

class Profile {
  String sId;
  String name;
  String type;
  String email;
  String contact;
  String username;
  String password;
  Image image;
  int iV;

  Profile(
      {this.sId,
        this.name,
        this.type,
        this.email,
        this.contact,
        this.username,
        this.password,
        this.image,
        this.iV});

  Profile.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    email = json['email'];
    contact = json['contact'];
    username = json['username'];
    password = json['password'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['username'] = this.username;
    data['password'] = this.password;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Image {
  String name;
  String path;

  Image({this.name, this.path});

  Image.fromJson(Map<String, dynamic> json) {
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

class Location {
  String latitude;
  String longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}