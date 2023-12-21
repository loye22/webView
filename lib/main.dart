import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    dynamic controller = WebViewController()
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
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.quora.com/How-can-you-test-an-iOS-app-without-using-TestFlight')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.quora.com/How-can-you-test-an-iOS-app-without-using-TestFlight')
      );


    Future<bool> _goBack(BuildContext context) async {
      if (await controller.canGoBack()) {
        controller.goBack();
        return Future.value(false);
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Do you want to exit'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    // SystemNavigator.pop();
                  },
                  child: Text('Yes'),
                ),
              ],
            ));
        return Future.value(true);
      }}


    return  MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: WillPopScope( onWillPop: () => _goBack(context),

              child: WebViewWidget(
        
        
                  controller: controller))
          ,
        ),
      ),
    );




  }

}
