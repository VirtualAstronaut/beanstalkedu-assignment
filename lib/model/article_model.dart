import 'dart:convert';
import 'dart:developer';

class ArticleModel {
  final Source? source;
  final String? author;
  final String title;
  final String description;
  final String url;
  final String content;
  final String urlToImage;
  final DateTime publishedAt;
  ArticleModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.content,
    required this.urlToImage,
    required this.publishedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'source': source?.toMap(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'content': content,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt.millisecondsSinceEpoch,
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    log(map.toString());
    return ArticleModel(
      source: Source.fromMap(map['source']),
      author: map['author'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      url: map['url'] ?? '',
      content: map['content'] ?? '',
      urlToImage: map['urlToImage'] ?? '',
      publishedAt: DateTime.parse(map['publishedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ArticleModel.fromJson(String source) =>
      ArticleModel.fromMap(json.decode(source));
}

class Source {
  String? id;
  String name;
  Source({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Source.fromMap(Map<String, dynamic> map) {
    return Source(
      id: map['id'],
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Source.fromJson(String source) => Source.fromMap(json.decode(source));
}
