import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kadore_mount/core/services/directions_service.dart';

import '../../../../core/di/injector.dart';
import '../../../../core/services/tracking_service.dart';
import '../../../../core/theme/app_colors.dart';

class DriverDeliveryMapPage extends StatefulWidget {
  final int driverId;
  final int orderId;
  final String customerName;
  final String customerAddress;
  final LatLng customerLocation;

  const DriverDeliveryMapPage({
    super.key,
    required this.driverId,
    required this.orderId,
    required this.customerName,
    required this.customerAddress,
    required this.customerLocation,
  });

  @override
  State<DriverDeliveryMapPage> createState() => _DriverDeliveryMapPageState();
}

class _DriverDeliveryMapPageState extends State<DriverDeliveryMapPage> {
  final TrackingService _trackingService = getIt<TrackingService>();
  final Completer<GoogleMapController> _mapController = Completer();

  LatLng? _currentDriverLocation;
  final Set<Marker> _markers = {};
  final DirectionsService _directionsService = getIt<DirectionsService>();
  final Set<Polyline> _polylines = {};
  String? _distance;
  String? _duration;
  StreamSubscription<DriverLocation?>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _startTracking();
  }

  Future<void> _startTracking() async {
    // Start uploading the driver's location to Firebase
    await _trackingService.startTracking(
      driverId: widget.driverId,
      orderId: widget.orderId,
    );

    // Listen to our own location updates from Firebase to update the map
    _locationSubscription = _trackingService
        .listenToDriver(widget.driverId)
        .listen((driverLocation) {
          if (driverLocation != null && mounted) {
            setState(() {
              _currentDriverLocation = LatLng(
                driverLocation.lat,
                driverLocation.lng,
              );
              _updateMarkers();
              _updatePolyline();
            });
            _animateToDriver();
          }
        });

    // Add customer marker immediately
    _markers.add(
      Marker(
        markerId: const MarkerId('customer'),
        position: widget.customerLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
          title: widget.customerName,
          snippet: widget.customerAddress,
        ),
      ),
    );
  }

  void _updateMarkers() {
    // Remove old driver marker and add updated one
    _markers.removeWhere((m) => m.markerId.value == 'driver');

    if (_currentDriverLocation != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('driver'),
          position: _currentDriverLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          infoWindow: const InfoWindow(title: 'موقعك الحالي'),
        ),
      );
    }
  }

  Future<void> _updatePolyline() async {
    if (_currentDriverLocation == null) return;

    final result = await _directionsService.getRoute(
      origin: _currentDriverLocation!,
      destination: widget.customerLocation,
    );

    if (result == null) return;

    setState(() {
      _polylines.clear();
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          points: result.points,
          width: 6,
          color: Colors.green,
        ),
      );

      _distance = result.distanceText;
      _duration = result.durationText;
    });
  }

  Future<void> _animateToDriver() async {
    if (_currentDriverLocation == null) return;
    final controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newLatLng(_currentDriverLocation!));
  }

  Future<void> _confirmArrival() async {
    await _trackingService.stopTracking(widget.driverId);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    _trackingService.stopTracking(widget.driverId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final initialPosition = _currentDriverLocation ?? widget.customerLocation;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تتبع التوصيل',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: initialPosition,
              zoom: 15,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            polylines: _polylines,
            onMapCreated: (controller) {
              if (!_mapController.isCompleted) {
                _mapController.complete(controller);
              }
            },
          ),

          // Draggable Bottom Info Sheet
          DraggableScrollableSheet( 
            // initialChildSize: 0.5,
             minChildSize: 0.18,
             maxChildSize: 0.5,
            // snap: true,
            // snapSizes: const [0.18, 0.5, 0.5],
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 15,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      // Handle
                      Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Header Row: Time & Distance
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildInfoStat(
                                  'الوقت المتبقي',
                                  _duration ?? '...',
                                  Icons.access_time_filled,
                                ),
                                _buildInfoStat(
                                  'المسافة',
                                  _distance ?? '...',
                                  Icons.directions_car,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 16),
                            // Customer Section
                            Text(
                              'معلومات العميل',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const CircleAvatar(
                                backgroundColor: AppColors.primary,
                                child: Icon(Icons.person, color: Colors.white),
                              ),
                              title: Text(
                                widget.customerName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(widget.customerAddress),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.phone,
                                  color: AppColors.primary,
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Arrival Button
                            ElevatedButton(
                              onPressed: _confirmArrival,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'تأكيد الوصول',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoStat(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.darkOliveBlack,
          ),
        ),
      ],
    );
  }
}
