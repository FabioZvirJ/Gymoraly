import 'package:flutter/material.dart';
import 'package:gymoraly/features/workouts/pages/workout_summary_page.dart';
import 'package:gymoraly/shared/mock/mock_data.dart';
import 'package:gymoraly/shared/models/workout_model.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';
import 'package:gymoraly/shared/widgets/app_primary_button.dart';

class WorkoutSessionPage extends StatelessWidget {
  WorkoutSessionPage({super.key, WorkoutModel? workout})
    : workout = workout ?? MockData.workouts[0];

  final WorkoutModel workout;

  @override
  Widget build(BuildContext context) {
    const primaryColor = AppHeader.primaryColor;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          AppHeader(
            title: workout.title,
            subtitle: '${workout.durationMinutes} min de treino',
          ),
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
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Exercício 2 de 6',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '33%',
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: 0.33,
                            minHeight: 10,
                            backgroundColor: Colors.blue.shade50,
                            valueColor: const AlwaysStoppedAnimation(
                              primaryColor,
                            ),
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
                          child: const Icon(
                            Icons.fitness_center,
                            color: primaryColor,
                            size: 34,
                          ),
                        ),
                        const SizedBox(width: 18),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Supino reto',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  _InfoPill('4 séries'),
                                  _InfoPill('10-12 reps'),
                                  _InfoPill('1:30 min'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Séries',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const _SetRow(index: 1, text: '40 kg x 12 reps', done: true),
                  const _SetRow(index: 2, text: '45 kg x 10 reps', done: true),
                  const _SetRow(index: 3, text: 'Pendente', done: false),
                  const _SetRow(index: 4, text: 'Pendente', done: false),
                  const SizedBox(height: 22),
                  AppPrimaryButton(
                    label: 'Marcar série como concluída',
                    icon: Icons.check,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Série marcada como concluída'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Próximo exercício carregado'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.skip_next),
                    label: const Text('Próximo exercício'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      foregroundColor: primaryColor,
                      side: const BorderSide(color: primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WorkoutSummaryPage(workout: workout),
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
}

class _InfoPill extends StatelessWidget {
  const _InfoPill(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
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
          Icon(
            done ? Icons.check_circle : Icons.radio_button_unchecked,
            color: done ? Colors.green : Colors.grey.shade400,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Série $index',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: done ? Colors.black87 : Colors.grey.shade600,
              ),
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: done ? Colors.black87 : Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
