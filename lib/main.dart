import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wikipedia_lite/data/feed.dart';
import 'package:wikipedia_lite/data/search.dart';
import 'package:wikipedia_lite/read.dart';

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
        primarySwatch: Colors.blueGrey,
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

  final searchFieldController = TextEditingController();
  late Future<String> futureFeaturedImageUrl;
  List<PageInfo> searchResults = List.empty(growable: true);

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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
                        child: Text(
                          "Welcome to Wikipedia Lite",
                          style: TextStyle(
                            fontSize: 20,
                            background: Paint()..color = const Color(0xE6FFFFFF)
                              ..strokeWidth = 25
                              ..style = PaintingStyle.stroke,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: TextField(
                            controller: searchFieldController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                    showSearchResult(searchFieldController.text);
                                  },
                                icon: const Icon(Icons.arrow_forward_outlined)
                              ),
                              border: const OutlineInputBorder(),
                              fillColor: const Color(0xE6FFFFFF),
                              filled: true,
                              hintText: 'Search Wikipedia',
                            ),
                          )
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                          itemCount: searchResults.length,
                          itemBuilder: (BuildContext context, int index) {
                            PageInfo pageInfo = searchResults[index];
                            return Container(
                              decoration: const BoxDecoration (
                                  color: Color(0xE6FFFFFF)
                              ),
                              child: ListTile(
                                title: Text(pageInfo.title),
                                subtitle: Text(pageInfo.title),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ReadArticle(pageTitle: pageInfo.title)),
                                ),
                              )
                            );
                          },
                        )
                      ),
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
      return feed.image.thumbnail.source.replaceAll('640px', '1080px');
    } else {
      throw Exception('Cannot fetch featured image URL');
    }
  }

  void showSearchResult(String query) async {
    final response = await http.get(Uri.parse('https://en.wikipedia.org/w/api.php?format=json&'
        'formatversion=2&errorformat=html&errorsuselocal=1&action=query&redirects=&converttitles=&'
        'prop=description|info&generator=prefixsearch&gpsnamespace=0&list=search&srnamespace=0&'
        'inprop=varianttitles&srwhat=text&srinfo=suggestion&srprop=&sroffset=0&srlimit=1&'
        'gpssearch=$query&gpslimit=100&gpsoffset=1&srsearch=$query'));
    if (response.statusCode == 200) {
      final search = Search.fromJson(jsonDecode(response.body));
      setState(() {
        searchResults.clear();
        searchResults.addAll(search.query.pages);
      });
    } else {
      throw Exception('Cannot prefix search URL');
    }
  }
}
