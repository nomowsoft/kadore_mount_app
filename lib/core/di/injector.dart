import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kadore_mount/core/network/endpoint.dart';

import '../network/dio_client.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Core network client
  getIt.registerLazySingleton(() => DioClient(Endpoint.baseUrl));
  getIt.registerLazySingleton<Dio>(() => getIt<DioClient>().dio);

}

