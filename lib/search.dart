import 'package:json_annotation/json_annotation.dart';

class Search {
  @JsonKey(name: 'continue')
  final Continue continueStr;

  const Search({
    required this.continueStr
  });

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(continueStr: Continue.fromJson(json['continue']));
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
