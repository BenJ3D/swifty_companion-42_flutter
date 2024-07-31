import 'package:flutter/material.dart';

class NavigatorService {
  static final NavigatorService _instance = NavigatorService._internal();

  factory NavigatorService() => _instance;

  NavigatorService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic>? navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic>? navigateToAndRemoveAll(String routeName,
      {dynamic arguments}) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  void goBack() {
    return navigatorKey.currentState?.pop();
  }
}
