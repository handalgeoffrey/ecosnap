import 'dart:typed_data';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:smart_waste_segregation/secrets.dart';

class GeminiService {
  final GenerativeModel _model;

  GeminiService()
      : _model = GenerativeModel(
          model: 'gemini-1.5-flash',
          apiKey: geminiApiKey,
        );

  Future<String> classifyWaste(Uint8List imageBytes) async {
    final response = await _model.generateContent([
      Content.multi([
        TextPart(
            'Please classify the waste in the image as one of the following: Organic, Plastic, Glass, Hazardous. If the image does not contain any waste, please respond with "No waste detected".'),
        DataPart('image/jpeg', imageBytes),
      ]),
    ]);

    return response.text ?? 'Could not classify the image.';
  }
}
