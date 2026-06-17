import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';

class QuickTimerPage extends StatefulWidget {
  const QuickTimerPage({super.key});

  @override
  State<QuickTimerPage> createState() => _QuickTimerPageState();
}

class _QuickTimerPageState extends State<QuickTimerPage> {
  int seconds = 90;
  int initialSeconds = 90;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void start() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds <= 0) {
        timer?.cancel();
      } else {
        setState(() => seconds--);
      }
    });
  }

  String get formatted {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final rest = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$rest';
  }

  @override
  Widget build(BuildContext context) {
    final presets = {
      30: '30s',
      60: '1:00',
      90: '1:30',
      120: '2:00',
      180: '3:00',
    };

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          const AppHeader(title: 'Cronômetro Rápido'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  AppCard(
                    padding: const EdgeInsets.symmetric(
                      vertical: 34,
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 190,
                          height: 190,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppHeader.primaryColor.withValues(
                                alpha: 0.20,
                              ),
                              width: 14,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              formatted,
                              style: const TextStyle(
                                fontSize: 44,
                                fontWeight: FontWeight.bold,
                                color: AppHeader.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            FilledButton.icon(
                              onPressed: start,
                              icon: const Icon(Icons.play_arrow),
                              label: const Text('Iniciar'),
                            ),
                            OutlinedButton.icon(
                              onPressed: () => timer?.cancel(),
                              icon: const Icon(Icons.pause),
                              label: const Text('Pausar'),
                            ),
                            OutlinedButton.icon(
                              onPressed: () {
                                timer?.cancel();
                                setState(() => seconds = initialSeconds);
                              },
                              icon: const Icon(Icons.restart_alt),
                              label: const Text('Resetar'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: presets.entries
                        .map(
                          (entry) => ChoiceChip(
                            label: Text(entry.value),
                            selected: initialSeconds == entry.key,
                            onSelected: (_) {
                              timer?.cancel();
                              setState(() {
                                initialSeconds = entry.key;
                                seconds = entry.key;
                              });
                            },
                            selectedColor: AppHeader.primaryColor.withValues(
                              alpha: 0.15,
                            ),
                          ),
                        )
                        .toList(),
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
