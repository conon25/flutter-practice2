import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AddressSearchWebView extends StatefulWidget {
  const AddressSearchWebView({Key? key}) : super(key: key);

  @override
  State<AddressSearchWebView> createState() => _AddressSearchWebViewState();
}

class _AddressSearchWebViewState extends State<AddressSearchWebView> {
  final InAppLocalhostServer _localhostServer = InAppLocalhostServer();
  late InAppWebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _localhostServer.start();
  }

  @override
  void dispose() {
    _localhostServer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("주소 검색")),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri("http://localhost:8080/assets/html/daum_postcode.html"),
        ),
        onWebViewCreated: (controller) {
          _webViewController = controller;
          controller.addJavaScriptHandler(
            handlerName: "onSelectAddress",
            callback: (args) {
              if (args.isNotEmpty && args[0] is Map) {
                Navigator.pop(context, args[0]['address']);
              }
            },
          );
        },
      ),
    );
  }
}
