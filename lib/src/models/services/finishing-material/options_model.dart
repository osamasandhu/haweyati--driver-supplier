import 'package:hive/hive.dart';

part 'options_model.g.dart';

@HiveType(typeId: 26)
class FinishingMaterialOption extends HiveObject {
  @HiveField(0) String id;
  @HiveField(1) String name;
  @HiveField(2) List<String> values;

  FinishingMaterialOption({
    this.id,
    this.name,
    this.values,
  });

  factory FinishingMaterialOption.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    var value = json['optionValues'];
    if (value is String) {
      value = value?.split(',');
    }

    return FinishingMaterialOption(
      id: json['_id'],
      name: json['optionName'],
      values: value?.cast<String>()
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': this.id,
    'optionName': this.name,
    'optionValues': this.values
  };
}