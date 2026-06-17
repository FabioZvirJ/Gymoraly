import 'dart:ui';
import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'gender_page.dart';

class AgePage extends StatefulWidget {
  final AuthController controller;
  const AgePage({super.key, required this.controller});

  @override
  State<AgePage> createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  final List<String> months = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro',
  ];
  final List<int> days = List.generate(31, (index) => index + 1);
  late final List<int> years;

  int selectedMonthIndex = 2;
  int selectedDayIndex = 28;
  int selectedYearIndex = 30;
  int _calculatedAge = 0;

  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _dayController;
  late FixedExtentScrollController _yearController;

  @override
  void initState() {
    super.initState();
    years = List.generate(
      DateTime.now().year - 1939,
      (index) => DateTime.now().year - index,
    );
    _monthController = FixedExtentScrollController(
      initialItem: selectedMonthIndex,
    );
    _dayController = FixedExtentScrollController(initialItem: selectedDayIndex);
    _yearController = FixedExtentScrollController(
      initialItem: selectedYearIndex,
    );
    _calculateAge();
  }

  @override
  void dispose() {
    _monthController.dispose();
    _dayController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _calculateAge() {
    final now = DateTime.now();
    final birthMonth = selectedMonthIndex + 1;
    final birthDay = days[selectedDayIndex];
    final birthYear = years[selectedYearIndex];

    int age = now.year - birthYear;
    if (now.month < birthMonth ||
        (now.month == birthMonth && now.day < birthDay)) {
      age--;
    }

    setState(() {
      _calculatedAge = age;
    });
  }

  Widget _buildWheelPicker({
    required int itemCount,
    required Widget Function(int index, bool isSelected) itemBuilder,
    required ValueChanged<int> onSelectedItemChanged,
    required FixedExtentScrollController controller,
    required int selectedIndex,
    required double width,
  }) {
    return SizedBox(
      width: width,
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
            ),
            child: ListWheelScrollView.useDelegate(
              controller: controller,
              itemExtent: 52,
              physics: const FixedExtentScrollPhysics(),
              perspective: 0.005,
              overAndUnderCenterOpacity: 0.3,
              onSelectedItemChanged: (index) {
                onSelectedItemChanged(index);
                _calculateAge();
              },
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: itemCount,
                builder: (context, index) {
                  final isSelected = selectedIndex == index;
                  return Center(child: itemBuilder(index, isSelected));
                },
              ),
            ),
          ),
          IgnorePointer(
            child: Container(
              height: 52,
              width: width,
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD).withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2196F3), width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
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
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Icon(Icons.fitness_center, size: 50, color: primaryColor),
              const SizedBox(height: 30),
              const Text(
                'Qual sua idade?',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildWheelPicker(
                    width: 120,
                    itemCount: months.length,
                    controller: _monthController,
                    selectedIndex: selectedMonthIndex,
                    onSelectedItemChanged: (index) =>
                        setState(() => selectedMonthIndex = index),
                    itemBuilder: (index, isSelected) => Text(
                      months[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: isSelected
                            ? Colors.black87
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildWheelPicker(
                    width: 60,
                    itemCount: days.length,
                    controller: _dayController,
                    selectedIndex: selectedDayIndex,
                    onSelectedItemChanged: (index) =>
                        setState(() => selectedDayIndex = index),
                    itemBuilder: (index, isSelected) => Text(
                      days[index].toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: isSelected
                            ? Colors.black87
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildWheelPicker(
                    width: 80,
                    itemCount: years.length,
                    controller: _yearController,
                    selectedIndex: selectedYearIndex,
                    onSelectedItemChanged: (index) =>
                        setState(() => selectedYearIndex = index),
                    itemBuilder: (index, isSelected) => Text(
                      years[index].toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: isSelected
                            ? Colors.black87
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Idade',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$_calculatedAge anos',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const Spacer(),
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
                        if (_calculatedAge < 10) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Você precisa ter pelo menos 10 anos.',
                              ),
                            ),
                          );
                          return;
                        }
                        widget.controller.model.age = _calculatedAge;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GenderPage(controller: widget.controller),
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
}
