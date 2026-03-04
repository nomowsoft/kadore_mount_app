import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsResult {
  final List<LatLng> points;
  final String distanceText;
  final String durationText;

  DirectionsResult({
    required this.points,
    required this.distanceText,
    required this.durationText,
  });
}

class DirectionsService {
  final Dio _dio = Dio();

  Future<DirectionsResult?> getRoute({
    required LatLng origin,
    required LatLng destination,
  }) async {
    const apiKey = "AIzaSyAin9szizHkUR5ihPfMUn-7jePUN9Kop1o";
    final url = "https://routes.googleapis.com/directions/v2:computeRoutes";
    final response = await _dio.post(
      url,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          // 🔑 THE FIX: API key must be here, NOT in queryParameters
          'X-Goog-Api-Key': apiKey,
          // ✅ Required: Specify the data you want back
          'X-Goog-FieldMask':
              'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline',
        },
      ),
      data: {
        "origin": {
          "location": {
            "latLng": {
              "latitude": origin.latitude,
              "longitude": origin.longitude,
            },
          },
        },
        "destination": {
          "location": {
            "latLng": {
              "latitude": destination.latitude,
              "longitude": destination.longitude,
            },
          },
        },
        // "routeTravelMode": "DRIVE", // You can change this as needed
        // "routingPreference": "TRAFFIC_AWARE", // Optional but recommended
      },
    );

    if (response.data["routes"].isEmpty) return null;

    final route = response.data["routes"][0];
    final distanceMeters = route["distanceMeters"];
    final duration = route["duration"];

    final polyline = route["polyline"]["encodedPolyline"];

    return DirectionsResult(
      points: _decodePolyline(polyline),
      distanceText: distanceMeters.toString(),
      durationText: duration.toString(),
    );
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }
}
