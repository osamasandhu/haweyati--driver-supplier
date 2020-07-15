class LocationModel{


  double lat;
  double lng;
  LocationModel({this.lat,this.lng});



  LocationModel.fromJson(Map<String, dynamic> json) {

    lat =json['lat'];
    lng =json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> location = new Map<String, dynamic>();
    location['latitude']=this..lat;
    location['longitude']=this.lng;
  }
  }

