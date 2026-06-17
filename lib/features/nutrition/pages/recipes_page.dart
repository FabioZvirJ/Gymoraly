import 'package:flutter/material.dart';
import 'package:gymoraly/features/nutrition/pages/recipe_detail_page.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';
import 'package:gymoraly/shared/widgets/app_search_field.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const recipes = [
      'Omelete de claras',
      'Frango com batata doce',
      'Panqueca de banana',
      'Bowl proteico',
      'Salada com frango',
    ];
    const chips = ['Café da manhã', 'Almoço', 'Jantar', 'Lanches'];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          const AppHeader(title: 'Receitas saudáveis'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const AppSearchField(hintText: 'Buscar receita'),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: chips
                      .map(
                        (chip) => Chip(
                          label: Text(chip),
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.grey.shade200),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 18),
                ...recipes.map(
                  (recipe) => AppCard(
                    margin: const EdgeInsets.only(bottom: 12),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecipeDetailPage(recipeName: recipe),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(
                            Icons.restaurant_menu,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            recipe,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
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
