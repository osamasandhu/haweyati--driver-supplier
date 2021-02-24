import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haweyati_client_data_models/models/others/location_model.dart';
import 'package:haweyati_supplier_driver_app/src/common/map-utils/map-utils.dart';
import 'package:haweyati_supplier_driver_app/src/models/location_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localization-selector.dart';
import 'no-scroll_page.dart';

const _apiKey = 'AIzaSyDdNpY6LGWgHqRfTRZsKkVhocYOaER325w';

class LocationPickerData {
  final String city;
  final String address;
  final LatLng position;

  LocationPickerData({
    this.city, this.address, this.position
  });
}

class LocationPickerPage extends StatefulWidget {
  final Location location;
  LocationPickerPage({this.location});

  @override
  State<LocationPickerPage> createState() => LocationPickerPageState();
}

class LocationPickerPageState extends State<LocationPickerPage> {
  final _markers = <Marker>[];
  final _addressController = TextEditingController();

  String _city;
  LatLng _currentLocation;
  GoogleMapController _controller;

//  String city;
//  String userAddress;
//  LatLng currentLocation;
//  LatLng rawLocation;
//  List<PlacesSearchResult> places = [];
//  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: apiKey);

//  _getCurrentUserLocation([bool fromBtn=false]) async {
//
//    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//    setState(() {
//      currentLocation = LatLng(position.latitude, position.longitude);
//      if(fromBtn){
//        controller.animateCamera(
//          CameraUpdate.newCameraPosition(
//              CameraPosition(target: currentLocation, zoom: 15.0)
//          ),
//        );
//      }
//    });
//    updateAddress();
//    allMarkers.clear();
//    allMarkers.add(Marker(
//        markerId: MarkerId('0'),
//        position: currentLocation,
//        draggable: true,
//        onDragEnd: onMarkerDragEnd
//    ));
//  }
//
//  Future displayPrediction(Prediction p) async {
//    if (p != null) {
//      PlacesDetailsResponse detail =
//      await _places.getDetailsByPlaceId(p.placeId);
//      double lat = detail.result.geometry.location.lat;
//      double lng = detail.result.geometry.location.lng;
//      for (var i = 0; i < p.terms.length; ++i) {
//        print('displayPrediction terms[$i]: ${p.terms[i].value}');
//      }
//      print('displayPrediction matchedSubstrings: ${p.matchedSubstrings}');
//      LatLng tempLatLng = new LatLng(lat, lng);
//
//      setState(()  {
//        currentLocation = tempLatLng;
//        updateAddress();
//        allMarkers.clear();
//        allMarkers.add(Marker(
//          markerId: MarkerId('0'),
//          position: currentLocation,
//          draggable: true,
//          onDragEnd: onMarkerDragEnd,
//        ));
//        controller.animateCamera(
//          CameraUpdate.newCameraPosition(
//            CameraPosition(target: currentLocation, zoom: 16.0),
//          ),
//        );
//      });
//    }
//  }

  @override
  void initState() {
    super.initState();
    _initiateCurrentLocation();
  }

  void _initiateCurrentLocation() async {
    updateCurrentLocation(widget.location!=null ? LatLng(widget.location?.latitude,widget.location?.longitude) : await MapUtils.currentLocation);
  }

  void updateCurrentLocation(LatLng position, [bool flag = true]) async {
    _currentLocation = position;
    final _addresses = await MapUtils.findAddress(position);

    _city = _addresses.first.subAdminArea;
    _addressController.text = MapUtils.formatAddress(_addresses[0]);

    if (flag) {
      _markers.clear();
      _markers.add(Marker(
        draggable: true,
        markerId: MarkerId('0'),
        position: _currentLocation,
        onDragEnd: (position) => updateCurrentLocation(position, false)
      ));
    }

    _controller?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: position, zoom: 15.0)
    ));

    setState(() {});

    SharedPreferences.getInstance().then((value) {
      value.setString('address', _addressController.text);
      value.setDouble('latitude', _currentLocation.latitude);
      value.setDouble('longitude', _currentLocation.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return NoScrollPage(
      appBar: AppBar(
        actions: [
          Center(child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: LocalizationSelector(),
          ))
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10
            ),
            child: SizedBox(
              height: 35,
              child: CupertinoTextField(
                readOnly: true,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(color: Colors.black),
                controller: _addressController,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25)
                ),
                prefix: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(Icons.location_on),
                ),
                suffix: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(Icons.my_location),
                  ),
                  onTap: () async => updateCurrentLocation(await MapUtils.currentLocation)
                ),
              ),
            )
          ),
        ),
      ),

      body: _buildBody(),
      showButtonBackground: true,

      action: 'Set Your Location',
      onAction: _currentLocation != null ?
          () => Navigator.of(context).pop(LocationPickerData(
            city: _city,
            position: _currentLocation,
            address: _addressController.text
          )): null
    );
  }

  Widget _buildBody() {
    if (_currentLocation != null) {
      return GoogleMap(
        compassEnabled: true,
        mapType: MapType.normal,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        markers: Set.from(_markers),
        myLocationButtonEnabled: false,
        initialCameraPosition: CameraPosition(
          target: _currentLocation, zoom: 15
        ),
        onMapCreated: (controller) {
          _controller = controller;
        },
        onTap: (position) => updateCurrentLocation(position)
      );
    } else {
      return Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text('Getting your current location..'),
          ),
          Text('(Make sure you have your location enabled)',style: TextStyle(color: Colors.grey),)
        ],
      ));
    }
  }
}