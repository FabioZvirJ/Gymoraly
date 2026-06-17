import 'package:flutter/material.dart';
import 'package:gymoraly/shared/models/exercise_model.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';
import 'package:gymoraly/shared/widgets/app_primary_button.dart';

class ExerciseConfigPage extends StatelessWidget {
  const ExerciseConfigPage({super.key, required this.exercise});

  final ExerciseModel exercise;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          AppHeader(title: exercise.name),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  AppCard(
                    child: Column(
                      children: [
                        Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            color: AppHeader.primaryColor.withValues(
                              alpha: 0.10,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.fitness_center,
                            color: AppHeader.primaryColor,
                            size: 44,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _field('Séries', '${exercise.sets}'),
                        const SizedBox(height: 12),
                        _field('Repetições', exercise.reps),
                        const SizedBox(height: 12),
                        _field('Carga inicial', '40 kg'),
                        const SizedBox(height: 12),
                        _field('Descanso', exercise.rest),
                        const SizedBox(height: 12),
                        _field(
                          'Observações',
                          'Manter controle na descida',
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppPrimaryButton(
                    label: 'Adicionar ao treino',
                    icon: Icons.add,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Exercício adicionado')),
                      );
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(String label, String initialValue, {int maxLines = 1}) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF4F6F8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
