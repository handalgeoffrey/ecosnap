import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

// Create a mock for the CameraController class
class MockCameraController extends Mock implements CameraController {
  @override
  Future<void> initialize() => super.noSuchMethod(
        Invocation.method(#initialize, []),
        returnValue: Future.value(),
        returnValueForMissingStub: Future.value(),
      );

  @override
  Future<XFile> takePicture() => super.noSuchMethod(
        Invocation.method(#takePicture, []),
        returnValue: Future.value(XFile('')),
        returnValueForMissingStub: Future.value(XFile('')),
      );

  @override
  Widget buildPreview() => super.noSuchMethod(
        Invocation.method(#buildPreview, []),
        returnValue: const SizedBox(),
        returnValueForMissingStub: const SizedBox(),
      );
}
