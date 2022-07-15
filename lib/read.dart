import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ReadArticle(pageTitle: ""),
    ),
  );
}

class ReadArticle extends StatefulWidget {
  final String pageTitle;
  const ReadArticle({Key? key, required this.pageTitle}) : super(key: key);
  @override
  State<ReadArticle> createState() => _ReadArticleState();
}

class _ReadArticleState extends State<ReadArticle> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          var canGoBack = await _controller.canGoBack();
          if(canGoBack){
            _controller.goBack();
            return false;
          }else{
            return true;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.pageTitle),
          ),
          body: Center(
            child: WebView(
              initialUrl: 'https://en.m.wikipedia.org/wiki/${widget.pageTitle}',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
              },
            ),
          ),
        ),
    );
  }
}
