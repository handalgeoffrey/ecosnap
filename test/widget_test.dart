import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:smart_waste_segregation/main.dart' as app;
import 'package:smart_waste_segregation/screens/camera_screen.dart';
import 'package:smart_waste_segregation/services/auth_service.dart';
import 'package:smart_waste_segregation/theme/theme_provider.dart';

import 'mock_camera.dart';

// Mock camera description for testing purposes
const mockCameraDescription = CameraDescription(
  name: 'mock_camera',
  lensDirection: CameraLensDirection.back,
  sensorOrientation: 90,
);

void main() {
  late MockCameraController mockCameraController;

  setUpAll(() {
    app.cameras = [mockCameraDescription];
  });

  setUp(() {
    mockCameraController = MockCameraController();
    // Stub the initialize method to return a completed future.
    when(mockCameraController.initialize()).thenAnswer((_) => Future.value());
    // Stub the takePicture method to return a dummy file.
    when(mockCameraController.takePicture()).thenAnswer((_) => Future.value(XFile('')));
  });

  testWidgets('App starts at login screen and navigates correctly',
      (WidgetTester tester) async {
    final authService = AuthService();

    final GoRouter router = GoRouter(
      refreshListenable: authService,
      routes: <RouteBase>[
        GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return const app.LandingScreen();
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'camera',
                builder: (BuildContext context, GoRouterState state) {
                  return CameraScreen(
                    camera: mockCameraDescription,
                    mockController: mockCameraController,
                  );
                },
              ),
              GoRoute(
                path: 'result',
                builder: (BuildContext context, GoRouterState state) {
                  final String imagePath = state.extra as String;
                  return app.ResultScreen(imagePath: imagePath);
                },
              ),
            ]),
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const app.LoginScreen();
          },
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) {
        final bool isAuthenticated = authService.isAuthenticated;
        final bool isLoggingIn = state.matchedLocation == '/login';

        if (!isAuthenticated && !isLoggingIn) {
          return '/login';
        }

        if (isAuthenticated && isLoggingIn) {
          return '/';
        }

        return null;
      },
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider.value(value: authService),
        ],
        child: MaterialApp.router(
          title: 'EcoSnap',
          theme: ThemeData.light(),
          routerConfig: router,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Login to continue'), findsOneWidget);

    final Finder usernameField = find.byWidgetPredicate(
      (Widget widget) =>
          widget is TextField && widget.decoration?.labelText == 'Username',
    );
    final Finder passwordField = find.byWidgetPredicate(
      (Widget widget) =>
          widget is TextField && widget.decoration?.labelText == 'Password',
    );
    final Finder loginButton = find.byType(ElevatedButton);

    await tester.enterText(usernameField, 'admin');
    await tester.enterText(passwordField, 'password');
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.text('Welcome to EcoSnap!'), findsOneWidget);

    await tester.tap(find.text('Scan Waste'));
    await tester.pumpAndSettle();

    expect(find.text('Mock Camera Preview'), findsOneWidget);
  });
}
