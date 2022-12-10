import 'dart:convert';
import 'dart:developer';

import 'package:hive/hive.dart';
part 'article_model.g.dart';

@HiveType(typeId: 0)
class ArticleModel {
  @HiveField(0)
  final Source? source;
  @HiveField(1)
  final String? author;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String url;
  @HiveField(5)
  final String content;
  @HiveField(6)
  final String urlToImage;
  @HiveField(7)
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is ArticleModel &&
        other.author == author &&
        other.title == title;
  }
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
