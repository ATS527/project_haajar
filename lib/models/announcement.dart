class Announcement {
  final String title;
  final DateTime timestamp;
  final String description;
  final String? attachment;

  Announcement({
    required this.title,
    required this.timestamp,
    required this.description,
    required this.attachment,
  });
}
