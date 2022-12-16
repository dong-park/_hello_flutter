import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  WebViewController? controller;

  WebViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('WebView'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              controller!.canGoBack().then((value) {
                if (value) {
                  controller!.goBack();
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              controller!.canGoForward().then((value) {
                if (value) {
                  controller!.goForward();
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              controller!.reload();
            },
          ),
        ],
      ),

      body: WebView(
        onWebViewCreated: (WebViewController controller) {
          this.controller = controller;
          this.controller!.loadUrl('https://dongpark.land');
        },
        // initialUrl: 'https://dongpark.land',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
