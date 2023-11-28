import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late final WebViewController controller;

  @override
  void initState() {
    // controller = WebViewController()
    //   ..loadRequest(Uri.parse('https://www.linkedin.com/in/shubham-bane/'));
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse('https://www.linkedin.com/in/shubham-bane'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.greenAccent,
      child: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
