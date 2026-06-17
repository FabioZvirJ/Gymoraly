import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';

import '../models/generated_training_plan_model.dart';
import '../models/user_fitness_profile_model.dart';
import '../services/fake_ai_workout_generator_service.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/onboarding_progress_indicator.dart';
import 'generated_workout_review_page.dart';

class AiGeneratingWorkoutPage extends StatefulWidget {
  const AiGeneratingWorkoutPage({super.key, required this.profile});

  final UserFitnessProfileModel profile;

  @override
  State<AiGeneratingWorkoutPage> createState() => _AiGeneratingWorkoutPageState();
}

class _AiGeneratingWorkoutPageState extends State<AiGeneratingWorkoutPage> {
  final service = FakeAiWorkoutGeneratorService();
  final messages = const [
    'Analisando seu nível...',
    'Verificando seus objetivos...',
    'Escolhendo a melhor divisão...',
    'Montando seus exercícios...',
    'Ajustando volume e descanso...',
    'Finalizando seu plano...',
  ];

  int messageIndex = 0;
  Timer? timer;
  bool failed = false;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 750), (_) {
      if (!mounted) return;
      setState(() => messageIndex = (messageIndex + 1) % messages.length);
    });
    _generate();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> _generate() async {
    try {
      final plan = await service.generateWorkout(widget.profile);
      if (!mounted) return;
      _goToReview(plan);
    } catch (_) {
      if (mounted) setState(() => failed = true);
    }
  }

  void _goToReview(GeneratedTrainingPlanModel plan) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => GeneratedWorkoutReviewPage(profile: widget.profile, plan: plan),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          const OnboardingHeader(title: 'Criando seu treino'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const OnboardingProgressIndicator(currentStep: 7, totalSteps: 7),
                  const SizedBox(height: 32),
                  AppCard(
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        const CircularProgressIndicator(color: Color(0xFF2196F3)),
                        const SizedBox(height: 24),
                        Text(
                          failed ? 'Não foi possível gerar com IA agora.' : messages[messageIndex],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Estamos usando seu perfil para montar uma divisão segura, editável e adequada à sua rotina.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey.shade600, height: 1.35),
                        ),
                        if (failed) ...[
                          const SizedBox(height: 18),
                          ElevatedButton(
                            onPressed: () => _goToReview(service.generateFallback(widget.profile)),
                            child: const Text('Gerar treino básico'),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
