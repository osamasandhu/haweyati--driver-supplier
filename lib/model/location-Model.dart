class LocationModel{
  double lat;
  double lng;
  String address;
  LocationModel({this.lat,this.lng,this.address});

  LocationModel.fromJson(Map<String, dynamic> json) {
    lat =json['latitude'];
    lng =json['longitude'];
    address =json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> location = new Map<String, dynamic>();
    location['latitude']=this.lat.toString();
    location['longitude']=this.lng.toString();
    location['address']=this.address;
    return location;
  }
  }

