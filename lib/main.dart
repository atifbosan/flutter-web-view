import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  goBack() async {
    if (await _controller.canGoBack()) {
      await _controller.goBack();
    }
  }

  goForward() async {
    if (await _controller.canGoForward()) {
      await _controller.goForward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      // appBar: AppBar(
      //   title: const Text('Flutter WebView example'),
      //   actions: [
      //     IconButton(onPressed: goBack, icon: Icon(Icons.arrow_back_ios)),
      //     IconButton(onPressed: goForward, icon: Icon(Icons.arrow_forward_ios)),
      //   ],
      // ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 25,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: goBack, icon: Icon(Icons.arrow_back_ios)),
                  IconButton(
                      onPressed: goForward,
                      icon: Icon(Icons.arrow_forward_ios)),
                ],
              ),
              // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: 'https://www.youtube.com/',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
          },
          // backgroundColor: const Color(0x00000000),
        ),
      ),
    );
  }
}
