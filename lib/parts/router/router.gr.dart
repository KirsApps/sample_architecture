// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

import '../../ui_kit/ui_kit.dart' as _i1;

class RootRouter extends _i2.RootStackRouter {
  RootRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    AppSplashRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.AppSplashScreen());
    }
  };

  @override
  List<_i2.RouteConfig> get routes =>
      [_i2.RouteConfig(AppSplashRoute.name, path: '/splash')];
}

/// generated route for [_i1.AppSplashScreen]
class AppSplashRoute extends _i2.PageRouteInfo<void> {
  const AppSplashRoute() : super(name, path: '/splash');

  static const String name = 'AppSplashRoute';
}
