import 'package:flutter/material.dart';

import '../models/user_fitness_profile_model.dart';
import '../widgets/multi_select_option_card.dart';
import '../widgets/onboarding_bottom_button.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/onboarding_progress_indicator.dart';
import '../widgets/option_card.dart';
import 'weekly_availability_page.dart';

class TrainingGoalPage extends StatefulWidget {
  const TrainingGoalPage({super.key, required this.profile});

  final UserFitnessProfileModel profile;

  @override
  State<TrainingGoalPage> createState() => _TrainingGoalPageState();
}

class _TrainingGoalPageState extends State<TrainingGoalPage> {
  String mainGoal = 'hypertrophy';
  final secondary = <String>{};

  final mainGoals = const {
    'weight_loss': 'Emagrecer',
    'hypertrophy': 'Ganhar massa muscular / Hipertrofia',
    'strength': 'Ganhar força',
    'definition': 'Definir o corpo',
    'conditioning': 'Melhorar condicionamento físico',
    'health': 'Saúde e qualidade de vida',
    'return_to_training': 'Voltar a treinar depois de um tempo parado',
    'mobility': 'Melhorar postura e mobilidade',
    'endurance': 'Ganhar resistência',
  };

  final secondaryGoals = const {
    'belly_loss': 'Perder barriga',
    'bigger_arms': 'Aumentar braços',
    'bigger_legs': 'Aumentar pernas',
    'bigger_glutes': 'Aumentar glúteos',
    'chest': 'Melhorar peitoral',
    'back': 'Melhorar costas',
    'cardio': 'Melhorar fôlego',
    'flexibility': 'Melhorar flexibilidade',
    'pain_reduction': 'Reduzir dores',
    'routine': 'Criar rotina de treino',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          const OnboardingHeader(title: 'Objetivos'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OnboardingProgressIndicator(currentStep: 3, totalSteps: 7),
                  const SizedBox(height: 24),
                  const Text('Qual é seu principal objetivo?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 14),
                  ...mainGoals.entries.map(
                    (entry) => OptionCard(
                      title: entry.value,
                      selected: mainGoal == entry.key,
                      onTap: () => setState(() => mainGoal = entry.key),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Você tem algum objetivo secundário?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: secondaryGoals.entries.map((entry) {
                      return MultiSelectOptionCard(
                        title: entry.value,
                        selected: secondary.contains(entry.key),
                        onTap: () => setState(() {
                          secondary.contains(entry.key) ? secondary.remove(entry.key) : secondary.add(entry.key);
                        }),
                      );
                    }).toList(),
                  ),
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
              builder: (_) => WeeklyAvailabilityPage(
                profile: widget.profile.copyWith(mainGoal: mainGoal, secondaryGoals: secondary.toList()),
              ),
            ),
          );
        },
      ),
    );
  }
}
