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
