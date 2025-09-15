
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isCameraAvailable = true;

  @override
  void initState() {
    super.initState();
    try {
      _controller = CameraController(
        widget.camera,
        ResolutionPreset.medium,
      );
      _initializeControllerFuture = _controller.initialize();
    } catch (e) {
      print('Error initializing camera: $e');
      setState(() {
        _isCameraAvailable = false;
      });
    }
  }

  @override
  void dispose() {
    if (_isCameraAvailable) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Waste')),
      body: _isCameraAvailable
          ? FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          : const Center(
              child: Text(
                'No camera available on this device.',
                style: TextStyle(fontSize: 18),
              ),
            ),
      floatingActionButton: _isCameraAvailable
          ? FloatingActionButton(
              onPressed: () async {
                try {
                  await _initializeControllerFuture;
                  final image = await _controller.takePicture();
                  if (!mounted) return;
                  context.go('/result', extra: image.path);
                } catch (e) {
                  print(e);
                }
              },
              child: const Icon(Icons.camera_alt),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
