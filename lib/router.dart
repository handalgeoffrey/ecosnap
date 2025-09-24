
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_waste_segregation/main.dart';
import 'package:smart_waste_segregation/screens/camera_screen.dart';
import 'package:smart_waste_segregation/screens/landing_screen.dart';
import 'package:smart_waste_segregation/screens/login_screen.dart';
import 'package:smart_waste_segregation/screens/map_screen.dart';
import 'package:smart_waste_segregation/screens/result_screen.dart';
import 'package:smart_waste_segregation/screens/waste_scanner_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LandingScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
        ),
        GoRoute(
          path: 'camera',
          builder: (BuildContext context, GoRouterState state) {
            return WasteScannerScreen(cameras: cameras);
          },
        ),
        GoRoute(
          path: 'results',
          builder: (BuildContext context, GoRouterState state) {
            // You may need to pass data to the result screen
            return const ResultScreen(wasteType: 'Recyclable', accuracy: 0.95);
          },
        ),
        GoRoute(
          path: 'map',
          builder: (BuildContext context, GoRouterState state) {
            return const MapScreen();
          },
        ),
      ],
    ),
  ],
);
