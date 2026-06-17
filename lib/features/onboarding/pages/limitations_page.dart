import 'package:flutter/material.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';

import '../models/user_fitness_profile_model.dart';
import '../widgets/multi_select_option_card.dart';
import '../widgets/onboarding_bottom_button.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/onboarding_progress_indicator.dart';
import 'ai_generating_workout_page.dart';

class LimitationsPage extends StatefulWidget {
  const LimitationsPage({super.key, required this.profile});

  final UserFitnessProfileModel profile;

  @override
  State<LimitationsPage> createState() => _LimitationsPageState();
}

class _LimitationsPageState extends State<LimitationsPage> {
  final limitations = <String>{'none'};
  final descriptionController = TextEditingController();
  final dislikedController = TextEditingController();

  final options = const {
    'none': 'Nenhuma',
    'shoulder': 'Ombro',
    'knee': 'Joelho',
    'spine': 'Coluna',
    'lower_back': 'Lombar',
    'wrist': 'Punho',
    'elbow': 'Cotovelo',
    'hip': 'Quadril',
    'ankle': 'Tornozelo',
    'other': 'Outra',
  };

  @override
  void dispose() {
    descriptionController.dispose();
    dislikedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          const OnboardingHeader(title: 'Limitações'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OnboardingProgressIndicator(currentStep: 6, totalSteps: 7),
                  const SizedBox(height: 24),
                  const Text('Você tem alguma dor, lesão ou limitação?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: options.entries.map((entry) {
                      return MultiSelectOptionCard(
                        title: entry.value,
                        selected: limitations.contains(entry.key),
                        onTap: () => setState(() {
                          if (entry.key == 'none') {
                            limitations
                              ..clear()
                              ..add('none');
                          } else {
                            limitations.remove('none');
                            limitations.contains(entry.key) ? limitations.remove(entry.key) : limitations.add(entry.key);
                          }
                          if (limitations.isEmpty) limitations.add('none');
                        }),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  _field('Descreva melhor, se quiser', descriptionController),
                  _field('Existe algum exercício que você não pode ou não gosta?', dislikedController),
                  const SizedBox(height: 12),
                  const AppCard(
                    child: Text(
                      'Este app não substitui orientação médica ou profissional. Em caso de dor, lesão ou limitação, procure um profissional.',
                      style: TextStyle(color: Colors.grey, height: 1.35),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: OnboardingBottomButton(
        text: 'Gerar meu treino',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AiGeneratingWorkoutPage(
                profile: widget.profile.copyWith(
                  limitations: limitations.toList(),
                  limitationDescription: descriptionController.text,
                  dislikedExercises: dislikedController.text,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: 3,
        decoration: InputDecoration(
          hintText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
