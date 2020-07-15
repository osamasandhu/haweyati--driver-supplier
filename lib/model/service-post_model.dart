class ServicePostModel {
  String type;
  String suppliers;
  dynamic data;

  ServicePostModel({this.data, this.suppliers, this.type});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['suppliers'] = this.suppliers;
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
