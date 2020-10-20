class ImageData {
  String id;
  String name;

  ImageData({
    this.id,
    this.name
  });

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
    id: json['_id'],
    name: json['name']
  );

  Map<String, dynamic> toJson() => {
    '_id': this.id,
    'name': this.name
  };
}