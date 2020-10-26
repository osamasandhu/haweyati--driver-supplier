import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoder/geocoder.dart';
import 'package:haweyati_supplier_driver_app/l10n/app_localizations.dart';
import 'package:haweyati_supplier_driver_app/src/models/location_model.dart' as l;
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/no-scroll_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/raised-action-button.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/waiting-dialog.dart';
import 'package:haweyati_supplier_driver_app/utils/const.dart';
import 'package:haweyati_supplier_driver_app/widgits/localization-selector.dart';
import 'package:location/location.dart' as loc;
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
const apiKey = 'AIzaSyDdNpY6LGWgHqRfTRZsKkVhocYOaER325w';


/// These are the coordinates of Saudi Arabia
const _mapBounds = const [
  const LatLng(28.157300, 34.630000),
  const LatLng(29.313309, 35.070000),
  const LatLng(29.121500, 36.168600),
  const LatLng(30.550000, 38.102000),
  const LatLng(31.454900, 37.223000),
  const LatLng(32.090100, 39.244800),
  const LatLng(29.179100, 44.606000),
  const LatLng(28.980000, 47.280000),
  const LatLng(28.480000, 47.630000),
  const LatLng(28.486100, 48.363400),
  const LatLng(27.574500, 48.802900),
  const LatLng(27.233200, 49.231300),
  const LatLng(26.841800, 49.810000),
  const LatLng(26.440000, 50.170000),
  const LatLng(25.880000, 50.050000),
  const LatLng(25.629000, 50.182100),
  const LatLng(25.388000, 50.463000),
  const LatLng(24.786800, 50.718000),
  const LatLng(24.447000, 51.080000),
  const LatLng(24.500000, 51.317000),
  const LatLng(24.581000, 51.399000),
  const LatLng(24.394300, 51.279000),
  const LatLng(24.270500, 51.266000),
  const LatLng(24.312000, 51.423000),
  const LatLng(24.248000, 51.520000),
  const LatLng(24.278000, 51.740000),
  const LatLng(24.248200, 51.581400),
  const LatLng(24.154000, 51.586000),
  const LatLng(24.106000, 51.592000),
  const LatLng(22.934000, 52.577000),
  const LatLng(22.629000, 55.131000),
  const LatLng(22.700000, 55.204000),
  const LatLng(22.002000, 55.649000),
  const LatLng(22.010000, 54.970000),
  const LatLng(19.020000, 51.970000),
  const LatLng(18.820000, 50.770000),
  const LatLng(18.660000, 49.110000),
  const LatLng(18.210000, 48.172000),
  const LatLng(17.480000, 47.560000),
  const LatLng(17.140000, 47.450000),
  const LatLng(16.970000, 47.170000),
  const LatLng(16.970000, 47.008000),
  const LatLng(17.310000, 46.760000),
  const LatLng(17.257000, 46.360000),
  const LatLng(17.352000, 45.409000),
  const LatLng(17.457000, 45.220000),
  const LatLng(17.381000, 43.684000),
  const LatLng(17.564200, 43.337900),
  const LatLng(16.448000, 42.790000),
  const LatLng(28.157300, 34.630000)
];



class LocationPickerMapPage extends StatefulWidget {
  final LatLng coordinates;

  LocationPickerMapPage([this.coordinates]);

  @override
  _LocationPickerMapPageState createState() => _LocationPickerMapPageState();
}

class _LocationPickerMapPageState extends State<LocationPickerMapPage> {
  Address _address;
  LatLng _location;
  bool _initiated = false;
  GoogleMapController _controller;

  final _utils = _MapUtilsImpl();
  final _markers = Set<Marker>();

