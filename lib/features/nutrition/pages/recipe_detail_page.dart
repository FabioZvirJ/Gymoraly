import 'package:flutter/material.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';
import 'package:gymoraly/shared/widgets/app_primary_button.dart';
import 'package:gymoraly/shared/widgets/stat_card.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({super.key, required this.recipeName});

  final String recipeName;

  @override
  Widget build(BuildContext context) {
    const ingredients = [
      '2 ovos',
      '100g de frango',
      '1 banana',
      'Aveia',
      'Temperos naturais',
    ];
    const steps = [
      'Misture os ingredientes principais.',
      'Aqueça uma frigideira antiaderente.',
      'Cozinhe até dourar dos dois lados.',
      'Sirva com uma fonte de fibras.',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          AppHeader(title: recipeName),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 170,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Icons.restaurant_menu,
                      size: 70,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          icon: Icons.timer_outlined,
                          title: 'Preparo',
                          value: '20 min',
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: StatCard(
                          icon: Icons.local_fire_department_outlined,
                          title: 'Calorias',
                          value: '380 kcal',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Ingredientes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  AppCard(
                    child: Column(
                      children: ingredients
                          .map(
                            (item) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.check),
                              title: Text(item),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Modo de preparo',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  AppCard(
                    child: Column(
                      children: steps
                          .asMap()
                          .entries
                          .map(
                            (entry) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                child: Text('${entry.key + 1}'),
                              ),
                              title: Text(entry.value),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 22),
                  AppPrimaryButton(
                    label: 'Adicionar ao plano',
                    icon: Icons.add,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Receita adicionada ao plano'),
                        ),
                      );
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
}
