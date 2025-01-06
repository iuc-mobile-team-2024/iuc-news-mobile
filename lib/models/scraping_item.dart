class ScrapingResult {
  final String value;
  final DateTime timestamp;

  ScrapingResult({
    required this.value,
    required this.timestamp,
  });
}

class ScrapingItem {
  final String? id;
  final String title;
  final String url;
  final String method;
  final String selector;
  final int interval;
  final DateTime createdAt;
  String? status;
  String? content;
  List<ScrapingResult>? results;
  DateTime? lastUpdated;

  ScrapingItem({
    this.id,
    required this.title,
    required this.url,
    required this.method,
    required this.selector,
    required this.interval,
    required this.createdAt,
    this.status,
    this.content,
    this.results,
    this.lastUpdated,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
      'method': method,
      'selector': selector,
      'interval': interval,
    };
  }

  factory ScrapingItem.fromJson(Map<String, dynamic> json) {
    return ScrapingItem(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      method: json['method'],
      selector: json['selector'],
      interval: json['interval'],
      createdAt: DateTime.parse(json['created_at']),
      status: json['status'],
      content: json['content'],
      lastUpdated: json['updated_time'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['updated_time'] * 1000)
          : null,
    );
  }
}