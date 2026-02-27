import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injector.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const KadoreApp());
}

class KadoreApp extends StatelessWidget {
  const KadoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [],
      child: MaterialApp(
        title: 'Kadore Fresh',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,

        // home: const HomePage(),
      ),
    );
  }
}
