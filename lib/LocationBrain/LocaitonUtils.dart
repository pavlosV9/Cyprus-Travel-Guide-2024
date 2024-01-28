import 'package:dio/dio.dart';
import 'package:location/location.dart';
import 'package:tourismappofficial/Places/place.dart';

class LocationUtils {
  static Future<double> calculateDistance(double lat1, double lon1, double lat2, double lon2) async {
    try {
      var response = await Dio().get(
          'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=$lat1,$lon1&destinations=$lat2,$lon2&key=AIzaSyC-NkTAQvxdOBZ8p9TN-8q8PsytIWZWEmA');

      var data = response.data;

      // Added null checks
      if (data != null &&
          data['rows'] != null &&
          data['rows'][0] != null &&
          data['rows'][0]['elements'] != null &&
          data['rows'][0]['elements'][0] != null &&
          data['rows'][0]['elements'][0]['status'] == 'OK') {

        double distance = data['rows'][0]['elements'][0]['distance']['value'] / 1000; // Distance in km
        return distance;
      } else {
        print('Error: ${data != null ? data['status'] : 'Unknown error'}');
        return 0; // Indicate an error
      }
    } catch (e) {
      print(e);
      return 0; // Indicate an error
    }
  }

  static Future<List<Place>> sortPlacesByLocation(List<Place> places, LocationData userLocation) async {
    Map<Place, double> distances = {};

    for (Place place in places) {
      double distance = await calculateDistance(userLocation.latitude!, userLocation.longitude!, place.lat!, place.long!);
      distances[place] = distance;
    }

    places.sort((a, b) => distances[a]!.compareTo(distances[b]!));
    return places;
  }
}
