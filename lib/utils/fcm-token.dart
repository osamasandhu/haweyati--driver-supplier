import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';

class FCMService {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Future<String> getToken() async {
    return await firebaseMessaging.getToken();
  }

  Future subscribeToNotifications() async {
   await firebaseMessaging.subscribeToTopic('news');
  }

  Future updateProfileFcmToken() async {
    return await HaweyatiService.patch('persons/update-token', {
      '_id': AppData.isDriver ? AppData.driver.profile.id : AppData.supplier.person.id,
      'token': await getToken(),
    });
  }
}
