class AvailableServices {
  AvailableServices({this.services});

  List<String> services;
  AvailableServices.fromJson(Map<String, dynamic> json) {
    services = json['services'].cast<String>();
  }
}