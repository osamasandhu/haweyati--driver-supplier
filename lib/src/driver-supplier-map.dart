import 'dart:async';
import 'dart:ui' as intl;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:haweyati_supplier_driver_app/src/common/map-utils/map-utils.dart';
import 'package:haweyati_supplier_driver_app/utils/const.dart';
import '../widgits/latlngcov.dart';
import 'google-map-service.dart';

String apiKey = 'AIzaSyDdNpY6LGWgHqRfTRZsKkVhocYOaER325w';

class DriverRouteMapPage extends StatefulWidget {
  final List<LatLng> wayPoints;
  final LatLng destination;
  DriverRouteMapPage({this.wayPoints,this.destination});
  @override
  State<DriverRouteMapPage> createState() => MyLocationMapPageState();
}

class MyLocationMapPageState extends State<DriverRouteMapPage> {
  BitmapDescriptor driver;
  BitmapDescriptor customer;
  BitmapDescriptor store;
  GoogleMapsServices _googleMapServices = GoogleMapsServices();
  String userAddress;
  final Set<Polyline> _polyLines = {};
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController controller;
  LatLng driverLocation;
  LatLng rawLocation;
  List<Marker> allMarkers = [];
  TextEditingController searchAddressField = TextEditingController();
  List<PlacesSearchResult> places = [];
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: apiKey);

  void _initalizeMap([bool animateCamera = false]) async {
    setMarkers();
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() => this.driverLocation = LatLng(
      position.latitude,
      position.longitude
    ));

    if (animateCamera) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: driverLocation, zoom: 15.0)),
      );
    }

    await updateDriverData();
  }

  void setMarkers(){
    BitmapDescriptor
        .fromAssetImage(ImageConfiguration(size: Size(9, 9)), StoreMarkerIcon)
        .then((onValue) {
      store = onValue;
      for(int i=0; i<widget.wayPoints.length; ++i){
        allMarkers.add(Marker(
            markerId: MarkerId('store$i'),
            position: widget.wayPoints[i],
            icon: store
        ));
      }
    });
    BitmapDescriptor
        .fromAssetImage(ImageConfiguration(size: Size(9, 9)), PersonMarkerIcon)
        .then((onValue) {
      customer = onValue;
      allMarkers.add(Marker(
          markerId: MarkerId('customer'),
          position: widget.destination,
          icon: customer
      ));
    } );

    BitmapDescriptor
        .fromAssetImage(ImageConfiguration(size: Size(9, 9)), VehicleMarkerIcon)
        .then((onValue) {driver = onValue;});

  }

  void createRoute() async {
    String route = await _googleMapServices.getRouteCoordinates(driverLocation, widget.wayPoints,widget.destination);
    setState(() {
      _polyLines.clear();
      _polyLines.add(Polyline(
          polylineId: PolylineId('route'),
          width: 3,
          points: convertToLatLng(decodePoly(route)),
          color: Colors.blue
      ));
    });
  }

  void onMapTapped(LatLng cords) async {
    setState(() {
      driverLocation= cords;
      updateDriverData();
    });
  }

  void updateDriverData() async {
    createRoute();
    allMarkers.remove(Marker(markerId: MarkerId('driver')));
    allMarkers.add(Marker(
        markerId: MarkerId('driver'),
        position: driverLocation,
        draggable: true,
        onDragEnd: onMarkerDragEnd,
      icon: driver
    ));
    userAddress = MapUtils.formatAddress((await MapUtils.findAddress(driverLocation)).first);
    setState(() {
      searchAddressField.text = userAddress;
    });
  }

  void onMarkerDragEnd(LatLng position) async {
    driverLocation=position;
    updateDriverData();
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
        components: [Component(Component.country, "sau")]
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
        driverLocation = tempLatLng;
        updateDriverData();
        searchAddressField.text = userAddress;
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: driverLocation, zoom: 16.0),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initalizeMap();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        actions: <Widget>[

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
                      onTap:()=> _initalizeMap(true),
                      child: Icon(Icons.my_location)
                  ),
                ]),
              )
          ),
        ),
      ),

      body: driverLocation != null ? GoogleMap(
        onCameraMove: (CameraPosition position) {
          rawLocation = position.target;
        },
        onTap: onMapTapped,
        zoomControlsEnabled: false,
        compassEnabled: true,
        mapType: MapType.normal,
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        polylines: _polyLines,
        initialCameraPosition: CameraPosition(target: driverLocation, zoom: 15),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          this.controller = controller;
        },
        markers: Set.from(allMarkers),
      ) : Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:8.0),
            child: Text('Getting your current location..'),
          ),
          Text('(Make sure you have your location enabled)',style: TextStyle(color: Colors.grey),)
        ],
      )),
    );
  }


}