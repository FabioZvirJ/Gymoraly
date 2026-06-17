import 'package:flutter/material.dart';
import 'package:gymoraly/features/workouts/pages/create_workout_page.dart';
import 'package:gymoraly/features/workouts/pages/workout_detail_page.dart';
import 'package:gymoraly/features/workouts/pages/workout_session_page.dart';
import 'package:gymoraly/shared/mock/mock_data.dart';
import 'package:gymoraly/shared/models/workout_model.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';
import 'package:gymoraly/shared/widgets/app_search_field.dart';

class AllWorkoutsPage extends StatelessWidget {
  const AllWorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          const AppHeader(title: 'Meus treinos'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const AppSearchField(hintText: 'Buscar treino'),
                const SizedBox(height: 16),
                AppCard(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CreateWorkoutPage(),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.add_circle,
                        color: AppHeader.primaryColor,
                        size: 34,
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          'Novo treino',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                ...MockData.workouts.map(
                  (workout) => _WorkoutCard(workout: workout),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  const _WorkoutCard({required this.workout});

  final WorkoutModel workout;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: const EdgeInsets.only(bottom: 14),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => WorkoutDetailPage(workout: workout)),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppHeader.primaryColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.fitness_center,
              color: AppHeader.primaryColor,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workout.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${workout.durationMinutes} min • ${workout.exercises.length} exercícios • ${workout.level}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => WorkoutSessionPage(workout: workout),
              ),
            ),
            child: const Text('Iniciar'),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 15),
        ],
      ),
    );
  }
}
