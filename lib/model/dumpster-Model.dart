class DumspterModel {
  List<String> suppliers;
  String status;
  String sId;
  String size;
  String description;
  List<Pricing> pricing;
  List<Images> images;
  int iV;

  DumspterModel(
      {this.suppliers,
        this.status,
        this.sId,
        this.size,
        this.description,
        this.pricing,
        this.images,
        this.iV});

  DumspterModel.fromJson(Map<String, dynamic> json) {
    suppliers = json['suppliers'].cast<String>();
    status = json['status'];
    sId = json['_id'];
    size = json['size'];
    description = json['description'];
    if (json['pricing'] != null) {
      pricing = new List<Pricing>();
      json['pricing'].forEach((v) {
        pricing.add(new Pricing.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['suppliers'] = this.suppliers;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['size'] = this.size;
    data['description'] = this.description;
    if (this.pricing != null) {
      data['pricing'] = this.pricing.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}
class Pricing {
  String sId;
  String city;
  int rent;
  int days;
  int extraDayRent;
  int helperPrice;

  Pricing(
      {this.sId,
        this.city,
        this.rent,
        this.days,
        this.extraDayRent,
        this.helperPrice});

  Pricing.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    city = json['city'];
    rent = json['rent'];
    days = json['days'];
    extraDayRent = json['extraDayRent'];
    helperPrice = json['helperPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['city'] = this.city;
    data['rent'] = this.rent;
    data['days'] = this.days;
    data['extraDayRent'] = this.extraDayRent;
    data['helperPrice'] = this.helperPrice;
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
