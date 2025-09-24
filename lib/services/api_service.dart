/*
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:smart_waste_segregation/models/waste_classification.dart';

class ApiService {
  final String _authority = 'us-central1-smart-waste-segregation-app.cloudfunctions.net';
  final String _path = 'classifyWaste';

  Future<List<WasteClassification>> classifyWaste(String imagePath) async {
    final imageFile = File(imagePath);
    final request = http.MultipartRequest(
      'POST',
      Uri.https(_authority, _path),
    );
    request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final List<dynamic> results = json.decode(responseBody);
      return results
          .map((result) => WasteClassification.fromJson(result))
          .toList();
    } else {
      throw Exception('Failed to classify waste');
    }
  }
}
*/
