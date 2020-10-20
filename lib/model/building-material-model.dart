class BuildingMaterialModel {
  String status;
  String sId;
  String name;
  String description;
  List<Pricing> bmPricing;
  Images image;
  int iV;

  BuildingMaterialModel(
      {this.status,
        this.bmPricing,
        this.sId,
        this.name,
        this.description,
        this.iV});

  BuildingMaterialModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    image = Images.fromJson(json['image']);
    if (json['pricing'] != null) {
      bmPricing = new List<Pricing>();
      json['pricing'].forEach((v) {
        bmPricing.add(new Pricing.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.bmPricing != null) {
      data['pricing'] = this.bmPricing.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
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

class Pricing {
  String price;
  String city;


  Pricing(
      {
      this.price,  this.city,
      });

  Pricing.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    price = json['price'].toString();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['price'] = this.price;

    return data;
  }
}
