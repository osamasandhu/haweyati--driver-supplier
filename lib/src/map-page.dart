//import 'dart:async';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_google_places/flutter_google_places.dart';
//import 'package:geocoder/geocoder.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:google_maps_webservice/places.dart';
//import 'package:geolocator/geolocator.dart';
//
//import '../google-maps-service.dart';
//import '../latlngcov.dart';
//
//class MapPage extends StatefulWidget {
//  @override
//  State<MapPage> createState() => MapPageState();
//}
//
//class MapPageState extends State<MapPage> {
//  BitmapDescriptor startPin;
//  BitmapDescriptor destPin;
//  Completer<GoogleMapController> _controller = Completer();
//  GoogleMapController controller;
//  GoogleMapsServices _googleMapServices = GoogleMapsServices();
//  TextEditingController startField = TextEditingController();
//  LatLng currentLocation;
//  LatLng rawLocation;
//  String startingAddress;
//  String destinationAddress;
//  LatLng startingLocation;
//  LatLng destinationLocation;
//  List<Marker> allMarkers = [];
//  final Set<Polyline> _polyLines = {};
//  List<PlacesSearchResult> places = [];
//  bool selectedStartingPoint = false;
//  bool selectedDestinationPoint=false;
//  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: apiKey);
//  bool isInternetConnected;
//  bool isRouteCreated = false;
//
//  _getCurrentUserLocation() async {
//    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//    currentLocation = LatLng(position.latitude, position.longitude);
//    startingAddress = await findAddress(currentLocation);
//    setState(() {
//      startingLocation=currentLocation;
//      startField.text = startingAddress;
//    });
//    _addMarker(currentLocation, true);
//  }
//
////  Future<double> distance() async {
////    double distanceInMeters = await Geolocator().distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
////  return distanceInMeters;
////  }
//
//  _getPlacesPredictions(bool isStartPoint) async {
//    Prediction p = await PlacesAutocomplete.show(
//      context: context,
//      apiKey: apiKey,
//    );
//    displayPrediction(p,isStartPoint);
//  }
//
//  Future<Null> displayPrediction(Prediction p, bool isStartPoint) async {
//    if (p != null) {
//      PlacesDetailsResponse detail =
//      await _places.getDetailsByPlaceId(p.placeId);
//      double lat = detail.result.geometry.location.lat;
//      double lng = detail.result.geometry.location.lng;
//      for (var i = 0; i < p.terms.length; ++i) {
////        print('displayPrediction terms[$i]: ${p.terms[i].value}');
//      }
////      print('displayPrediction matchedSubstrings: ${p.m/\atchedSubstrings}');
//      LatLng tempLatLng = new LatLng(lat, lng);
//      String tempAddress = await findAddress(tempLatLng);
//      setState(()  {
//        if(isStartPoint){
//          startingLocation=tempLatLng;
//          startingAddress = tempAddress;
//        }
//        else{
//          destinationLocation = tempLatLng;
//          destinationAddress = tempAddress;
//          destField.text = destinationAddress;
//        }
//        controller.animateCamera(
//          CameraUpdate.newCameraPosition(
//            CameraPosition(target: isStartPoint ? startingLocation : destinationLocation, zoom: 16.0),
//          ),
//        );
//        _addMarker(isStartPoint ? startingLocation : destinationLocation, isStartPoint);
//      });
//    }
//  }
//
//  @override
//  void initState() {
//    BitmapDescriptor.fromAssetImage(
//        ImageConfiguration(size: Size(9, 9)), 'assets/start_pin.png')
//        .then((onValue) {
//      startPin = onValue;
//    });
//
//    BitmapDescriptor.fromAssetImage(
//        ImageConfiguration(size: Size(9, 9)), 'assets/dest_pin.png')
//        .then((onValue) {
//      destPin = onValue;
//    });
//    _getCurrentUserLocation();
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return SafeArea(
//      child: Scaffold(
//        body: currentLocation == null
//            ? Center(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                CircularProgressIndicator(),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Icon(Icons.location_on),
//                    Text("Please enable location"),
//                  ],
//                )
//              ],
//            ))
//            : Stack(
//          children: <Widget>[
//            GoogleMap(
//              compassEnabled: true,
//              padding: EdgeInsets.only(top: 500),
//              mapType: MapType.normal,
//              myLocationEnabled: true,
//              initialCameraPosition:
//              CameraPosition(target: currentLocation, zoom: 15),
//              onMapCreated: (GoogleMapController controller) {
//                _controller.complete(controller);
//                this.controller = controller;
//              },
//              onCameraMove: onCameraMove,
//              markers: Set.from(allMarkers),
//              polylines: _polyLines,
//            ),
//            destinationLocation!=null ? Align(
//                alignment: Alignment.bottomCenter,
//                child: Padding(
//                  padding: EdgeInsets.only(bottom: 30.0),
//                  child: FloatingActionButton.extended(
//                      onPressed: () {
//                        sendRequest();
//                      },
//                      label: Row(
//                        children: <Widget>[
//                          Icon(Icons.done),
//                          Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: Text("Create Route"),
//                          ),
//                        ],
//                      )
//                  ),
//                )
//            ) : SizedBox(),
//            Positioned(
//              top: 0.0,
//              right: 0.0,
//              left: 0.0,
//              child: Row(children: <Widget>[
//                IconButton(
//                  icon: Icon(
//                    Icons.arrow_back,
//                  ),
//                  onPressed: () {
//                    Navigator.of(context).pop();
//                  },
//                ),
//                Text(
//                  "Plan your Journey!",
//                  style: TextStyle(
//                      fontWeight: FontWeight.bold, fontSize: 16),
//                ),
//              ]),
//            ),
//            Positioned(
//                top: 60.0,
//                right: 15.0,
//                left: 15.0,
//                child: mapTextField(
//                  hintText: 'Starting Point',
//                  onTap:()=> _getPlacesPredictions(true),
//                  icon: Icons.location_on,
//
//                )
//            ),
//            Positioned(
//              top: 115.0,
//              right: 15.0,
//              left: 15.0,
//              child: mapTextField(
//                hintText: 'Destination',
//                onTap: ()=> _getPlacesPredictions(false),
//                icon: Icons.local_taxi,
//
//              )
//            ),
//            Positioned(
//              top: 115.0,
//              right: 15.0,
//              left: 15.0,
//              child: Container(
//                height: 50.0,
//                width: double.infinity,
//                decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.circular(8.0),
//                    boxShadow: [
//                      BoxShadow(
//                          color: Colors.black12,
//                          offset: Offset(0.0, 15.0),
//                          blurRadius: 15.0),
//                      BoxShadow(
//                          color: Colors.black12,
//                          offset: Offset(0.0, -10.0),
//                          blurRadius: 10.0),
//                    ]),
//                child: TextField(
//                  cursorColor: Colors.black,
//                  controller: destField,
//                  textInputAction: TextInputAction.go,
//                  onTap: (){
//                    _getPlacesPredictions(false);
//                  },
//                  decoration: InputDecoration(
//                    icon: Container(
//                      margin: EdgeInsets.only(left: 20, top: 5),
//                      width: 10,
//                      height: 10,
//                      child: Icon(
//                        Icons.local_taxi,
//                        color: Colors.black,
//                      ),
//                    ),
//                    hintText: "Destination?",
//                    border: InputBorder.none,
//                    contentPadding:
//                    EdgeInsets.only(left: 15.0, top: 16.0),
//                  ),
//                ),
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//
//  void sendRequest() async {
//    String route =
//    await _googleMapServices.getRouteCoordinates(startingLocation, destinationLocation);
//    print("creating route");
//    setState(() {
//      _polyLines.clear();
//      _polyLines.add(Polyline(
//          polylineId: PolylineId(this.destinationLocation.toString()),
//          width: 7,
//          points: convertToLatLng(decodePoly(route)),
//          color: Colors.blue));
//      isRouteCreated=true;
//    });
//  }
//
//  void onCameraMove(CameraPosition position) {
//    rawLocation = position.target;
//  }
//
//  void _addMarker(LatLng location, bool isStartPoint) {
//    allMarkers.add(Marker(
//        markerId: MarkerId('$isStartPoint'),
//        position: location,
//        onDragEnd: (position) async {
//          if(isStartPoint) {
//            startingAddress = await findAddress(position);
//            setState(() {
//              startField.text = startingAddress;
//              startingLocation=position;
//              controller.animateCamera(
//                CameraUpdate.newCameraPosition(
//                    CameraPosition(target: position, zoom: 15.0)
//                ),
//              );
//              if(isRouteCreated){
//                sendRequest();
//              }
//            });
//          }
//          else{
//            destinationAddress = await findAddress(position);
//            setState(() {
//              destField.text = destinationAddress;
//              destinationLocation=position;
//              controller.animateCamera(
//                CameraUpdate.newCameraPosition(
//                    CameraPosition(target: position, zoom: 15.0)
//                ),
//              );
//              if(isRouteCreated){
//                sendRequest();
//              }
//            });
//          }
//        },
//        draggable: true,
//        infoWindow: InfoWindow(title: isStartPoint ? startingAddress : destinationAddress, snippet: ""),
//        icon: isStartPoint ? startPin : destPin
//    ));
//  }
//
//
//  Future<String> findAddress(LatLng cords) async{
//    var addresses = await Geocoder.local.findAddressesFromCoordinates(Coordinates(cords.latitude,cords.longitude));
//    String formattedAddress = "";
//    if (addresses.first.addressLine.contains(",")) {
//      List<String> descriptionSplit = addresses.first.addressLine.split(",");
//      for (var i = 0; i < descriptionSplit.length - 1; ++i) {
//        print("descriptionSplit : ${descriptionSplit[i]}");
//        if (i == descriptionSplit.length - 2) {
//          formattedAddress += descriptionSplit[i];
//        } else {
//          formattedAddress += descriptionSplit[i] + ", ";
//        }
//      }
//    } else {
//      formattedAddress = addresses.first.addressLine;
//    }
//    return formattedAddress;
//  }
//
//  Widget mapTextField({String hintText,IconData icon,Function onTap}){
//    return Container(
//      height: 50.0,
//      width: double.infinity,
//      decoration: BoxDecoration(
//          color: Colors.white,
//          borderRadius: BorderRadius.circular(8.0),
//          boxShadow: [
//            BoxShadow(
//                color: Colors.black12,
//                offset: Offset(0.0, 15.0),
//                blurRadius: 15.0),
//            BoxShadow(
//                color: Colors.black12,
//                offset: Offset(0.0, -10.0),
//                blurRadius: 10.0),
//          ]),
//      child: TextField(
//        cursorColor: Colors.black,
//        controller: destField,
//        textInputAction: TextInputAction.go,
//        onTap: (){
//          _getPlacesPredictions(false);
//        },
//        decoration: InputDecoration(
//          icon: Container(
//            margin: EdgeInsets.only(left: 20, top: 5),
//            width: 10,
//            height: 10,
//            child: Icon(
//              Icons.local_taxi,
//              color: Colors.black,
//            ),
//          ),
//          hintText: "Destination?",
//          border: InputBorder.none,
//          contentPadding:
//          EdgeInsets.only(left: 15.0, top: 16.0),
//        ),
//      ),
//    );
//  }
//}