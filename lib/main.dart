import 'package:flutter/material.dart';

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

  void showSearchResults() {
    setState(() {
      // TODO: //
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: Text(
                "Welcome to Wikipedia Lite",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                      onPressed: showSearchResults(),
                      icon: Icon(Icons.arrow_forward_outlined),
                      color: Colors.blueAccent,
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'Search Wikipedia',
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
