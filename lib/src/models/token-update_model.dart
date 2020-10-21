import 'package:haweyati_supplier_driver_app/model/json_serializable.dart';

class TokenUpdate extends JsonSerializable {
  String id;
  String token;

  TokenUpdate(String id, String token):
    assert(id != null), assert(token != null);

  @override
  Map<String, dynamic> serialize() => {
    '_id': id, 'token': token
  };
}