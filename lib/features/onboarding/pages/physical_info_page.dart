import 'package:flutter/material.dart';

import '../models/user_fitness_profile_model.dart';
import '../widgets/onboarding_bottom_button.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/onboarding_progress_indicator.dart';
import 'limitations_page.dart';

class PhysicalInfoPage extends StatefulWidget {
  const PhysicalInfoPage({super.key, required this.profile});

  final UserFitnessProfileModel profile;

  @override
  State<PhysicalInfoPage> createState() => _PhysicalInfoPageState();
}

class _PhysicalInfoPageState extends State<PhysicalInfoPage> {
  final ageController = TextEditingController(text: '25');
  final heightController = TextEditingController(text: '175');
  final weightController = TextEditingController(text: '70');
  String sex = 'not_informed';
  String activity = 'lightly_active';

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          const OnboardingHeader(title: 'Dados físicos'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OnboardingProgressIndicator(currentStep: 5, totalSteps: 7),
                  const SizedBox(height: 24),
                  _field('Idade', ageController),
                  _field('Altura em cm', heightController),
                  _field('Peso em kg', weightController),
                  const SizedBox(height: 12),
                  const Text('Sexo biológico (opcional)', style: TextStyle(fontWeight: FontWeight.bold)),
                  Wrap(
                    spacing: 8,
                    children: {
                      'not_informed': 'Prefiro não informar',
                      'male': 'Masculino',
                      'female': 'Feminino',
                    }.entries.map((entry) {
                      return ChoiceChip(label: Text(entry.value), selected: sex == entry.key, onSelected: (_) => setState(() => sex = entry.key));
                    }).toList(),
                  ),
                  const SizedBox(height: 18),
                  const Text('Nível de atividade fora da academia', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...{
                    'sedentary': 'Sedentário',
                    'lightly_active': 'Pouco ativo',
                    'moderately_active': 'Moderadamente ativo',
                    'very_active': 'Muito ativo',
                  }.entries.map((entry) {
                    return RadioListTile<String>(
                      value: entry.key,
                      groupValue: activity,
                      onChanged: (value) => setState(() => activity = value!),
                      title: Text(entry.value),
                      activeColor: const Color(0xFF2196F3),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: OnboardingBottomButton(
        text: 'Continuar',
        onPressed: () {
          final age = int.tryParse(ageController.text) ?? 0;
          final height = double.tryParse(heightController.text) ?? 0;
          final weight = double.tryParse(weightController.text) ?? 0;
          if (age < 10 || height < 100 || weight < 25) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Preencha idade, altura e peso com valores realistas.')),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LimitationsPage(
                profile: widget.profile.copyWith(
                  age: age,
                  heightCm: height,
                  weightKg: weight,
                  biologicalSex: sex == 'not_informed' ? null : sex,
                  activityLevel: activity,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
