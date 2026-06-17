import 'package:flutter/material.dart';
import 'package:gymoraly/features/auth/presentation/pages/main_wrapper_page.dart';
import 'package:gymoraly/features/onboarding/services/current_training_plan_store.dart';
import 'package:gymoraly/features/workouts/pages/create_workout_page.dart';
import 'package:gymoraly/features/workouts/pages/training_plan_detail_page.dart';
import 'package:gymoraly/features/workouts/pages/training_session_detail_page.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';
import 'package:gymoraly/shared/widgets/app_primary_button.dart';
import 'package:gymoraly/shared/widgets/stat_card.dart';

import '../models/generated_training_plan_model.dart';
import '../models/user_fitness_profile_model.dart';
import 'ai_generating_workout_page.dart';

class GeneratedWorkoutReviewPage extends StatelessWidget {
  const GeneratedWorkoutReviewPage({
    super.key,
    required this.profile,
    required this.plan,
  });

  final UserFitnessProfileModel profile;
  final GeneratedTrainingPlanModel plan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          const AppHeader(title: 'Seu treino está pronto'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(plan.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 14),
                        StatCard(icon: Icons.account_tree_outlined, title: 'Divisão', value: plan.divisionType),
                        const SizedBox(height: 10),
                        StatCard(icon: Icons.trending_up, title: 'Nível', value: plan.level),
                        const SizedBox(height: 10),
                        StatCard(icon: Icons.calendar_month, title: 'Frequência', value: plan.weeklyFrequency),
                        const SizedBox(height: 10),
                        StatCard(icon: Icons.timer_outlined, title: 'Duração', value: plan.estimatedDuration),
                        const SizedBox(height: 10),
                        StatCard(icon: Icons.flag_outlined, title: 'Objetivo', value: plan.goal),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Por que escolhemos esse treino?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                        const SizedBox(height: 8),
                        Text(plan.aiExplanation, style: TextStyle(color: Colors.grey.shade700, height: 1.4)),
                      ],
                    ),
                  ),
                  if (profile.hasLimitations) ...[
                    const SizedBox(height: 16),
                    const AppCard(
                      child: Text(
                        'Seu treino foi adaptado considerando suas limitações. Em caso de dor, procure um profissional.',
                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w700, height: 1.35),
                      ),
                    ),
                  ],
                  const SizedBox(height: 22),
                  const Text('Sessões do treino', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...plan.sessions.map(
                    (session) => AppCard(
                      margin: const EdgeInsets.only(bottom: 12),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TrainingSessionDetailPage(session: session)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.fitness_center, color: AppHeader.primaryColor),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(session.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text(session.subtitle, style: TextStyle(color: Colors.grey.shade600)),
                                Text(
                                  '${session.estimatedDurationMinutes} min • ${session.exercises.length} exercícios',
                                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  AppPrimaryButton(
                    label: 'Aceitar treino',
                    icon: Icons.check,
                    onPressed: () {
                      CurrentTrainingPlanStore.instance.acceptPlan(plan);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MainWrapperPage(
                            userName: profile.name ?? 'Aluno',
                            trainingGoal: plan.goal,
                            trainingDaysPerWeek: profile.weeklyTrainingDays,
                          ),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => AiGeneratingWorkoutPage(profile: profile)),
                    ),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Gerar novamente'),
                    style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                  ),
                  const SizedBox(height: 10),
                  TextButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateWorkoutPage())),
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Editar manualmente'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TrainingPlanDetailPage(plan: plan)),
                    ),
                    child: const Text('Ver detalhe completo do plano'),
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
