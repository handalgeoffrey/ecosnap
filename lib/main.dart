
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_waste_segregation/screens/camera_screen.dart';
import 'package:smart_waste_segregation/screens/landing_screen.dart';
import 'package:smart_waste_segregation/screens/login_screen.dart';
import 'package:smart_waste_segregation/screens/map_screen.dart';
import 'package:smart_waste_segregation/screens/result_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(camera: firstCamera),
    ),
  );
}

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.camera});

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF004D40); // Deep Teal
    const Color accentColor = Color(0xFF4CAF50); // Vibrant Green

    final TextTheme appTextTheme = TextTheme(
      displayLarge: GoogleFonts.montserrat(
          fontSize: 57, fontWeight: FontWeight.bold, color: primaryColor),
      titleLarge: GoogleFonts.montserrat(
          fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
      bodyMedium: GoogleFonts.lato(fontSize: 14, color: Colors.black87),
      labelLarge:
          GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
    );

    final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: accentColor,
        brightness: Brightness.light,
        background: Colors.grey.shade100,
      ),
      textTheme: appTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          textStyle: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
          elevation: 5,
          shadowColor: Colors.black.withOpacity(0.2),
        ),
      ),
    );

    final GoRouter router = GoRouter(
      initialLocation: '/login',
      routes: <RouteBase>[
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
        ),
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const LandingScreen();
          },
        ),
        GoRoute(
          path: '/camera',
          builder: (BuildContext context, GoRouterState state) {
            return CameraScreen(camera: camera);
          },
        ),
        GoRoute(
          path: '/result',
          builder: (BuildContext context, GoRouterState state) {
            return ResultScreen(imagePath: state.extra as String? ?? '');
          },
        ),
        GoRoute(
          path: '/map',
          builder: (BuildContext context, GoRouterState state) {
            return const MapScreen();
          },
        ),
      ],
    );

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp.router(
          title: 'EcoSnap',
          theme: lightTheme,
          // Dark theme can be defined here if needed
          themeMode: themeProvider.themeMode,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
