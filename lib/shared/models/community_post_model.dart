class CommunityPostModel {
  const CommunityPostModel({
    required this.id,
    required this.title,
    required this.author,
    required this.content,
    required this.likes,
    required this.commentsCount,
  });

  final String id;
  final String title;
  final String author;
  final String content;
  final int likes;
  final int commentsCount;
}
