import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:haweyati_supplier_driver_app/widgits/notification-dialog.dart';

class NotificationService {
 static FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  static List<String> transformNotificationMessage(Map<String, dynamic> message){
    if (Platform.isAndroid) {
      return [message['notification']['title'],message['notification']['body']];
    } else if (Platform.isIOS) {
      print(message['aps']['alert']['title']);
      return [message['aps']['alert']['title'], message['aps']['alert']['body']];
    }
  }


 static  iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
  }

}