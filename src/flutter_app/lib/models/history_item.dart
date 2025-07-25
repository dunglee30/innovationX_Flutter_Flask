class HistoryItem {
  final String id;
  final String localFilename;
  final String answer;
  final String timestamp;

  HistoryItem({
    required this.id,
    required this.localFilename,
    required this.answer,
    required this.timestamp,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['id'],
      localFilename: json['local_filename'],
      answer: json['answer'],
      timestamp: json['timestamp'],
    );
  }
}