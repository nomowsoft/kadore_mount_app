import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kadore_mount/core/network/endpoint.dart';
import 'package:kadore_mount/core/services/directions_service.dart';

import '../network/dio_client.dart';
import '../services/location_service.dart';
import '../services/tracking_service.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Core network client
  getIt.registerLazySingleton(() => DioClient(Endpoint.baseUrl));
  getIt.registerLazySingleton<Dio>(() => getIt<DioClient>().dio);

  // Location & tracking services
  getIt.registerLazySingleton(() => LocationService());
  getIt.registerLazySingleton(
    () => TrackingService(locationService: getIt<LocationService>()),
  );
  getIt.registerLazySingleton(() => DirectionsService());
}
