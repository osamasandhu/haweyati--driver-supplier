import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haweyati_client_data_models/models/hypertrack/trip_model.dart';
import 'package:haweyati_client_data_models/services/hyerptrack_service.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/delivery-vehicle/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/orders/order-mutual-detail.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/flat-action-button.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/message-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/scroll_view.dart';
import 'package:haweyati_supplier_driver_app/widgits/confirmation-dialog.dart';
import 'package:haweyati_supplier_driver_app/widgits/mark-order-complete.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../driver-supplier-map.dart';
import '../LiveTrackingView.dart';


class DriverOrderDetailPage extends StatelessWidget {
  final Order order;
  DriverOrderDetailPage(this.order);

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context,lang) =>
       ScrollableView.sliver(
         fab: (order.shareUrl != null && order.type == OrderType.deliveryVehicle && order.status != OrderStatus.delivered) ? FloatingActionButton.extended(
           label: Text("View Journey",style: TextStyle(color: Colors.white),),
           onPressed: ()  {
             CustomNavigator.navigateTo(context,
                 LiveTrackingView(order.shareUrl,order.tripId,order));
           },
         ) :
         FloatingActionButton(
          child: Icon(Icons.map,color: Colors.white,),
          onPressed: (){
            //For testing
            // List<LatLng> wayPoints = [
            //   // BZ Universityersity
            //   LatLng(30.276798, 71.512020),
            //   //Chowk Kumhara
            //   LatLng(30.210255, 71.515635),
            //   //Women University
            //   LatLng(30.204883, 71.461753),
            //   //BZ University
            //   LatLng(30.276798, 71.512020),
            // ];
            //
            // //Cant
            // LatLng destination = LatLng(30.165381, 71.386373);

            List<LatLng> wayPoints = [];
            if(order.supplier!=null)  wayPoints.add(LatLng(order.supplier.location.latitude, order.supplier.location.longitude));
            // wayPoints.add(LatLng(order.location.latitude, order.location.longitude));

            CustomNavigator.navigateTo(context, DriverRouteMapPage(
              wayPoints: wayPoints,
              destination: LatLng(order.location.latitude,order.location.longitude),
            ));
          },
        )
           ,bottom: DriverOrderActionButton(order: order,),
          showBackground: true,
           padding: const EdgeInsets.fromLTRB(15, 0, 15, 70),
          appBar: HaweyatiAppBar(actions: [],),
          children: orderViewBuilder(order, lang),
      ),
    );
  }
}


class DriverOrderActionButton extends StatefulWidget {
  final Order order;
  DriverOrderActionButton({this.order});
  @override
  _DriverOrderActionButtonState createState() => _DriverOrderActionButtonState();
}

class _DriverOrderActionButtonState extends State<DriverOrderActionButton> {
  static Order order;
  bool completed = false;
  bool accepted = false;

  static Widget generateActionBtn(BuildContext context){
    switch(order.status){
      case OrderStatus.pending:
        return acceptOrder(context);
        break;
      case OrderStatus.accepted:
        return acceptOrder(context);
        break;
      case OrderStatus.dispatched:
       return completeOrder(context);
        break;
      case OrderStatus.preparing:
        if(order.type == OrderType.deliveryVehicle)
         return dispatchDeliveryVehicleOrder(context);
        else
          return SizedBox();
        break;
      default:
        return SizedBox();
        break;
    }
  }


  @override
  void initState() {
    super.initState();
    order = widget.order;
  }

  static Widget acceptOrder(BuildContext context) => FlatActionButton(
    label: "Accept Order",
    icon: Icon(CupertinoIcons.checkmark_circle),
    onPressed: () async {
      bool confirm =  await showDialog(context: context,
          builder: (context){
            return ConfirmationDialog(title: Text('Are you sure you want to accept this order?'),
            );
          });
      if(confirm!=null && confirm){
        openLoadingDialog(context, "Accepting order");
        var res;
        try {
          res = await HaweyatiService.patch('orders/add-driver', {
            'driver' : AppData.driver.serialize(),
            '_id' : order.id,
            'flag' : true
          });

          if(order.type == OrderType.deliveryVehicle){
            SharedPreferences _prefs = await SharedPreferences.getInstance();

            Trip trip =  await TripService().createTrip(
                order.id,
                LatLng( (order.items.first.item as DeliveryVehicleOrderItem).pickUp.latitude,
                    (order.items.first.item as DeliveryVehicleOrderItem).pickUp.longitude),
                LatLng(order.location.latitude, order.location.longitude),
                _prefs.getString('deviceId')
            );

            await HaweyatiService.patch('orders/trip', {
              '_id' : order.id,
              'tripId' : trip.tripId,
              'shareUrl' : trip.views.shareUrl,
            });
          }

        } catch (e){
          print(e);
          openMessageDialog(context, e.message);
         return;
        }

        Navigator.pop(context);
        Navigator.pop(context);
      }
    },
  );

  static Widget completeOrder(BuildContext context) => FlatActionButton(
    label: "Complete Order",
    icon: Icon(CupertinoIcons.checkmark_circle),
    onPressed: () {
      CustomNavigator.navigateTo(context, MarkOrderCompleted(orderId: order.id,));
    },
  );


  static Widget dispatchDeliveryVehicleOrder(BuildContext context) => FlatActionButton(
    label: "Dispatch Order",
    icon: Icon(CupertinoIcons.checkmark_circle),
    onPressed: () async {
        openLoadingDialog(context, "Dispatching order");
        var res = await HaweyatiService.patch('orders/update-order-status', {
          '_id' : order.id,
          'status' : OrderStatus.dispatched.index
        });
        Navigator.pop(context);
        Navigator.pop(context);
    },
  );

  @override
  Widget build(BuildContext context) {
    return generateActionBtn(context);
  }
}
