import 'package:hive/hive.dart';
part 'rent_model.g.dart';

@HiveType(typeId: 21)
class Rent extends HiveObject{
  @HiveField(0)
  String id;
  @HiveField(1)
  int days;
  @HiveField(2)
  String city;
  @HiveField(3)
  double rent;
  @HiveField(4)
  double helperPrice;
  @HiveField(5)
  double extraDayRent;

  Rent({
    this.id,
    this.city,
    this.rent,
    this.days,
    this.extraDayRent,
    this.helperPrice
  });

  factory Rent.fromJson(Map<String, dynamic> json) => Rent(
    id: json['_id'],
    city: json['city'],
    days: int.parse(json['days'].toString()),
    extraDayRent: json['extraDayRent'] !=null ? double.parse(json['extraDayRent'].toString()) : null,
    helperPrice: json['helperPrice'] !=null ? double.parse(json['helperPrice'].toString()) : null,
    rent: double.parse(json['rent'].toString()),
  );


  Map<String, dynamic> toJson() => {
    "_id": id,
    "city": city,
    "rent": rent,
    "days": days,
    "extraDayRent": extraDayRent
  };
}
