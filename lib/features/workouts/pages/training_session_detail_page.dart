import 'package:flutter/material.dart';
import 'package:gymoraly/features/onboarding/models/training_session_model.dart';
import 'package:gymoraly/features/workouts/pages/workout_session_page.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';
import 'package:gymoraly/shared/widgets/app_primary_button.dart';
import 'package:gymoraly/shared/widgets/stat_card.dart';

class TrainingSessionDetailPage extends StatelessWidget {
  const TrainingSessionDetailPage({super.key, required this.session});

  final TrainingSessionModel session;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          AppHeader(title: session.title, subtitle: session.subtitle),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatCard(icon: Icons.timer_outlined, title: 'Duração', value: '${session.estimatedDurationMinutes} min'),
                  const SizedBox(height: 10),
                  StatCard(icon: Icons.list_alt, title: 'Exercícios', value: '${session.exercises.length}'),
                  const SizedBox(height: 10),
                  StatCard(icon: Icons.fitness_center, title: 'Grupos musculares', value: session.muscleGroups.join(', ')),
                  const SizedBox(height: 22),
                  const Text('Exercícios', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...session.exercises.map(
                    (exercise) => AppCard(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(exercise.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          Text(
                            '${exercise.sets} séries • ${exercise.reps} reps • ${_rest(exercise.restSeconds)}',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          if (exercise.notes.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(exercise.notes, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  AppPrimaryButton(
                    label: 'Iniciar sessão',
                    icon: Icons.play_arrow,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => WorkoutSessionPage(session: session)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Edição de sessão em breve')),
                      );
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Editar sessão'),
                    style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _rest(int seconds) {
    final minutes = seconds ~/ 60;
    final rest = seconds % 60;
    return '${minutes}:${rest.toString().padLeft(2, '0')} min';
  }
}
