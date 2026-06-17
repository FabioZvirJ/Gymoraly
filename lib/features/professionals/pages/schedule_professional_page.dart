import 'package:flutter/material.dart';
import 'package:gymoraly/shared/models/professional_model.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';
import 'package:gymoraly/shared/widgets/app_primary_button.dart';

class ScheduleProfessionalPage extends StatefulWidget {
  const ScheduleProfessionalPage({super.key, required this.professional});

  final ProfessionalModel professional;

  @override
  State<ScheduleProfessionalPage> createState() =>
      _ScheduleProfessionalPageState();
}

class _ScheduleProfessionalPageState extends State<ScheduleProfessionalPage> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '10:30';

  @override
  Widget build(BuildContext context) {
    const times = ['09:00', '10:30', '14:00', '16:30', '19:00'];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          const AppHeader(title: 'Agendar conversa'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCard(
                    child: Row(
                      children: [
                        const Icon(Icons.person, color: AppHeader.primaryColor),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            widget.professional.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selecionar data',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(
                            Icons.calendar_month,
                            color: AppHeader.primaryColor,
                          ),
                          title: Text(
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                          ),
                          trailing: const Icon(Icons.edit_calendar),
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 60),
                              ),
                              initialDate: selectedDate,
                            );
                            if (date != null) {
                              setState(() => selectedDate = date);
                            }
                          },
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Selecionar horário',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: times
                              .map(
                                (time) => ChoiceChip(
                                  label: Text(time),
                                  selected: selectedTime == time,
                                  onSelected: (_) =>
                                      setState(() => selectedTime = time),
                                  selectedColor: AppHeader.primaryColor
                                      .withValues(alpha: 0.15),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Conte seu objetivo...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppPrimaryButton(
                    label: 'Confirmar agendamento',
                    icon: Icons.check,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Agendamento solicitado com sucesso'),
                        ),
                      );
                      Navigator.pop(context);
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
