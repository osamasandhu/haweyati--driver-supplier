import 'package:haweyati_supplier_driver_app/model/serializable.dart';

abstract class JsonSerializable extends Serializable<Map<String, dynamic>> {
  @override Map<String, dynamic> serialize();
}
