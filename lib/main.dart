import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:localization_helper/presentation/di/init_di.dart';
import 'package:localization_helper/presentation/router/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDI();

  runApp(_MainApp());
}

class _MainApp extends StatelessWidget {
  _MainApp();

  final _appRouter = GetIt.I.get<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.light(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
