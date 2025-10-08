
import 'dart:math';

import 'package:smart_waste_segregation/models/waste_classification.dart';

class ApiService {
  Future<WasteClassification> classifyWaste(String imagePath) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    final random = Random();
    final wasteData = {
      'Organic': {
        'disposalInfo':
            'Organic waste should be composted to create nutrient-rich soil.',
        'dos':
            '- Compost fruit and vegetable scraps.\n- Include coffee grounds and tea bags.\n- Add eggshells and nutshells.',
        'donts':
            '- Do not compost meat, fish, or dairy products.\n- Avoid oily foods and grease.\n- Keep plastic and other non-organic materials out of your compost bin.',
      },
      'Plastic': {
        'disposalInfo':
            'Recycle clean and dry plastic containers. Check local guidelines for accepted plastic types.',
        'dos':
            '- Rinse containers before recycling.\n- Flatten bottles to save space.\n- Check for the recycling symbol (numbers 1-7) to determine recyclability.',
        'donts':
            '- Do not recycle plastic bags or films in curbside bins.\n- Avoid recycling containers with food residue.\n- Keep caps on bottles unless your local facility advises otherwise.',
      },
      'Glass': {
        'disposalInfo':
            'Glass bottles and jars are highly recyclable. Separate them by color if required by your local facility.',
        'dos':
            '- Rinse glass containers.\n- Remove lids and caps.\n- Check if your local program accepts all colors of glass.',
        'donts':
            '- Do not recycle light bulbs, mirrors, or ceramics with glass containers.\n- Avoid breaking the glass, as it can be a safety hazard for workers.',
      },
      'Hazardous': {
        'disposalInfo':
            'Hazardous waste must be disposed of at special collection sites. Never put it in your regular trash or recycling.',
        'dos':
            '- Store hazardous materials in their original containers.\n- Take them to a designated hazardous waste drop-off location.\n- Follow all safety precautions when handling these materials.',
        'donts':
            '- Do not pour chemicals down the drain or on the ground.\n- Do not mix different types of hazardous waste.\n- Avoid throwing batteries or electronics in the regular trash.',
      },
    };

    final selectedWasteType =
        wasteData.keys.toList()[random.nextInt(wasteData.length)];
    final classificationData = wasteData[selectedWasteType]!;

    return WasteClassification(
      wasteType: selectedWasteType,
      disposalInfo: classificationData['disposalInfo']!,
      dos: classificationData['dos']!,
      donts: classificationData['donts']!,
    );
  }
}
