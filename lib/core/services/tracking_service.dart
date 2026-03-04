import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'location_service.dart';

/// Data model for a driver's live location update.
class DriverLocation {
  final int driverId;
  final int? orderId;
  final double lat;
  final double lng;
  final double speed;
  final DateTime updatedAt;

  DriverLocation({
    required this.driverId,
    this.orderId,
    required this.lat,
    required this.lng,
    required this.speed,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'driverId': driverId,
      'orderId': orderId,
      'lat': lat,
      'lng': lng,
      'speed': speed,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory DriverLocation.fromMap(Map<String, dynamic> map) {
    return DriverLocation(
      driverId: map['driverId'] as int,
      orderId: map['orderId'] as int?,
      lat: (map['lat'] as num).toDouble(),
      lng: (map['lng'] as num).toDouble(),
      speed: (map['speed'] as num).toDouble(),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }
}

/// Service for uploading driver location to Firebase Realtime Database
/// and listening to other drivers' locations.
class TrackingService {
  final FirebaseFirestore _firestore;
  final LocationService _locationService;

  StreamSubscription<Position>? _trackingSubscription;

  /// The Firebase path where live driver data is stored.
  static const String _driversPath = 'live_drivers';

  TrackingService({
    required LocationService locationService,
    FirebaseFirestore? firestore,
  }) : _locationService = locationService,
       _firestore = firestore ?? FirebaseFirestore.instance;

  /// Starts uploading the driver's location to Firebase in real-time.
  ///
  /// [driverId] — unique identifier of the driver.
  /// [orderId]  — optional current order being delivered.
  Future<void> startTracking({required int driverId, int? orderId}) async {
    // Request permission and start GPS stream
    final hasPermission = await _locationService.requestPermission();
    if (!hasPermission) return;

    _locationService.startTracking();

    _trackingSubscription = _locationService.positionStream.listen((
      Position position,
    ) {
      final driverLocation = DriverLocation(
        driverId: driverId,
        orderId: orderId,
        lat: position.latitude,
        lng: position.longitude,
        speed: position.speed,
        updatedAt: DateTime.now(),
      );

      _updateFirebase(driverId, driverLocation);
    });
  }

  /// Pushes the latest location to Firebase.
  Future<void> _updateFirebase(
    int driverId,
    DriverLocation driverLocation,
  ) async {
    try {
      await _firestore
          .collection(_driversPath)
          .doc(driverId.toString())
          .set(driverLocation.toMap());
    } catch (e) {
      // Silently fail — the next update cycle will retry.
      // In production, consider logging to Crashlytics.
    }
  }

  /// Stops uploading location and removes the driver from Firebase.
  Future<void> stopTracking(int driverId) async {
    _trackingSubscription?.cancel();
    _trackingSubscription = null;
    _locationService.stopTracking();

    // try {
    //   await _firestore.collection(_driversPath).doc(driverId.toString()).delete();
    // } catch (_) {}
  }

  /// Listens to a specific driver's location (for customer tracking).
  Stream<DriverLocation?> listenToDriver(int driverId) {
    return _firestore
        .collection(_driversPath)
        .doc(driverId.toString())
        .snapshots()
        .map((snapshot) {
          final data = snapshot.data();
          if (data == null) return null;
          return DriverLocation.fromMap(data);
        });
  }

  /// Gets all currently active drivers (for admin / customer map).
  Stream<List<DriverLocation>> listenToAllDrivers() {
    return _firestore.collection(_driversPath).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => DriverLocation.fromMap(doc.data()))
          .toList();
    });
  }

  /// Disposes all resources.
  void dispose() {
    _trackingSubscription?.cancel();
    _locationService.dispose();
  }
}
