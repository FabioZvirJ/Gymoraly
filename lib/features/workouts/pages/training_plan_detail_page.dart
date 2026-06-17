import 'package:flutter/material.dart';
import 'package:gymoraly/features/onboarding/models/generated_training_plan_model.dart';
import 'package:gymoraly/features/workouts/pages/training_session_detail_page.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';
import 'package:gymoraly/shared/widgets/stat_card.dart';

class TrainingPlanDetailPage extends StatelessWidget {
  const TrainingPlanDetailPage({super.key, required this.plan});

  final GeneratedTrainingPlanModel plan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          AppHeader(title: plan.title, subtitle: '${plan.sessions.length} sessões • ${plan.level}'),
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
                        Text(plan.description, style: const TextStyle(fontWeight: FontWeight.bold, height: 1.35)),
                        const SizedBox(height: 10),
                        Text(plan.aiExplanation, style: TextStyle(color: Colors.grey.shade700, height: 1.4)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  StatCard(icon: Icons.calendar_month, title: 'Frequência', value: plan.weeklyFrequency),
                  const SizedBox(height: 10),
                  StatCard(icon: Icons.list_alt, title: 'Sessões', value: '${plan.sessions.length}'),
                  const SizedBox(height: 10),
                  StatCard(icon: Icons.trending_up, title: 'Nível', value: plan.level),
                  const SizedBox(height: 10),
                  StatCard(icon: Icons.flag_outlined, title: 'Objetivo', value: plan.goal),
                  const SizedBox(height: 10),
                  StatCard(icon: Icons.timer_outlined, title: 'Duração', value: plan.estimatedDuration),
                  const SizedBox(height: 22),
                  const Text('Como funciona na semana', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  AppCard(
                    child: Column(
                      children: _weekRows()
                          .map(
                            (row) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.event, color: AppHeader.primaryColor),
                              title: Text(row),
                            ),
                          )
                          .toList(),
                    ),
                  ),
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
                                Text('${session.estimatedDurationMinutes} min • ${session.exercises.length} exercícios'),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
                        ],
                      ),
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

  List<String> _weekRows() {
    const days = ['Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'];
    final rows = <String>[];
    for (var i = 0; i < plan.sessions.length && i < days.length; i++) {
      rows.add('${days[i]}: ${plan.sessions[i].title}');
    }
    return rows;
  }
}
