import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ReadArticle(),
    ),
  );
}

class ReadArticle extends StatefulWidget {
  const ReadArticle({Key? key}) : super(key: key);

  @override
  State<ReadArticle> createState() => _ReadArticleState();
}

class _ReadArticleState extends State<ReadArticle> {

  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView'),
      ),
      body: Center(
        child: WebView(
          initialUrl: 'https://www.google.com/',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
          },
        ),
      ),
    );
  }
}
