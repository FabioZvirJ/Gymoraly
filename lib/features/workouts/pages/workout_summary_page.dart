import 'package:flutter/material.dart';
import 'package:gymoraly/features/onboarding/models/training_session_model.dart';
import 'package:gymoraly/shared/mock/mock_data.dart';
import 'package:gymoraly/shared/models/workout_model.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';
import 'package:gymoraly/shared/widgets/app_primary_button.dart';
import 'package:gymoraly/shared/widgets/stat_card.dart';

class WorkoutSummaryPage extends StatelessWidget {
  WorkoutSummaryPage({super.key, WorkoutModel? workout, this.session})
    : workout = workout ?? MockData.workouts[0];

  final WorkoutModel workout;
  final TrainingSessionModel? session;

  @override
  Widget build(BuildContext context) {
    final exerciseNames =
        session?.exercises.map((exercise) => exercise.name).toList() ??
        ['Supino reto', 'Crucifixo', 'Desenvolvimento', 'Rosca direta', 'Rosca martelo', 'Abdominal'];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          const AppHeader(title: 'Treino finalizado 🎉'),
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
                        Text(
                          session?.title ?? workout.title,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _SummaryPill(Icons.timer, '${session?.estimatedDurationMinutes ?? workout.durationMinutes} minutos'),
                            _SummaryPill(Icons.list_alt, '${exerciseNames.length} exercícios'),
                            _SummaryPill(Icons.check_circle, '${exerciseNames.length * 3} séries concluídas'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const StatCard(icon: Icons.monitor_weight_outlined, title: 'Volume total', value: '8.450 kg'),
                  const SizedBox(height: 10),
                  const StatCard(icon: Icons.local_fire_department_outlined, title: 'Calorias estimadas', value: '320 kcal'),
                  const SizedBox(height: 10),
                  StatCard(icon: Icons.emoji_events_outlined, title: 'Melhor exercício', value: exerciseNames.first),
                  const SizedBox(height: 22),
                  const Text('Exercícios feitos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  AppCard(
                    child: Column(
                      children: exerciseNames
                          .map(
                            (name) => ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.check_circle, color: Colors.green),
                              title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 22),
                  AppPrimaryButton(
                    label: 'Salvar treino',
                    icon: Icons.save_outlined,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Treino salvo com sucesso')),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      foregroundColor: AppHeader.primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Voltar para início'),
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

class _SummaryPill extends StatelessWidget {
  const _SummaryPill(this.icon, this.text);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(color: const Color(0xFFF1F3F6), borderRadius: BorderRadius.circular(18)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppHeader.primaryColor),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
        ],
      ),
    );
  }
}
