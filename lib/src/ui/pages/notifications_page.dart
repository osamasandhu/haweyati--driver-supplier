import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/model/models/notifications_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/notifications-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/live-scrollable_view.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final GlobalKey<LiveScrollableViewState> _key = GlobalKey<LiveScrollableViewState>();

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context,lang) => Scaffold(
        appBar: HaweyatiAppBar(),
        body: LiveScrollableView<NotificationModel>(
          key: _key,
          loadingMessage: lang.loadingNotifications,
          loader: ()=> NotificationsService().allNotifications(),
          title: lang.notifications,
          noDataMessage: lang.noNotifications,
          builder: (context,data){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child:  ListTile(
                leading: Icon(CupertinoIcons.news),
                title: Text(data.title),
                subtitle: Text(data.body),
                trailing: Text(DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.parse(data.createdAt))),
              )
            );
          },
        )
      ),
    );
  }
}
