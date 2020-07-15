import 'dart:async';
import 'dart:ui' as intl;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:haweyati_supplier_driver_app/model/order-location_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

String apiKey = 'AIzaSyDdNpY6LGWgHqRfTRZsKkVhocYOaER325w';

class MyLocationMapPage extends StatefulWidget {
  final bool editMode;
  MyLocationMapPage({this.editMode=false});
  @override
  State<MyLocationMapPage> createState() => MyLocationMapPageState();
}

class MyLocationMapPageState extends State<MyLocationMapPage> {
  String city;
  String userAddress;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController controller;
  LatLng currentLocation;
  LatLng rawLocation;
  List<Marker> allMarkers = [];
  TextEditingController searchAddressField = TextEditingController();
  List<PlacesSearchResult> places = [];
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: apiKey);
  SharedPreferences prefs;

  _getCurrentUserLocation([bool fromBtn=false]) async {

    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
      if(fromBtn){
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
              CameraPosition(target: currentLocation, zoom: 15.0)
          ),
        );
      }
    });
    updateAddress();
    allMarkers.clear();
    allMarkers.add(Marker(
        markerId: MarkerId('0'),
        position: currentLocation,
        draggable: true,
        onDragEnd: onMarkerDragEnd
    ));
  }

  Future updateAddress([LatLng address]) async {
    userAddress = await findAddress(address ?? currentLocation);
    setState(() {
      searchAddressField.text = userAddress;
    });
  }

  void onMapTapped(LatLng cords) async {
    setState(() {
      currentLocation= cords;
      allMarkers.clear();
      allMarkers.add(Marker(
        markerId: MarkerId('0'),
        position: currentLocation,
        draggable: true,
        onDragEnd: onMarkerDragEnd,
      ));
      updateAddress();
    });
  }

  void onMarkerDragEnd(LatLng position) async {
    currentLocation=position;
    await updateAddress(position);
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
          CameraPosition(target: position, zoom: 15.0)
      ),
    );
  }


  _getPlacesPredictions() async {
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: apiKey,
    );
    displayPrediction(p);
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;
      for (var i = 0; i < p.terms.length; ++i) {
        print('displayPrediction terms[$i]: ${p.terms[i].value}');
      }
      print('displayPrediction matchedSubstrings: ${p.matchedSubstrings}');
      LatLng tempLatLng = new LatLng(lat, lng);

      setState(()  {
        currentLocation = tempLatLng;
        updateAddress();
        allMarkers.clear();
        allMarkers.add(Marker(
          markerId: MarkerId('0'),
          position: currentLocation,
          draggable: true,
          onDragEnd: onMarkerDragEnd,
        ));
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: currentLocation, zoom: 16.0),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
    if(widget.editMode)
      _editPreviousLocation();
    else
      _getCurrentUserLocation();
  }

  loadData() async {
    prefs = await SharedPreferences.getInstance();
  }

  _editPreviousLocation() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
     currentLocation = LatLng(prefs.getDouble('latitude'),prefs.getDouble('longitude'));
     updateAddress();
    });
    allMarkers.clear();
    allMarkers.add(Marker(
        markerId: MarkerId('0'),
        position: currentLocation,
        draggable: true,
        onDragEnd: onMarkerDragEnd
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          actions: <Widget>[
//            Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 15),
//              child: Center(
//                child: LocalizationSelector(
//                  selected: EasyLocalization.of(context).locale,
//                  onChanged: (locale) {
//                    setState(() => EasyLocalization.of(context).locale = locale);
//                  },
//                ),
//              ),
//            )
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                constraints: BoxConstraints.expand(height: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(children: <Widget>[
                  Icon(Icons.location_on),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: _getPlacesPredictions,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Center(child: Text(
                            searchAddressField.text.isEmpty ?
                            'Enter Your Location' : searchAddressField.text
                          ))
                        ],
                      ),
                    ),
                  )),
                  GestureDetector(
                    onTap:()=> _getCurrentUserLocation(true),
                    child: Icon(Icons.my_location)
                  ),
                ]),
              )
//              CupertinoTextField(
//                placeholder: "Enter Your Location",
//                prefix: Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 8),
//                  child: Icon(Icons.location_on, color: Theme.of(context).accentColor),
//                ),
//                suffix: Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 8),
//                  child: IconButton(
//                      icon: Icon(Icons.my_location),
//                    onPressed: (){
//                        print('called');
//                    },
//                  ),
//                ),
//                clearButtonMode: OverlayVisibilityMode.always,
//                padding: EdgeInsets.symmetric(vertical: 9),
//                decoration: BoxDecoration(
//                  color: Colors.white,
//                  borderRadius: BorderRadius.circular(30)
//                ),
//                controller: searchAddressField,
//              ),
            ),
          ),
        ),
        
        body: currentLocation!=null ? GoogleMap(
          onCameraMove: (CameraPosition position) {
            rawLocation = position.target;
          },
          onTap: onMapTapped,
          zoomControlsEnabled: false,
          compassEnabled: true,
          mapType: MapType.normal,
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(target: currentLocation, zoom: 15),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            this.controller = controller;
          },
          markers: Set.from(allMarkers),
        )
            : Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0),
              child: Text('Getting your current location..'),
            ),
            Text('(Make sure you have your location enabled)',style: TextStyle(color: Colors.grey),)
          ],
        ),
      ),
      bottomNavigationBar: userAddress!=null ?  Material(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            height: 45,
            child: FlatButton.icon(
              shape: StadiumBorder(),
              textColor: Colors.white,
              icon: Icon(Icons.location_on),
              color: Theme.of(context).accentColor,
              label: Text('Set_Your_Location'),
              onPressed: () async {

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      content: Row(children: <Widget>[
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2)
                        ),
                        SizedBox(width: 20),
                        Text('Saving your coordinates ...')
                      ]),
                    );
                  }
                );

                prefs.setDouble("latitude", currentLocation.latitude);
                prefs.setDouble("longitude", currentLocation.longitude);
                prefs.setString("address", userAddress);
                prefs.setString('city', city);



                if(widget.editMode){
                  print('working');
                  Navigator.pop(context);
                  Navigator.of(context).pop(UserLocation(
                    address: userAddress,
                    city: city,
                    cords: LatLng(currentLocation.latitude,
                       currentLocation.longitude)
                  ));
                  return;
                }

                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
              },
            ),
          ),
        ),
      ) : SizedBox(),
    );
  }

  Future<String> findAddress(LatLng cords) async{

    var addresses = await Geocoder.local.findAddressesFromCoordinates(Coordinates(cords.latitude,cords.longitude));
    city = addresses.first.subAdminArea;
    String formattedAddress = "";
    if (addresses.first.addressLine.contains(",")) {
      List<String> descriptionSplit = addresses.first.addressLine.split(",");
      for (var i = 0; i < descriptionSplit.length - 1; ++i) {
        if (i == descriptionSplit.length - 2) {
          formattedAddress += descriptionSplit[i];
        } else {
          formattedAddress += descriptionSplit[i] + ", ";
        }
      }
    } else {
      formattedAddress = addresses.first.addressLine;
    }
    return formattedAddress;
  }

}