class NewsEventModel {
  final String id;
  final String title;
  final String content;
  final String type;
  final String? imageUrl;
  final String? authorId;
  final DateTime? eventDate;
  final DateTime publishedAt;
  final bool isPublished;

  NewsEventModel({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    this.imageUrl,
    this.authorId,
    this.eventDate,
    required this.publishedAt,
    required this.isPublished,
  });

  factory NewsEventModel.fromJson(Map<String, dynamic> json) {
    return NewsEventModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      type: json['type'] as String,
      imageUrl: json['image_url'] as String?,
      authorId: json['author_id'] as String?,
      eventDate: json['event_date'] != null
          ? DateTime.parse(json['event_date'] as String)
          : null,
      publishedAt: DateTime.parse(json['published_at'] as String),
      isPublished: json['is_published'] as bool,
    );
  }

  String get formattedDate {
    final date = eventDate ?? publishedAt;
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return 'Today';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  bool get isEvent => type == 'event';
  bool get isNews => type == 'news';
}