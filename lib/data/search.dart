import 'package:json_annotation/json_annotation.dart';

class Search {
  @JsonKey(name: 'continue')
  final Continue continueStr;
  final Query query;

  const Search({
    required this.continueStr,
    required this.query,
  });

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
        continueStr: Continue.fromJson(json['continue']),
        query: Query.fromJson(json['query'])
    );
  }
}

class Continue {
  final int sroffset;
  final int gpsoffset;

  const Continue({
    required this.sroffset,
    required this.gpsoffset,
  });

  factory Continue.fromJson(Map<String, dynamic> json) {
    return Continue(
        sroffset: json['sroffset'],
        gpsoffset: json['gpsoffset']
    );
  }
}

class Query {
  final List<PageInfo> pages;

  const Query({
    required this.pages
  });

  factory Query.fromJson(Map<String, dynamic> json) {
    return Query(
        pages: json['pages'].map<PageInfo>((json) => PageInfo.fromJson(json)).toList()
    );
  }
}

class PageInfo {
  final String title;
  final String description;

  const PageInfo({
    required this.title,
    required this.description,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) {
    return PageInfo(
        title: json['title'],
        description: json['description']
    );
  }
}
