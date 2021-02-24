import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haweyati_client_data_models/models/others/location_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/location_model.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/widgits/locations-map_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/dark-container.dart';
import 'package:haweyati_supplier_driver_app/src/common/map-utils/map-utils.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'locations-map_page.dart';

class LocationPickerWidget extends StatefulWidget {
  final Location location;
  final Function(Location) onChanged;
  LocationPickerWidget({this.onChanged,this.location});

  @override
  _LocationPickerWidgetState createState() => _LocationPickerWidgetState();
}

class _LocationPickerWidgetState extends State<LocationPickerWidget> {
  Location _data;
  Location previouslySavedLocation;
  SharedPreferences prefs;

  initPicker() async {
    // prefs = await SharedPreferences.getInstance();

    // print(AppData.supplier.location.latitude);
    // print(AppData.supplier.location.longitude);
    //
    // previouslySavedLocation = Location(
    //   address: prefs.getString('address'),
    //   latitude: prefs.getDouble('latitude'),
    //   longitude: prefs.getDouble('longitude')
    // );


    if(widget.location!=null){
      LatLng _location = LatLng(widget.location.latitude,widget.location.longitude);
      MapUtils.findAddress(_location).then((value) => setState(() {
        _data = Location(address: MapUtils.formatAddress(value.first), latitude: _location.latitude,longitude: _location.longitude,city: value.first.subAdminArea);
        widget.onChanged(_data);
      }));
    } else {
      LatLng currentCords = await MapUtils.currentLocation;
      MapUtils.findAddress(currentCords).then((value) => setState(() {
        _data = Location(address: MapUtils.formatAddress(value.first), latitude: currentCords.latitude,longitude: currentCords.longitude,city: value.first.subAdminArea);
        widget.onChanged(_data);
      }));
    }
  }

  @override
  void initState() {
    super.initState();
    initPicker();
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context, lang) =>  DarkContainer(child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(children: [
          Expanded(child: CupertinoTextField(
            readOnly: true,
            style: TextStyle(color: Colors.black),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8)
            ),
            controller: TextEditingController(
              text: _data == null ? lang.locationDescription: _data.address
            ),
          )),
          SizedBox(width: 10),
          SizedBox(
            width: 35,
            child: FlatButton(
              shape: CircleBorder(),
              textColor: Colors.white,
              child: Icon(Icons.location_on),
              padding: const EdgeInsets.all(0),
              color: Theme.of(context).accentColor,
              onPressed: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                FocusScope.of(context).requestFocus(FocusNode());
                final location = await CustomNavigator.navigateTo(context,
                    LocationPickerMapPage(widget.location !=null ? LatLng(widget.location.latitude,widget.location.longitude) : null)
                );
                if (location != null) {
                  widget.onChanged(location);
                  setState(() => this._data = location);
                }
              }
            ),
          )
        ]),
      )),
    );
  }
}
