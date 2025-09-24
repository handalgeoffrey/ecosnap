import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WasteScannerScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const WasteScannerScreen({super.key, required this.cameras});

  @override
  State<WasteScannerScreen> createState() => _WasteScannerScreenState();
}

class _WasteScannerScreenState extends State<WasteScannerScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    if (widget.cameras.isEmpty) {
      _isCameraInitialized = false;
      return;
    }
    _controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _initializeController();
  }

  Future<void> _initializeController() async {
    try {
      await _controller.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } on CameraException catch (e) {
      debugPrint("Error initializing camera: $e");
      setState(() {
        _isCameraInitialized = false;
      });
    } on PlatformException catch (e) {
      debugPrint("Error initializing camera: $e");
      setState(() {
        _isCameraInitialized = false;
      });
    }
  }

  @override
  void dispose() {
    if (widget.cameras.isNotEmpty) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Waste Scanner')),
      body: _isCameraInitialized
          ? CameraPreview(_controller)
          : const Center(
              child: Text(
                'Error: Could not initialize camera.\nPlease ensure you have a working camera on this device.',
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
