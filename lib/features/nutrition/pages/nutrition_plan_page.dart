import 'package:flutter/material.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';
import 'package:gymoraly/shared/widgets/app_primary_button.dart';
import 'package:gymoraly/shared/widgets/stat_card.dart';

class NutritionPlanPage extends StatelessWidget {
  const NutritionPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final meals = {
      'Café da manhã': ['Ovos mexidos', 'Pão integral', 'Banana'],
      'Lanche da manhã': ['Iogurte natural', 'Granola'],
      'Almoço': ['Arroz', 'Feijão', 'Frango', 'Salada'],
      'Lanche da tarde': ['Whey protein', 'Maçã'],
      'Jantar': ['Tilápia', 'Batata doce', 'Legumes'],
      'Ceia': ['Queijo cottage', 'Castanhas'],
    };

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          const AppHeader(title: 'Plano alimentar'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StatCard(
                    icon: Icons.flag_outlined,
                    title: 'Objetivo',
                    value: 'Ganhar massa magra',
                  ),
                  const SizedBox(height: 10),
                  const StatCard(
                    icon: Icons.local_fire_department_outlined,
                    title: 'Calorias',
                    value: '2.500 kcal/dia',
                  ),
                  const SizedBox(height: 10),
                  const StatCard(
                    icon: Icons.egg_alt_outlined,
                    title: 'Proteínas',
                    value: '160g',
                  ),
                  const SizedBox(height: 10),
                  const StatCard(
                    icon: Icons.bakery_dining_outlined,
                    title: 'Carboidratos',
                    value: '300g',
                  ),
                  const SizedBox(height: 10),
                  const StatCard(
                    icon: Icons.water_drop_outlined,
                    title: 'Gorduras',
                    value: '70g',
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Timeline das refeições',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...meals.entries.map(
                    (entry) => AppCard(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.circle,
                            color: AppHeader.primaryColor,
                            size: 14,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.key,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  entry.value.join(', '),
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  AppPrimaryButton(
                    label: 'Gerar novo plano',
                    icon: Icons.auto_awesome,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Novo plano gerado')),
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
