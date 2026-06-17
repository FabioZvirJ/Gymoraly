import 'package:flutter/material.dart';
import 'package:gymoraly/features/workouts/pages/add_exercise_page.dart';
import 'package:gymoraly/shared/mock/mock_data.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';
import 'package:gymoraly/shared/widgets/app_primary_button.dart';

class CreateWorkoutPage extends StatefulWidget {
  const CreateWorkoutPage({super.key});

  @override
  State<CreateWorkoutPage> createState() => _CreateWorkoutPageState();
}

class _CreateWorkoutPageState extends State<CreateWorkoutPage> {
  String level = 'Intermediário';
  String goal = 'Hipertrofia';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          const AppHeader(title: 'Novo treino'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCard(
                    child: Column(
                      children: [
                        _field('Nome do treino'),
                        const SizedBox(height: 12),
                        _field('Duração estimada'),
                        const SizedBox(height: 12),
                        _dropdown('Nível', level, [
                          'Iniciante',
                          'Intermediário',
                          'Avançado',
                        ], (value) => setState(() => level = value)),
                        const SizedBox(height: 12),
                        _dropdown('Objetivo', goal, [
                          'Hipertrofia',
                          'Emagrecimento',
                          'Resistência',
                          'Mobilidade',
                        ], (value) => setState(() => goal = value)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Exercícios',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddExercisePage(),
                          ),
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text('Adicionar exercício'),
                      ),
                    ],
                  ),
                  AppCard(
                    child: Column(
                      children: MockData.exercises.take(3).map((exercise) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(
                            Icons.fitness_center,
                            color: AppHeader.primaryColor,
                          ),
                          title: Text(
                            exercise.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${exercise.sets} séries • ${exercise.reps}',
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppPrimaryButton(
                    label: 'Salvar treino',
                    icon: Icons.save_outlined,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Treino criado com sucesso'),
                        ),
                      );
                      Navigator.of(context).pop();
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

  Widget _field(String label) {
    return TextField(
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

  Widget _dropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF4F6F8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: (value) {
        if (value != null) onChanged(value);
      },
    );
  }
}
