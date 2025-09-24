
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String wasteType;
  final double accuracy;

  const ResultScreen({super.key, required this.wasteType, required this.accuracy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Waste Type: $wasteType'),
            Text('Accuracy: $accuracy'),
          ],
        ),
      ),
    );
  }
}
