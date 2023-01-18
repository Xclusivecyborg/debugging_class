

class TesLaNews {
  TesLaNews({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  factory TesLaNews.fromJson(Map<String, dynamic> json) => TesLaNews(
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
        author: json["author"] as String?,
        title: json["title"] as String?,
        description: json["description"] as String?,
        url: json["url"] as String?,
        urlToImage: json["urlToImage"] as String?,
        publishedAt: json["publishedAt"] == null
            ? null
            : DateTime.parse(json["publishedAt"]),
        content: json["content"] as String?,
      );
}

class Source {
  Source({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"] as String?,
        name: json["name"] as String?,
      );
}
