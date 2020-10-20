import 'package:hive/hive.dart';
part 'notifications_model.g.dart';

@HiveType(typeId: 22)
class NotificationModel extends HiveObject{
  @HiveField(0)
  String title;
  @HiveField(1)
  String body;
  @HiveField(2)
  String createdAt;

  NotificationModel({this.title,this.body});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['message']['title'];
    body = json['message']['body'];
    createdAt = json['createdAt'];
  }

}