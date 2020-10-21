import 'package:hive/hive.dart';

class CreditCardModel extends HiveObject {
  String number;
  String ownerName;
  String securityCode;

  DateTime expiresAt;

  CreditCardModel({
    this.number,
    this.ownerName,
    this.securityCode,
    this.expiresAt
  });
}
