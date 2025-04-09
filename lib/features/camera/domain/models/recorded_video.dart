class RecordedVideo {
  final String id;
  final String filePath;
  final String thumbnailPath;
  final DateTime createdAt;
  final Duration duration;
  
  RecordedVideo({
    required this.id,
    required this.filePath,
    required this.thumbnailPath,
    required this.createdAt,
    required this.duration,
  });
}