import 'package:flutter/cupertino.dart';

class News {
  final String id;
  final String name;
  final String description;
  final String url;
  final String category;
  final String language;
  final String country;

  News(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.url,
      @required this.category,
      @required this.language,
      @required this.country});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        id: json['id'] as String,
        name: json['name'] as String,
        category: json['category'] as String,
        url: json['url'] as String,
        language: json['language'] as String,
        description: json['description'] as String,
        country: json['country'] as String);
  }
}
