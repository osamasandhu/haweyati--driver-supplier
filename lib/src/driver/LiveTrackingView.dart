import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haweyati_client_data_models/models/hypertrack/trip_model.dart';
import 'package:haweyati_client_data_models/utils/toast_utils.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/delivery-vehicle/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/services/hyerptrack_service.dart';
import 'package:haweyati_supplier_driver_app/utils/lazy_task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LiveTrackingView extends StatefulWidget {
  final String shareUrl;
  final String tripId;
  final Order order;
  LiveTrackingView(this.shareUrl,this.tripId,this.order);
  @override
  LiveTrackingViewState createState() => LiveTrackingViewState();
}

class LiveTrackingViewState extends State<LiveTrackingView> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Trip trip = await TripService().getTrip(widget.tripId);
          if(trip.startedAt == null){
            showErrorToast("You have not arrived at the pickup location");
          }
          else {
           await performLazyTask(context,() async {
             if(widget.order.status != OrderStatus.dispatched){
               SharedPreferences _prefs = await SharedPreferences.getInstance();

               await TripService().completeTrip(widget.tripId);
               Trip trip =  await TripService().createTrip(
                   widget.order.id,
                   LatLng( (widget.order.items.first.item as DeliveryVehicleOrderItem).pickUp.latitude,
                       (widget.order.items.first.item as DeliveryVehicleOrderItem).pickUp.longitude),
                   LatLng(widget.order.location.latitude, widget.order.location.longitude),
                   _prefs.getString('deviceId'),
                   false
               );

               await HaweyatiService.patch('orders/trip', {
                 '_id' : widget.order.id,
                 'tripId' : trip.tripId,
                 'shareUrl' : trip.views.shareUrl,
               });
               var res = await HaweyatiService.patch('orders/update-order-status', {
                 '_id' : widget.order.id,
                 'status' : OrderStatus.dispatched.index
               });
             } else {
               await performLazyTask(context, () async {
                 await HaweyatiService.patch("orders/update-order-status", {
                   '_id' : widget.order.id,
                   'status' : OrderStatus.delivered.index
                 });
               });
             }
            });
           Navigator.of(context).pop();
           Navigator.of(context).pop();
          }
        },
        label: Text( widget.order.status == OrderStatus.dispatched ? "Complete Trip" : "I have arrived",style: TextStyle(color: Colors.white),),
      ),
      appBar: AppBar(
        title: Text(widget.order.driver.profile.name),
        actions: [
          IconButton(icon: Image.asset('assets/icons/google-maps.png'), onPressed: () async {
            launch("https://www.google.com/maps?saddr=My+Location&daddr=${widget.order.location.latitude},${widget.order.location.longitude}");
          }),
        ],
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: widget.shareUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
