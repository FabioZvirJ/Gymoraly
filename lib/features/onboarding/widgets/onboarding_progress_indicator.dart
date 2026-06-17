import 'package:flutter/material.dart';

class OnboardingProgressIndicator extends StatelessWidget {
  const OnboardingProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Etapa $currentStep de $totalSteps',
          style: const TextStyle(color: Color(0xFF2196F3), fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: currentStep / totalSteps,
            minHeight: 8,
            backgroundColor: Colors.blue.shade50,
            valueColor: const AlwaysStoppedAnimation(Color(0xFF2196F3)),
          ),
        ),
      ],
    );
  }
}
