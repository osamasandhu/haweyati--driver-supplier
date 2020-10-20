import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUtils {
  static Future<LatLng> get currentLocation async {
    final position = await Geolocator().getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best
    );

    return LatLng(position.latitude, position.longitude);
  }

  static Future<List<Address>> findAddress(LatLng coordinates) async {
    return Geocoder.local.findAddressesFromCoordinates(
      Coordinates(coordinates.latitude, coordinates.longitude)
    );
  }

  static formatAddress(Address address) {
    if (address.addressLine.contains(',')) {
      final buffer = StringBuffer();
      final splitAddress = address.addressLine.split(',');

      for (var i = 0; i < splitAddress.length - 1; ++i) {
        buffer.write(splitAddress[i]);

        if (i != splitAddress.length - 2) {
          buffer.write(', ');
        }
      }

      return buffer.toString();
    } else return address.addressLine;
  }
}