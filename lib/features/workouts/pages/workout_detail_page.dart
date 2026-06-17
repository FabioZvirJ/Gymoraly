import 'package:flutter/material.dart';
import 'package:gymoraly/features/workouts/pages/workout_session_page.dart';
import 'package:gymoraly/shared/models/workout_model.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';
import 'package:gymoraly/shared/widgets/app_primary_button.dart';
import 'package:gymoraly/shared/widgets/stat_card.dart';

class WorkoutDetailPage extends StatelessWidget {
  const WorkoutDetailPage({super.key, required this.workout});

  final WorkoutModel workout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          AppHeader(
            title: workout.title,
            subtitle: '${workout.durationMinutes} min • ${workout.level}',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          icon: Icons.timer_outlined,
                          title: 'Duração',
                          value: '${workout.durationMinutes} min',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: StatCard(
                          icon: Icons.list_alt,
                          title: 'Exercícios',
                          value: '${workout.exercises.length}',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  StatCard(
                    icon: Icons.trending_up,
                    title: 'Nível',
                    value: workout.level,
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Exercícios',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...workout.exercises.asMap().entries.map((entry) {
                    final exercise = entry.value;
                    return AppCard(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppHeader.primaryColor.withValues(
                              alpha: 0.10,
                            ),
                            child: Text(
                              '${entry.key + 1}',
                              style: const TextStyle(
                                color: AppHeader.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exercise.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${exercise.sets} séries • ${exercise.reps} • ${exercise.rest}',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  AppPrimaryButton(
                    label: 'Iniciar treino',
                    icon: Icons.play_arrow,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WorkoutSessionPage(workout: workout),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Edição de treino em breve'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Editar treino'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      foregroundColor: AppHeader.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
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
}