  @override
  void initState() {
    super.initState();

    _location = widget.coordinates;
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context, lang) => NoScrollView(
          appBar: AppBar(
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Center(
                    child: LocalizationSelector(),
                  ),
                )
              ],
              title: Image.asset(AppLogo, width: 40, height: 40),
              centerTitle: true,
              leading: IconButton(
                  icon: Transform.rotate(
                    angle: Localizations.localeOf(context).toString() == 'ar' ? 3.14159 : 0,
                    child: Image.asset(ArrowBackIcon, width: 26, height: 26),
                  ),
                  onPressed: Navigator.of(context).pop
              ),
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Image.asset(LocationIcon, width: 15),
                            ),
                            Expanded(
                              child: CupertinoTextField(
                                onTap: () async {
                                  final prediction = await PlacesAutocomplete.show(
                                    context: context, apiKey: apiKey,
                                      components: [Component(Component.country, "sau")]

                                  );

                                  if (prediction != null) {
                                    final detail = await GoogleMapsPlaces(apiKey: apiKey)
                                        .getDetailsByPlaceId(prediction.placeId);

                                    _setLocationOnMap(LatLng(
                                        detail.result.geometry.location.lat,
                                        detail.result.geometry.location.lng
                                    ));
                                  }
                                },
                                readOnly: true,
                                padding: const EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                style: TextStyle(color: Colors.grey.shade700),
                                controller: TextEditingController(text: _address?.addressLine ?? 'Tap To Search'),
                              ),
                            ),
                            GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 7),
                                  child: Image.asset(MyLocationIcon, width: 24),
                                ),
                                onTap: () async => _setLocationOnMap(null)
                            ),
                          ],
                        ),
                      )
                  )
              )
          ),
          body: _resolveMap(),
          bottom: RaisedActionButton(
            label: lang.setYourLocation,
            onPressed: (_location != null && _initiated) ? () {
              Navigator.of(context).pop(l.Location(
                  city: _address.locality,
                  address: _address.addressLine,
                  latitude: _location.latitude,
                  longitude: _location.longitude
              ));
            } : null,
          )
      ),
    );
  }

  final _bounds = Set<Polygon>()..add(Polygon(
      polygonId: PolygonId('0'),
      points: _mapBounds,
      fillColor: Colors.transparent,
      strokeWidth: 2,
      strokeColor: Colors.red
  ));

  _resolveMap() {
    if (_initiated) {
      return GoogleMap(
        initialCameraPosition: CameraPosition(
            target: _location, zoom: 15
        ),
        onTap: _setLocationOnMap,
        polygons: _bounds,
        onMapCreated: (controller) {
          _controller = controller;
        },
        zoomControlsEnabled: false,
        compassEnabled: true,
        markers: _markers,
      );
    } else {
      if (_location != null) {
        _setLocationOnMap(_location);
      } else {
        _utils.fetchCurrentLocation().then(_setLocationOnMap);
      }

      return Center(child: Row(children: [
        SizedBox(
            width: 25, height: 25,
            child: CircularProgressIndicator(strokeWidth: 1)
        ),
        SizedBox(width: 20),
        Text(AppLocalizations.of(context).fetchingCurrentCoordinates)
      ], mainAxisAlignment: MainAxisAlignment.center));
    }
  }

  _setLocationOnMap(LatLng location) async {
    if (_controller != null) {
      showDialog(context: context, builder: (context) => WaitingDialog(
          message: AppLocalizations.of(context).fetchingLocationData
      ));
    }

    if (location == null) {
      _location = await _utils.fetchCurrentLocation();
    } else {
      _location = location;
    }
    _markers..clear()..add(Marker(
        draggable: true,
        position: _location,
        markerId: MarkerId('\0'),
        onDragEnd: _setLocationOnMap
    ));

    _address = await _utils.fetchAddress(_location);
    if (_controller != null) {
      Navigator.of(context).pop();
      _controller.animateCamera(CameraUpdate.newLatLng(_location));
    }

    if (!_initiated) _initiated = true;
    setState(() {});
  }
}

class _MapUtilsImpl {
  final _location = loc.Location();

  Future<Address> fetchAddress(final LatLng location) async {
    return (await Geocoder.google(apiKey)
        .findAddressesFromCoordinates(Coordinates(location.latitude, location.longitude)))
        .first;
  }

  Future<LatLng> fetchCurrentLocation() async {
    final position = await _location.getLocation();
    return LatLng(position.latitude, position.longitude);
  }
}