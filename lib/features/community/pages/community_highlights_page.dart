import 'package:flutter/material.dart';
import 'package:gymoraly/features/community/pages/community_post_detail_page.dart';
import 'package:gymoraly/shared/mock/mock_data.dart';
import 'package:gymoraly/shared/models/community_post_model.dart';
import 'package:gymoraly/shared/widgets/app_card.dart';
import 'package:gymoraly/shared/widgets/app_header.dart';
import 'package:gymoraly/shared/widgets/app_search_field.dart';

class CommunityHighlightsPage extends StatelessWidget {
  const CommunityHighlightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: Column(
        children: [
          const AppHeader(title: 'Destaques da Comunidade'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const AppSearchField(hintText: 'Buscar na comunidade'),
                const SizedBox(height: 18),
                ...MockData.communityPosts.map((post) => _PostCard(post: post)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({required this.post});

  final CommunityPostModel post;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: const EdgeInsets.only(bottom: 14),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CommunityPostDetailPage(post: post)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppHeader.primaryColor.withValues(alpha: 0.12),
            child: Text(
              post.author.characters.first,
              style: const TextStyle(
                color: AppHeader.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Autor: ${post.author}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  post.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade700, height: 1.35),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.favorite_border,
                      size: 17,
                      color: AppHeader.primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text('${post.likes} curtidas'),
                    const SizedBox(width: 14),
                    const Icon(
                      Icons.chat_bubble_outline,
                      size: 17,
                      color: AppHeader.primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text('${post.commentsCount} comentários'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
