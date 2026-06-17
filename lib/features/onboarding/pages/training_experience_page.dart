import 'package:flutter/material.dart';

import '../models/user_fitness_profile_model.dart';
import '../widgets/onboarding_bottom_button.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/onboarding_progress_indicator.dart';
import '../widgets/option_card.dart';
import 'training_level_page.dart';

class TrainingExperiencePage extends StatefulWidget {
  const TrainingExperiencePage({super.key, required this.profile});

  final UserFitnessProfileModel profile;

  @override
  State<TrainingExperiencePage> createState() => _TrainingExperiencePageState();
}

class _TrainingExperiencePageState extends State<TrainingExperiencePage> {
  String status = 'never_trained';
  String trainingTime = 'none';
  String stoppedTime = 'none';

  final statuses = const {
    'never_trained': 'Nunca pratiquei',
    'trained_before': 'Já pratiquei, mas parei',
    'currently_training': 'Pratico atualmente',
  };

  final trainingTimes = const {
    'less_than_1_month': 'Menos de 1 mês',
    'one_to_three_months': '1 a 3 meses',
    'three_to_six_months': '3 a 6 meses',
    'six_months_to_one_year': '6 meses a 1 ano',
    'one_to_two_years': '1 a 2 anos',
    'two_to_three_years': '2 a 3 anos',
    'more_than_three_years': 'Mais de 3 anos',
  };

  final stoppedTimes = const {
    'less_than_1_month': 'Menos de 1 mês',
    'one_to_three_months': '1 a 3 meses',
    'three_to_six_months': '3 a 6 meses',
    'six_months_to_one_year': '6 meses a 1 ano',
    'more_than_one_year': 'Mais de 1 ano',
  };

  @override
  Widget build(BuildContext context) {
    final needsTrainingTime = status != 'never_trained';
    final needsStoppedTime = status == 'trained_before';

    return _OnboardingScaffold(
      title: 'Experiência',
      step: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Você já pratica ou já praticou academia?', style: _questionStyle),
          const SizedBox(height: 14),
          ...statuses.entries.map((entry) {
            return OptionCard(
              title: entry.value,
              selected: status == entry.key,
              onTap: () => setState(() {
                status = entry.key;
                if (status == 'never_trained') {
                  trainingTime = 'none';
                  stoppedTime = 'none';
                }
              }),
            );
          }),
          if (needsTrainingTime) ...[
            const SizedBox(height: 18),
            const Text('Por quanto tempo você treinou?', style: _questionStyle),
            const SizedBox(height: 12),
            ...trainingTimes.entries.map(
              (entry) => OptionCard(
                title: entry.value,
                selected: trainingTime == entry.key,
                onTap: () => setState(() => trainingTime = entry.key),
              ),
            ),
          ],
          if (needsStoppedTime) ...[
            const SizedBox(height: 18),
            const Text('Há quanto tempo você está parado?', style: _questionStyle),
            const SizedBox(height: 12),
            ...stoppedTimes.entries.map(
              (entry) => OptionCard(
                title: entry.value,
                selected: stoppedTime == entry.key,
                onTap: () => setState(() => stoppedTime = entry.key),
              ),
            ),
          ],
        ],
      ),
      buttonText: 'Continuar',
      enabled: !needsTrainingTime || (trainingTime != 'none' && (!needsStoppedTime || stoppedTime != 'none')),
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TrainingLevelPage(
              profile: widget.profile.copyWith(
                alreadyTrainedStatus: status,
                trainingTime: trainingTime,
                stoppedTrainingTime: stoppedTime,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _OnboardingScaffold extends StatelessWidget {
  const _OnboardingScaffold({
    required this.title,
    required this.step,
    required this.child,
    required this.buttonText,
    required this.onNext,
    this.enabled = true,
  });

  final String title;
  final int step;
  final Widget child;
  final String buttonText;
  final VoidCallback onNext;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          OnboardingHeader(title: title),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OnboardingProgressIndicator(currentStep: step, totalSteps: 7),
                  const SizedBox(height: 24),
                  child,
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: OnboardingBottomButton(text: buttonText, onPressed: onNext, enabled: enabled),
    );
  }
}

const _questionStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
