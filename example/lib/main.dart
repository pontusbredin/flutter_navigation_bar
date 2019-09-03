import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_navigation_bar/flutter_navigation_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
//      await FlutterNavigationBar.setNavigationBarTransparent();

      platformVersion = await FlutterNavigationBar.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }


    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,//bgBlue, // Background color for status bar
        statusBarBrightness: Brightness.dark, // Dark == white status bar.
//        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarColor: Color(0xFF986ECA),
      ),
    );

    FlutterNavigationBar.setNavigationBarTransparent();

    return MaterialApp(
      home: Scaffold(
//        extendBody: true,
        primary: true,
        backgroundColor: Color(0xFF186ECA),
//        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
        bottomNavigationBar: Text('Hello'),
      ),
    );
  }
}
