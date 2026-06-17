import 'package:flutter/material.dart';
import 'package:gymoraly/features/community/pages/community_post_detail_page.dart';
import 'package:gymoraly/features/community/pages/create_topic_page.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';

class ForumTopicsPage extends StatelessWidget {
  const ForumTopicsPage({super.key, required this.forumTitle});

  final String forumTitle;

  @override
  Widget build(BuildContext context) {
    final topics = [
      (
        'Melhor divisão para 4 dias?',
        'Lucas',
        '18 respostas',
        'Atualizado hoje',
      ),
      ('Como aquecer antes do treino?', 'Marina', '9 respostas', 'Ontem'),
      (
        'Dúvida sobre progressão de carga',
        'Glynto Silva',
        '24 respostas',
        '2 dias',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppHeader.primaryColor,
        foregroundColor: Colors.white,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CreateTopicPage()),
        ),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          AppHeader(title: forumTitle),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: topics
                  .map(
                    (topic) => AppCard(
                      margin: const EdgeInsets.only(bottom: 12),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CommunityPostDetailPage(),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.forum_outlined,
                            color: AppHeader.primaryColor,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  topic.$1,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${topic.$2} • ${topic.$3}',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  topic.$4,
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
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
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
