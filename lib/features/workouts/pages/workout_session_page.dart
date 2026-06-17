import 'package:flutter/material.dart';
import 'package:gymoraly/features/onboarding/models/exercise_model.dart' as generated;
import 'package:gymoraly/features/onboarding/models/training_session_model.dart';
import 'package:gymoraly/features/workouts/pages/workout_summary_page.dart';
import 'package:gymoraly/shared/mock/mock_data.dart';
import 'package:gymoraly/shared/models/workout_model.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';
import 'package:gymoraly/shared/widgets/app_primary_button.dart';

class WorkoutSessionPage extends StatelessWidget {
  WorkoutSessionPage({super.key, WorkoutModel? workout, this.session})
    : workout = workout ?? MockData.workouts[0];

  final WorkoutModel workout;
  final TrainingSessionModel? session;

  @override
  Widget build(BuildContext context) {
    const primaryColor = AppHeader.primaryColor;
    final exercises = _sessionExercises;
    final current = exercises.first;
    final title = session?.title ?? workout.title;
    final subtitle = session?.subtitle ?? '${workout.durationMinutes} min de treino';
    final progressText = 'Exercício 1 de ${exercises.length}';
    final progress = exercises.isEmpty ? 0.0 : 1 / exercises.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          AppHeader(title: title, subtitle: subtitle),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(progressText, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text('${(progress * 100).round()}%', style: const TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 10,
                            backgroundColor: Colors.blue.shade50,
                            valueColor: const AlwaysStoppedAnimation(primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  AppCard(
                    padding: const EdgeInsets.all(22),
                    child: Row(
                      children: [
                        Container(
                          width: 76,
                          height: 76,
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Icon(Icons.fitness_center, color: primaryColor, size: 34),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(current.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  _InfoPill('${current.sets} séries'),
                                  _InfoPill('${current.reps} reps'),
                                  _InfoPill(_rest(current.restSeconds)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text('Séries', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...List.generate(
                    current.sets,
                    (index) => _SetRow(
                      index: index + 1,
                      text: index < 2 ? '${current.reps} reps' : 'Pendente',
                      done: index < 2,
                    ),
                  ),
                  const SizedBox(height: 22),
                  AppPrimaryButton(
                    label: 'Marcar série como concluída',
                    icon: Icons.check,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Série marcada como concluída')),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Próximo exercício carregado')),
                      );
                    },
                    icon: const Icon(Icons.skip_next),
                    label: const Text('Próximo exercício'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      foregroundColor: primaryColor,
                      side: const BorderSide(color: primaryColor),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WorkoutSummaryPage(workout: workout, session: session),
                        ),
                      );
                    },
                    child: const SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: Center(child: Text('Finalizar treino')),
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

  List<generated.ExerciseModel> get _sessionExercises {
    if (session != null && session!.exercises.isNotEmpty) return session!.exercises;
    return workout.exercises.map((exercise) {
      return generated.ExerciseModel(
        id: exercise.id,
        name: exercise.name,
        sets: exercise.sets,
        reps: exercise.reps.replaceAll(' reps', ''),
        restSeconds: 90,
        notes: 'Mantenha execução controlada.',
        muscleGroup: exercise.muscleGroup,
      );
    }).toList();
  }

  String _rest(int seconds) {
    final minutes = seconds ~/ 60;
    final rest = seconds % 60;
    return '${minutes}:${rest.toString().padLeft(2, '0')} min';
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(color: const Color(0xFFF1F3F6), borderRadius: BorderRadius.circular(20)),
      child: Text(
        text,
        style: TextStyle(color: Colors.grey.shade700, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _SetRow extends StatelessWidget {
  const _SetRow({required this.index, required this.text, required this.done});

  final int index;
  final String text;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(done ? Icons.check_circle : Icons.radio_button_unchecked, color: done ? Colors.green : Colors.grey.shade400),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Série $index',
              style: TextStyle(fontWeight: FontWeight.bold, color: done ? Colors.black87 : Colors.grey.shade600),
            ),
          ),
          Text(text, style: TextStyle(color: done ? Colors.black87 : Colors.grey.shade500)),
        ],
      ),
    );
  }
}
