import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
import 'physical_data_page.dart';

class TrainingPreferencesPage extends StatefulWidget {
  const TrainingPreferencesPage({super.key, required this.controller});

  final AuthController controller;

  @override
  State<TrainingPreferencesPage> createState() =>
      _TrainingPreferencesPageState();
}

class _TrainingPreferencesPageState extends State<TrainingPreferencesPage> {
  final goals = const [
    'Hipertrofia',
    'Emagrecimento',
    'Resistência',
    'Condicionamento',
    'Mobilidade',
  ];

  int selectedDays = 3;
  String selectedGoal = 'Hipertrofia';

  @override
  void initState() {
    super.initState();
    selectedDays = widget.controller.model.trainingDaysPerWeek;
    selectedGoal = widget.controller.model.trainingGoal;
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2196F3);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 64,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 18,
              ),
              padding: const EdgeInsets.only(right: 2),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Icon(
                  Icons.fitness_center,
                  size: 50,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Como você quer treinar?',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Vamos montar uma pré-lista com treinos prontos para sua rotina.',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Objetivo',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: goals.map((goal) {
                  final isSelected = selectedGoal == goal;
                  return ChoiceChip(
                    label: Text(goal),
                    selected: isSelected,
                    onSelected: (_) => setState(() => selectedGoal = goal),
                    selectedColor: primaryColor.withValues(alpha: 0.14),
                    labelStyle: TextStyle(
                      color: isSelected ? primaryColor : Colors.grey.shade700,
                      fontWeight: FontWeight.w700,
                    ),
                    side: BorderSide(
                      color: isSelected ? primaryColor : Colors.grey.shade300,
                    ),
                    backgroundColor: Colors.white,
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              const Text(
                'Quantos dias por semana?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(6, (index) => index + 1).map((day) {
                  final isSelected = selectedDays == day;
                  return GestureDetector(
                    onTap: () => setState(() => selectedDays = day),
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isSelected
                              ? primaryColor
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$day',
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 14),
              Text(
                'Com $selectedDays dias, a sugestão começa por ${_splitName(selectedDays)}.',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Anterior',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        widget.controller.model.trainingDaysPerWeek =
                            selectedDays;
                        widget.controller.model.trainingGoal = selectedGoal;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PhysicalDataPage(controller: widget.controller),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Próximo',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  String _splitName(int days) {
    switch (days) {
      case 1:
        return 'Full Body';
      case 2:
        return 'AB';
      case 3:
        return 'ABC';
      case 4:
        return 'ABCD';
      case 5:
        return 'ABCDE';
      default:
        return 'PPL';
    }
  }
}
