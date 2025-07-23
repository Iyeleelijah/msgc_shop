import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MsgcApp());
}

class MsgcApp extends StatelessWidget {
  const MsgcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MSGC SHOP',
      theme: ThemeData(
        cupertinoOverrideTheme: const CupertinoThemeData(
          primaryColor: CupertinoColors.activeBlue,
        ),
      ),
      home: const MsgcWebView(),
    );
  }
}

class MsgcWebView extends StatefulWidget {
  const MsgcWebView({super.key});

  @override
  State<MsgcWebView> createState() => _MsgcWebViewState();
}

class _MsgcWebViewState extends State<MsgcWebView> {
  late final WebViewController _controller;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFFFFFFF))
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (_) => setState(() => _loading = true),
        onPageFinished: (_) => setState(() => _loading = false),
      ))
      ..loadRequest(Uri.parse('https://msgc.shop'));
  }

  Future<void> _refreshPage() async {
    _controller.reload();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('MSG C Shop'),
        backgroundColor: CupertinoColors.systemGrey6,
      ),
      child: SafeArea(
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: _refreshPage,
              child: WebViewWidget(controller: _controller),
            ),
            if (_loading)
              const Center(child: CupertinoActivityIndicator(radius: 15)),
          ],
        ),
      ),
    );
  }
}
