import 'package:haweyati_supplier_driver_app/src/common/serializer/serializer-type.dart';

class _Serializable {
  final SerializerType type;
  const _Serializable([this.type = SerializerType.json]);
}

const json_serializable = const _Serializable();
const multipart_serializable = const _Serializable(SerializerType.multipart);
