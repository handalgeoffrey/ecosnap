import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();

  Future<LocationData?> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await _location.getLocation();
  }

  Future<List<dynamic>> findNearbyDisposalSites(
      double latitude, double longitude, String wasteType) async {
    final sanitizedWasteType = wasteType.toLowerCase().replaceAll(' ', '_');

    // First, try a specific query for the waste type
    String specificQuery = '''
      [out:json];
      (
        node[amenity=recycling][recycling:$sanitizedWasteType=yes](around:5000,$latitude,$longitude);
        way[amenity=recycling][recycling:$sanitizedWasteType=yes](around:5000,$latitude,$longitude);
        relation[amenity=recycling][recycling:$sanitizedWasteType=yes](around:5000,$latitude,$longitude);
      );
      out center;
    ''';

    var response = await http.post(
      Uri.parse('https://overpass-api.de/api/interpreter'),
      body: {'data': specificQuery},
    );

    if (response.statusCode == 200) {
      final results = json.decode(response.body)['elements'];
      if (results.isNotEmpty) {
        return results;
      }
    }

    // If the specific query fails or returns no results, try a general query
    String generalQuery = '''
      [out:json];
      (
        node[amenity=recycling](around:5000,$latitude,$longitude);
        way[amenity=recycling](around:5000,$latitude,$longitude);
        relation[amenity=recycling](around:5000,$latitude,$longitude);
      );
      out center;
    ''';

    response = await http.post(
      Uri.parse('https://overpass-api.de/api/interpreter'),
      body: {'data': generalQuery},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['elements'];
    } else {
      throw Exception('Failed to load disposal sites');
    }
  }
}
