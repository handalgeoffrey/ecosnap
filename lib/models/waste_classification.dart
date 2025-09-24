class WasteClassification {
  final String wasteType;
  final String disposalInfo;
  final String dos;
  final String donts;
  final double? confidence;

  WasteClassification({
    required this.wasteType,
    required this.disposalInfo,
    required this.dos,
    required this.donts,
    this.confidence,
  });

  factory WasteClassification.fromJson(Map<String, dynamic> json) {
    return WasteClassification(
      wasteType: json['waste_type'] ?? 'Unknown',
      disposalInfo: json['disposal_info'] ?? 'No information available.',
      dos: json['dos'] ?? '',
      donts: json['donts'] ?? '',
      confidence: (json['confidence'] as num?)?.toDouble(),
    );
  }
}
