import 'package:hive/hive.dart';

@HiveType(typeId: 21)
class Rent extends HiveObject {
  @HiveField(0) String id;

  @HiveField(1) int days;
  @HiveField(2) String city;
  @HiveField(3) double rent;
  @HiveField(4) double helperPrice;
  @HiveField(5) double extraDayRent;

  Rent({
    this.id,
    this.city,
    this.rent = 0,
    this.days = 0,
    this.extraDayRent = 0,
    this.helperPrice = 0
  });

  factory Rent.fromJson(Map<String, dynamic> json) => Rent(
    id: json['_id'],
    city: json['city'],

    days: int.tryParse(json['days']?.toString()) ?? 0,
    rent: double.tryParse(json['rent'].toString()) ?? 0.0,
    helperPrice: double.tryParse(json['helperPrice']?.toString()) ?? 0.0,
    extraDayRent: double.tryParse(json['extraDayRent']?.toString()) ?? 0.0,
  );


  Map<String, dynamic> toJson() => {
    '_id': id,
    'city': city,
    'rent': rent,
    'days': days,
    'helperPrice': helperPrice,
    'extraDayRent': extraDayRent
  };
}
