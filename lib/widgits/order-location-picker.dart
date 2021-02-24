import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haweyati_client_data_models/models/others/location_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order-location_model.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/dark-container.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/edit-button.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/locations-map_page.dart';
import 'package:haweyati_supplier_driver_app/utils/const.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'emptyContainer.dart';
import 'locations-map_page.dart';

class OrderLocationPicker extends StatefulWidget {
  final OrderLocation previousLocation;
  final Function(OrderLocation) onLocationChanged;
  OrderLocationPicker({this.onLocationChanged,this.previousLocation});

  @override
  _OrderLocationPickerState createState() => _OrderLocationPickerState();
}

class _OrderLocationPickerState extends State<OrderLocationPicker> {

  SharedPreferences prefs;
  OrderLocation dropOffLocation;

  @override
  void initState() {
    super.initState();
    if(widget.previousLocation!=null){
      dropOffLocation = widget.previousLocation;
    }else {
      initTimeAndLocation();
    }
  }

  void initTimeAndLocation() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      dropOffLocation = OrderLocation(
          latitude: prefs.getDouble('latitude'),
          longitude: prefs.getDouble('longitude'),
          // address: prefs.getString('address'),
          // city: prefs.getString('city')
      );
      widget.onLocationChanged(dropOffLocation);
    });
  }

  @override
  Widget build(BuildContext context) {
    return EmptyContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Drop off Location",
                // style: boldText,
              ),
              FlatButton.icon(
                  onPressed: () async {
                    final location = await CustomNavigator
                        .navigateTo(context, LocationPickerPage());

                    if (location != null) {
                      dropOffLocation = location;
                      widget.onLocationChanged(location);
                      setState(() => this.dropOffLocation = location);
                    }
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).accentColor,
                  ),
                  label: Text(
                    "Edit",
                    style:
                    TextStyle(color: Theme.of(context).accentColor),
                  ))
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.location_on,
                color: Theme.of(context).accentColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(dropOffLocation?.address ?? ''),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}


class DropOffLocation extends StatelessWidget {
  final OrderLocation location;
  DropOffLocation(this.location);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LocationPicker(onChanged: null,initialValue: location,edit: false,),
      if(location.dropOffTime != null)  DarkContainer(
        child: Column(
            children: [
              Row(children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 11),
                    child: _Title('Drop-off Date'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17),
                    child: _Title('Drop-off Time'),
                  ),
                ),
              ]),
              Row(children: [
                Expanded(
                  child: DarkContainer(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      child: Row(children: [
                        Expanded(
                          child: Text(
                            DateFormat(DateFormat.YEAR_MONTH_DAY).format(location.dropOffDate),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        Image.asset(CalendarIcon, width: 25),
                      ]),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: DarkContainer(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      child: Row(children: [
                        Expanded(
                          child: Text(
                            location.dropOffTime.from.format(context) + '  -  ' + location.dropOffTime.to.format(context),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        Image.asset(ClockIcon, width: 25),
                      ]),
                    ),
                  ),
                ),
              ]),
            ],
          ),
      )

      ],
    );
  }
}

class _Title extends Text {
  _Title(String title)
      : super(
    title,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 13,
    ),
  );
}

class LocationPicker extends StatefulWidget {
  final Location initialValue;
  final Function(Location location) onChanged;
  final bool edit;
  final String title;
  LocationPicker({
    this.title = 'Drop Off Location',
    this.initialValue,
    @required this.onChanged,this.edit=true
  });

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  var _address;

  @override
  void initState() {
    super.initState();
    _address = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DarkContainer(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 15),
      child: Wrap(children: [
        Row(children: [
          Text(widget.title, style: TextStyle(
              color: Color(0xFF313F53),
              fontWeight: FontWeight.bold
          )),
          Spacer(),
         widget.edit ? EditButton(onPressed: () async {
            final location = await CustomNavigator.navigateTo(context, LocationPickerMapPage(
                LatLng(widget.initialValue.latitude, widget.initialValue.longitude)
            ));
            if (location != null) {
              _address = location;
              widget.onChanged(_address);

              setState(() {});
            }
          }) : SizedBox()
        ]),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Image.asset(LocationIcon, height: 18),
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(_address.address, style: TextStyle(
                height: 1.2,
                color: Color(0xFF313F53),
              )),
            ))
          ], crossAxisAlignment: CrossAxisAlignment.start),
        )
      ]),
    );
  }
}

