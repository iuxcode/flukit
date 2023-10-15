import 'package:flukit/flukit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

/// Todo: Write documentation.
extension FluGeo on FluInterface {
  FluGeoService get geoService => FluGeoService();
}

class FluGeoService {
  /// Test if location services are enabled.
  Future<bool> isLocationServiceEnabled() async =>
      Geolocator.isLocationServiceEnabled();

  Future<FluPosition> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    /// When we reach here, permissions are granted and we can
    /// continue accessing the position of the device.
    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    /// Get placemarks
    final List<Placemark> placemarks =
        await getPlacemarksFromCoordinates(position);

    /// Find the country
    final Country country =
        await Country.find(placemarks.first.isoCountryCode!);

    return FluPosition(
      position: position,
      placemarks: placemarks,
      country: country,
    );
  }

  Future<List<Placemark>> getPlacemarksFromCoordinates(
          Position position) async =>
      await placemarkFromCoordinates(position.latitude, position.longitude);

  /// Opens the location settings page.
  /// Returns [true] if the location settings page could be opened, otherwise [false] is returned.
  Future<bool> openLocationSettings() => Geolocator.openLocationSettings();
}

class FluPosition {
  final Position position;
  final Country country;
  final List<Placemark> placemarks;

  FluPosition({
    required this.position,
    required this.country,
    required this.placemarks,
  });
}
