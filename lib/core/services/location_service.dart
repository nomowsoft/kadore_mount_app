import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

/// Service for managing GPS location access and streaming.
class LocationService {
  StreamSubscription<Position>? _positionSubscription;
  final StreamController<Position> _positionController =
      StreamController<Position>.broadcast();

  /// Stream of position updates.
  Stream<Position> get positionStream => _positionController.stream;

  /// Requests location permissions and returns true if granted.
  Future<bool> requestPermission() async {
    var status = await Permission.locationWhenInUse.status;

    if (status.isDenied) {
      status = await Permission.locationWhenInUse.request();
    }

    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }

    return status.isGranted;
  }

  /// Gets the current position once.
  Future<Position?> getCurrentPosition() async {
    final hasPermission = await requestPermission();
    if (!hasPermission) return null;

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  /// Starts streaming location updates every [intervalMs] milliseconds.
  /// Default is 5 seconds as per PRD requirement.
  void startTracking({int intervalMs = 5000, int distanceFilter = 5}) {
    _positionSubscription?.cancel();

    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5, // minimum distance (in meters) before an update
    );

    _positionSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (Position position) {
            _positionController.add(position);
          },
          onError: (error) {
            _positionController.addError(error);
          },
        );
  }

  /// Stops streaming location updates.
  void stopTracking() {
    _positionSubscription?.cancel();
    _positionSubscription = null;
  }

  /// Disposes all resources.
  void dispose() {
    stopTracking();
    _positionController.close();
  }
}
