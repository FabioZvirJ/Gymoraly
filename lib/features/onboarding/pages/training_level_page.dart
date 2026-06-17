import 'package:flutter/material.dart';

import '../models/user_fitness_profile_model.dart';
import '../widgets/onboarding_bottom_button.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/onboarding_progress_indicator.dart';
import '../widgets/option_card.dart';
import 'training_goal_page.dart';

class TrainingLevelPage extends StatefulWidget {
  const TrainingLevelPage({super.key, required this.profile});

  final UserFitnessProfileModel profile;

  @override
  State<TrainingLevelPage> createState() => _TrainingLevelPageState();
}

class _TrainingLevelPageState extends State<TrainingLevelPage> {
  String level = 'beginner';

  final levels = const {
    'beginner': ('Iniciante', 'Pouca ou nenhuma experiência com musculação.'),
    'basic': ('Básico', 'Já treinou um pouco, mas ainda está aprendendo execução e rotina.'),
    'intermediate': ('Intermediário', 'Treina com consistência e conhece boa parte dos exercícios.'),
    'advanced': ('Avançado', 'Tem bastante experiência, boa execução e treina há anos.'),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          const OnboardingHeader(title: 'Nível atual'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OnboardingProgressIndicator(currentStep: 2, totalSteps: 7),
                  const SizedBox(height: 24),
                  const Text('Qual você considera seu nível atual?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 14),
                  ...levels.entries.map((entry) {
                    return OptionCard(
                      title: entry.value.$1,
                      subtitle: entry.value.$2,
                      selected: level == entry.key,
                      onTap: () => setState(() => level = entry.key),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: OnboardingBottomButton(
        text: 'Continuar',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TrainingGoalPage(profile: widget.profile.copyWith(selfDeclaredLevel: level)),
            ),
          );
        },
      ),
    );
  }
}
