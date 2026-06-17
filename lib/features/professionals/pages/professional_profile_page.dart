import 'package:flutter/material.dart';
import 'package:gymoraly/features/professionals/pages/schedule_professional_page.dart';
import 'package:gymoraly/shared/mock/mock_data.dart';
import 'package:gymoraly/shared/models/professional_model.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';
import 'package:gymoraly/shared/widgets/app_primary_button.dart';
import 'package:gymoraly/shared/widgets/stat_card.dart';

class ProfessionalProfilePage extends StatelessWidget {
  ProfessionalProfilePage({super.key, ProfessionalModel? professional})
    : professional = professional ?? MockData.professionals[0];

  final ProfessionalModel professional;

  @override
  Widget build(BuildContext context) {
    const services = [
      'Consultoria mensal',
      'Plano alimentar',
      'Treino personalizado',
      'Avaliação física',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          AppHeader(title: professional.name),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  AppCard(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: AppHeader.primaryColor.withValues(
                            alpha: 0.12,
                          ),
                          child: const Icon(
                            Icons.person,
                            color: AppHeader.primaryColor,
                            size: 48,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          professional.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          professional.role,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: StatCard(
                                icon: Icons.people_outline,
                                title: 'Seguidores',
                                value: professional.followers,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: StatCard(
                                icon: Icons.star_outline,
                                title: 'Avaliação',
                                value: professional.rating.toStringAsFixed(1),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          professional.bio,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Serviços',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...services.map(
                          (service) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            title: Text(
                              service,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  AppPrimaryButton(
                    label: 'Agendar conversa',
                    icon: Icons.calendar_month_outlined,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ScheduleProfessionalPage(
                          professional: professional,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profissional seguido')),
                      );
                    },
                    icon: const Icon(Icons.favorite_border),
                    label: const Text('Seguir'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      foregroundColor: AppHeader.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
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
