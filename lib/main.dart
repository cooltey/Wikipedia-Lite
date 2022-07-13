import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wikipedia_lite/feed.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wikipedia Lite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Wikipedia Lite'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late Future<String> futureFeaturedImageUrl;

  @override
  void initState() {
    super.initState();
    futureFeaturedImageUrl = fetchFeaturedImageUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder<String>(
            future: futureFeaturedImageUrl,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String? featuredImageUrl = snapshot.data;
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(featuredImageUrl ?? ""),
                        fit: BoxFit.cover,
                      )
                  ),
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
                        child: Text(
                          "Welcome to Wikipedia Lite",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: IconButton(
                                onPressed: showSearchResults,
                                icon: const Icon(Icons.arrow_forward_outlined)
                              ),
                              border: const OutlineInputBorder(),
                              hintText: 'Search Wikipedia',
                            ),
                          )
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                      child: Text(
                        snapshot.error.toString(),
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    )
                  ],
                );
              }
              return const LinearProgressIndicator();
            }),
    );
  }

  Future<String> fetchFeaturedImageUrl() async {
    DateTime now = DateTime.now();
    final response = await http.get(Uri.parse('https://en.wikipedia.org/api/rest_v1/feed/featured/${now.year}/${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')}'));
    if (response.statusCode == 200) {
      final feed = Feed.fromJson(jsonDecode(response.body));
      return feed.image.thumbnail.source;
    } else {
      throw Exception('Cannot fetch featured image URL');
    }
  }

  void showSearchResults() {
    setState(() {
      // TODO: //
    });
  }
}
