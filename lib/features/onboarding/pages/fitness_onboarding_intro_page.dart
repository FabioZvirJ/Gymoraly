import 'package:flutter/material.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';

import '../models/user_fitness_profile_model.dart';
import '../widgets/onboarding_bottom_button.dart';
import '../widgets/onboarding_header.dart';
import 'training_experience_page.dart';

class FitnessOnboardingIntroPage extends StatelessWidget {
  const FitnessOnboardingIntroPage({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          const OnboardingHeader(
            title: 'Vamos montar seu treino',
            subtitle: 'Responda algumas perguntas para criarmos um plano personalizado para você.',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _IntroLine('Seu treino será criado com base no seu nível, objetivo e rotina.'),
                    _IntroLine('Você poderá editar tudo depois.'),
                    _IntroLine('A IA vai sugerir a melhor divisão de treino para você.'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: OnboardingBottomButton(
        text: 'Começar',
        onPressed: () {
          final profile = UserFitnessProfileModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: userName,
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TrainingExperiencePage(profile: profile)),
          );
        },
      ),
    );
  }
}

class _IntroLine extends StatelessWidget {
  const _IntroLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF2196F3), size: 22),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15, height: 1.35))),
        ],
      ),
    );
  }
}
