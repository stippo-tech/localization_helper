import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:localization_helper/presentation/screens/home/home_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
      ];
}
