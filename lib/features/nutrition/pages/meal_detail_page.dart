import 'package:flutter/material.dart';
import 'package:gymoraly/shared/mock/mock_data.dart';
import 'package:gymoraly/shared/models/meal_model.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';
import 'package:gymoraly/shared/widgets/app_primary_button.dart';
import 'package:gymoraly/shared/widgets/stat_card.dart';

class MealDetailPage extends StatelessWidget {
  MealDetailPage({super.key, MealModel? meal})
    : meal = meal ?? MockData.meals[0];

  final MealModel meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          AppHeader(title: meal.name),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCard(
                    child: Row(
                      children: [
                        Icon(
                          meal.completed ? Icons.check_circle : Icons.schedule,
                          color: meal.completed ? Colors.green : Colors.orange,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                meal.completed ? 'Concluído' : 'Pendente',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Horário sugerido: 08:00 • ${meal.calories} kcal',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Alimentos',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  AppCard(
                    child: Column(
                      children: meal.foods
                          .map(
                            (food) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(
                                Icons.restaurant,
                                color: AppHeader.primaryColor,
                              ),
                              title: Text(
                                food,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Macros',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const StatCard(
                    icon: Icons.egg_alt_outlined,
                    title: 'Proteína',
                    value: '32g',
                  ),
                  const SizedBox(height: 10),
                  const StatCard(
                    icon: Icons.bakery_dining_outlined,
                    title: 'Carboidrato',
                    value: '48g',
                  ),
                  const SizedBox(height: 10),
                  StatCard(
                    icon: Icons.water_drop_outlined,
                    title: 'Gordura',
                    value: '14g',
                  ),
                  const SizedBox(height: 10),
                  StatCard(
                    icon: Icons.local_fire_department_outlined,
                    title: 'Calorias',
                    value: '${meal.calories} kcal',
                  ),
                  const SizedBox(height: 24),
                  AppPrimaryButton(
                    label: 'Marcar como concluída',
                    icon: Icons.check,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Refeição marcada como concluída'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Edição de refeição em breve'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Editar refeição'),
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
