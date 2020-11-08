import 'package:haweyati_supplier_driver_app/model/models/notifications_model.dart';
import 'haweyati-service.dart';

class NotificationsService extends HaweyatiService<NotificationModel> {
  @override
  NotificationModel parse(Map<String, dynamic> item) => NotificationModel.fromJson(item);

  Future<List<NotificationModel>> allNotifications() async {
    return this.getAll('fcm/get-history');
  }

}