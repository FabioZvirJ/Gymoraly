import 'package:flutter/material.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';
import 'package:gymoraly/shared/widgets/app_primary_button.dart';
import 'package:gymoraly/shared/widgets/stat_card.dart';

class ProgressReportPage extends StatelessWidget {
  const ProgressReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bars = [0.45, 0.70, 0.55, 0.90, 0.62, 0.78, 0.50];
    final suggestions = [
      'Aumente carga com segurança',
      'Reduza descanso em exercícios isolados',
      'Mantenha frequência semanal',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          const AppHeader(title: 'Relatório completo'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StatCard(
                    icon: Icons.fitness_center,
                    title: 'Treinos na semana',
                    value: '4',
                  ),
                  const SizedBox(height: 10),
                  const StatCard(
                    icon: Icons.timer_outlined,
                    title: 'Tempo total',
                    value: '3h20min',
                  ),
                  const SizedBox(height: 10),
                  const StatCard(
                    icon: Icons.monitor_weight_outlined,
                    title: 'Volume total',
                    value: '24.800 kg',
                  ),
                  const SizedBox(height: 10),
                  const StatCard(
                    icon: Icons.local_fire_department_outlined,
                    title: 'Sequência atual',
                    value: '6 dias',
                  ),
                  const SizedBox(height: 22),
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Evolução semanal',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          height: 150,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: bars
                                .map(
                                  (value) => Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                      ),
                                      child: FractionallySizedBox(
                                        heightFactor: value,
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppHeader.primaryColor
                                                .withValues(
                                                  alpha: value > 0.8
                                                      ? 1.0
                                                      : 0.22,
                                                ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Evolução por exercício',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const StatCard(
                    icon: Icons.trending_up,
                    title: 'Supino reto',
                    value: '+5%',
                  ),
                  const SizedBox(height: 10),
                  const StatCard(
                    icon: Icons.trending_up,
                    title: 'Agachamento',
                    value: '+3%',
                  ),
                  const SizedBox(height: 10),
                  const StatCard(
                    icon: Icons.trending_up,
                    title: 'Rosca direta',
                    value: '+4%',
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Sugestões',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...suggestions.map(
                    (item) => AppCard(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.lightbulb_outline,
                            color: AppHeader.primaryColor,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  AppPrimaryButton(
                    label: 'Compartilhar relatório',
                    icon: Icons.share_outlined,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Relatório pronto para compartilhar'),
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
