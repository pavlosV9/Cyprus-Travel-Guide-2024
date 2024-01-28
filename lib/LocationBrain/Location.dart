import 'package:location/location.dart';
class MyLocationService {
  Location location = Location();
  Future<LocationData?> getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {

      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    try {
      LocationData locationData = await location.getLocation();
      return locationData;
    } catch (e) {
      // Handle any exceptions that occur during fetching the location
      return null;
    }
  }
}
