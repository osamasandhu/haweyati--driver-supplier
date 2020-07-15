class ScaffoldingModel {
  List<Suppliers> suppliers;
  String sId;
  String description;
  String type;
  List<Pricing> pricing;
  int iV;

  ScaffoldingModel(
      {this.suppliers,
        this.sId,
        this.description,
        this.type,
        this.pricing,
        this.iV});

  ScaffoldingModel.fromJson(Map<String, dynamic> json) {
    if (json['suppliers'] != null) {
      suppliers = new List<Suppliers>();
      json['suppliers'].forEach((v) {
        suppliers.add(new Suppliers.fromJson(v));
      });
    }
    sId = json['_id'];
    description = json['description'];
    type = json['type'];
    if (json['pricing'] != null) {
      pricing = new List<Pricing>();
      json['pricing'].forEach((v) {
        pricing.add(new Pricing.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.suppliers != null) {
      data['suppliers'] = this.suppliers.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['description'] = this.description;
    data['type'] = this.type;
    if (this.pricing != null) {
      data['pricing'] = this.pricing.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Suppliers {
  List<String> services;
  String status;
  String sId;
  String name;
  String email;
  String contact;
  String city;
  String password;
  String address;
  List<Images> images;
  String username;
  int iV;

  Suppliers(
      {this.services,
        this.status,
        this.sId,
        this.name,
        this.email,
        this.contact,
        this.city,
        this.password,
        this.address,
        this.images,
        this.username,
        this.iV});

  Suppliers.fromJson(Map<String, dynamic> json) {
    services = json['services'].cast<String>();
    status = json['status'];
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    contact = json['contact'];
    city = json['city'];
    password = json['password'];
    address = json['address'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    username = json['username'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['services'] = this.services;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['city'] = this.city;
    data['password'] = this.password;
    data['address'] = this.address;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['username'] = this.username;
    data['__v'] = this.iV;
    return data;
  }
}

class Images {
  String sId;
  String name;
  String path;

  Images({this.sId, this.name, this.path});

  Images.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['path'] = this.path;
    return data;
  }
}

class Pricing {
  String sId;
  String city;
  int rent;
  int days;
  int extraDayRent;

  Pricing({this.sId, this.city, this.rent, this.days, this.extraDayRent});

  Pricing.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    city = json['city'];
    rent = json['rent'];
    days = json['days'];
    extraDayRent = json['extraDayRent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['city'] = this.city;
    data['rent'] = this.rent;
    data['days'] = this.days;
    data['extraDayRent'] = this.extraDayRent;
    return data;
  }
}