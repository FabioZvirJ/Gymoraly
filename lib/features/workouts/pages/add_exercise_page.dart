import 'package:flutter/material.dart';
import 'package:gymoraly/features/workouts/pages/exercise_config_page.dart';
import 'package:gymoraly/shared/mock/mock_data.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';
import 'package:gymoraly/shared/widgets/app_search_field.dart';

class AddExercisePage extends StatelessWidget {
  const AddExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    const categories = [
      'Peito',
      'Costas',
      'Bíceps',
      'Tríceps',
      'Pernas',
      'Ombro',
      'Abdômen',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          const AppHeader(title: 'Adicionar exercício'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const AppSearchField(hintText: 'Buscar exercício'),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: categories
                      .map(
                        (category) => Chip(
                          label: Text(category),
                          backgroundColor: category == 'Peito'
                              ? AppHeader.primaryColor.withValues(alpha: 0.12)
                              : Colors.white,
                          labelStyle: TextStyle(
                            color: category == 'Peito'
                                ? AppHeader.primaryColor
                                : Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                          side: BorderSide(color: Colors.grey.shade200),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 18),
                ...MockData.exercises.map(
                  (exercise) => AppCard(
                    margin: const EdgeInsets.only(bottom: 10),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ExerciseConfigPage(exercise: exercise),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.fitness_center,
                          color: AppHeader.primaryColor,
                        ),
                        const SizedBox(width: 14),
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
                              Text(
                                exercise.muscleGroup,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
