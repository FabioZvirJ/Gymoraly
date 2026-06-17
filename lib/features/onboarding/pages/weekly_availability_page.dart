import 'package:flutter/material.dart';

import '../models/user_fitness_profile_model.dart';
import '../widgets/multi_select_option_card.dart';
import '../widgets/onboarding_bottom_button.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/onboarding_progress_indicator.dart';
import '../widgets/option_card.dart';
import 'physical_info_page.dart';

class WeeklyAvailabilityPage extends StatefulWidget {
  const WeeklyAvailabilityPage({super.key, required this.profile});

  final UserFitnessProfileModel profile;

  @override
  State<WeeklyAvailabilityPage> createState() => _WeeklyAvailabilityPageState();
}

class _WeeklyAvailabilityPageState extends State<WeeklyAvailabilityPage> {
  int days = 3;
  String time = 'one_hour';
  String location = 'full_gym';
  final equipments = <String>{};

  final times = const {
    'forty_five_minutes': '45 minutos',
    'one_hour': '1 hora',
    'one_hour_thirty': '1 hora e 30 minutos',
    'two_hours': '2 horas',
  };

  final locations = const {
    'full_gym': 'Academia completa',
    'simple_gym': 'Academia simples',
    'home': 'Em casa',
    'outdoor': 'Ao ar livre',
    'mixed': 'Misto',
  };

  final equipmentOptions = const {
    'none': 'Nenhum',
    'dumbbells': 'Halteres',
    'elastic': 'Elástico',
    'pullup_bar': 'Barra fixa',
    'bench': 'Banco',
    'kettlebell': 'Kettlebell',
    'ankle_weight': 'Caneleira',
    'mat': 'Colchonete',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          const OnboardingHeader(title: 'Rotina de treino'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OnboardingProgressIndicator(currentStep: 4, totalSteps: 7),
                  const SizedBox(height: 24),
                  const Text('Quantos dias por semana você consegue treinar?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [2, 3, 4, 5, 6].map((value) {
                      return ChoiceChip(
                        label: Text('$value dias'),
                        selected: days == value,
                        onSelected: (_) => setState(() => days = value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 22),
                  const Text('Quanto tempo você tem por treino?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...times.entries.map(
                    (entry) => OptionCard(
                      title: entry.value,
                      selected: time == entry.key,
                      onTap: () => setState(() => time = entry.key),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text('Onde você vai treinar?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...locations.entries.map(
                    (entry) => OptionCard(
                      title: entry.value,
                      selected: location == entry.key,
                      onTap: () => setState(() => location = entry.key),
                    ),
                  ),
                  if (location == 'home') ...[
                    const SizedBox(height: 18),
                    const Text('Você tem equipamentos?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: equipmentOptions.entries.map((entry) {
                        return MultiSelectOptionCard(
                          title: entry.value,
                          selected: equipments.contains(entry.key),
                          onTap: () => setState(() {
                            if (entry.key == 'none') equipments.clear();
                            equipments.contains(entry.key) ? equipments.remove(entry.key) : equipments.add(entry.key);
                          }),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: OnboardingBottomButton(
        text: 'Continuar',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PhysicalInfoPage(
                profile: widget.profile.copyWith(
                  weeklyTrainingDays: days,
                  timePerWorkout: time,
                  trainingLocation: location,
                  equipments: equipments.toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
