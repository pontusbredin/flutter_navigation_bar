//import 'package:flutter/material.dart';
//import 'dart:async';
//
//import 'package:flutter/services.dart';
//import 'package:flutter_navigation_bar/flutter_navigation_bar.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatefulWidget {
//  @override
//  _MyAppState createState() => _MyAppState();
//}
//
//class _MyAppState extends State<MyApp> {
//
//  @override
//  void initState() {
//    super.initState();
//    NavigationBarInfoSingleton(set_to_this: this);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Scaffold(
//        appBar: AppBar(
//          title: const Text('Plugin example app'),
//        ),
//        body: Center(
//          child: Text('Running on: \n'),
//        ),
//      ),
//    );
//  }
//}


import 'dart:async';

//import 'dart:html';
import 'dart:io';
import 'dart:math';
//import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_navigation_bar/flutter_navigation_bar.dart';
//import 'package:keyboard_visibility/keyboard_visibility.dart';

//import 'custom_layout.dart';

//import 'appbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController;
  ScrollController _dateTimeController;
//  KeyboardVisibilityNotification _keyboardVisibilityNotification;

  bool dateTimeExpanded = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<FocusNode> _focusNodes;

//  SystemBarsInfo _systemBarInfo = SystemBarsInfo(false, 0.0, 0.0, 0.0, 0.0);

//  int doChange(SystemBarsInfo systemBarsInfo) {
////    print(systemBarsInfo);
//    _systemBarInfo = systemBarsInfo;
////    FlutterSystemBars.setNoLimits;
//    setState(() {
//    });
//    return 0;
//  }

  @override
  void initState() {
    super.initState();

    FlutterNavigationBar(set_to_this: this);

    _focusNodes = List.generate(6, (index) {
//      FocusNode result = FocusNode();
//      result.addListener(() {
//        if (result.hasFocus) {
////          FlutterSystemBars.setLimits;
//        }
//      });
//      return result;
      return null;
    });

    _scrollController = ScrollController();
    _dateTimeController = ScrollController();

    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;

//    SystemChrome.setSystemUIOverlayStyle(
//      SystemUiOverlayStyle(
////        statusBarColor: Colors.transparent,
////        statusBarColor: Colors.blue.shade700,
////        statusBarIconBrightness: Brightness.dark,
//        statusBarBrightness: Brightness.dark,
//        statusBarIconBrightness: Brightness.light,
////        statusBarBrightness: Brightness.light,
////        systemNavigationBarColor: Colors.blue.shade700,
////        systemNavigationBarColor: Colors.transparent,
//        systemNavigationBarIconBrightness: Brightness.light,
////        systemNavigationBarIconBrightness: Brightness.dark,
//      ),
//    );

  }

  @override
  dispose() {
    _scrollController.dispose();
    _dateTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          top: 0,
          left: 0,
          child: Scaffold(
            extendBody: false,
//      bottomNavigationBar: Container(
//        color: Colors.blue.withAlpha(50),
//        height: 48,
//        width: 10,
//      ),
            body: CupertinoPageScaffold(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  SliverPersistentHeader(
                    delegate: MySliverAppBar(expandedHeight: MediaQuery.of(context).size.height / 2 + MediaQuery.of(context).padding.top),
//              delegate: MySliverAppBar(expandedHeight: _screenHeight / 2),
                    pinned: true,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      SafeArea(
                        top: false,
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: SafeArea(
                              top: false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  const SizedBox(height: 24.0),
                                  TextFormField(
                                    focusNode: _focusNodes[0],
                                    cursorColor: Colors.red,
                                    textCapitalization: TextCapitalization.words,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      filled: true,
                                      icon: Icon(Icons.person),
                                      hintText: 'What do people call you?',
                                      labelText: 'Name *',
                                    ),
                                  ),
                                  const SizedBox(height: 24.0),
                                  TextFormField(
                                    focusNode: _focusNodes[1],
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      filled: true,
                                      icon: Icon(Icons.phone),
                                      hintText: 'Where can we reach you?',
                                      labelText: 'Phone Number *',
                                      prefixText: '+1',
                                    ),
                                    keyboardType: TextInputType.phone,
                                  ),
                                  const SizedBox(height: 24.0),
                                  TextFormField(
                                    focusNode: _focusNodes[2],
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      filled: true,
                                      icon: Icon(Icons.email),
                                      hintText: 'Your email address',
                                      labelText: 'E-mail',
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: 24.0),
                                  TextFormField(
                                    focusNode: _focusNodes[3],
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Tell us about yourself (e.g., write down what you do or what hobbies you have)',
                                      helperText: 'Keep it short, this is just a demo.',
                                      labelText: 'Life story',
                                    ),
                                    maxLines: 3,
                                  ),
                                  const SizedBox(height: 24.0),
                                  TextFormField(
                                    focusNode: _focusNodes[4],
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Salary',
                                      prefixText: '\$',
                                      suffixText: 'USD',
                                      suffixStyle: TextStyle(color: Colors.green),
                                    ),
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: 24.0),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      filled: true,
                                      labelText: 'Re-type password',
                                    ),
                                    maxLength: 8,
                                    obscureText: true,
                                  ),
                                  const SizedBox(height: 24.0),
                                  Center(
                                    child: RaisedButton(
                                      child: const Text('Subscribe'),
                                      onPressed: () {
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 24.0),
                                  Center(
                                    child: RaisedButton(
                                      child: const Text('SUBMIT'),
                                      onPressed: () {
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 24.0),
                                  Text(FlutterNavigationBar().navigationBarHeight.toString(),
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  const SizedBox(height: 24.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  SliverFillRemaining(
                    fillOverscroll: false,
                    hasScrollBody: true,
                  ),
                ],
              ),
            ),
          ),
        ),
        /// Paint the insets
        Positioned(
          bottom: 0,
          width: MediaQuery.of(context).size.width,
          height: FlutterNavigationBar().navigationBarHeight,
          child: IgnorePointer(
            child: Container(
              color: Colors.red.withAlpha(50),
            ),
          ),
        ),
        Positioned(
          top: 0,
          width: MediaQuery.of(context).size.width,
          height: FlutterNavigationBar().statusBarHeight,
          child: IgnorePointer(
            child: Container(
              color: Colors.lightGreenAccent.withAlpha(50),
            ),
          ),
        ),
        Positioned(
          top: FlutterNavigationBar().statusBarHeight,
          right: 0,
          width: FlutterNavigationBar().navigationBarWidthRight,
          height: MediaQuery.of(context).size.height-FlutterNavigationBar().navigationBarHeight-FlutterNavigationBar().statusBarHeight,
          child: IgnorePointer(
            child: Container(
              color: Colors.green.withAlpha(50),
            ),
          ),
        ),
        Positioned(
          top: FlutterNavigationBar().statusBarHeight,
          left: 0,
          width: FlutterNavigationBar().navigationBarWidthLeft,
          height: MediaQuery.of(context).size.height-FlutterNavigationBar().navigationBarHeight-FlutterNavigationBar().statusBarHeight,
          child: IgnorePointer(
            child: Container(
              color: Colors.blue.withAlpha(050),
            ),
          ),
        ),
      ],
    );
  }
}

/// Class to make a SliverAppBar that doesn't take up to much space
class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  double getOpacity(BuildContext context, double shrinkOffset) {
    double _result = 1.0;
    if ((MediaQuery.of(context).padding.top) != 0) {
      _result = max(
        min(expandedHeight - shrinkOffset - (MediaQuery.of(context).padding.top) * 1.5, (MediaQuery.of(context).padding.top)) /
            (MediaQuery.of(context).padding.top),
        0,
      );
    } else {
      _result = max(
        min(expandedHeight - shrinkOffset - Theme.of(context).primaryTextTheme.title.fontSize, Theme.of(context).primaryTextTheme.title.fontSize) /
            Theme.of(context).primaryTextTheme.title.fontSize,
        0,
      );
    }
    return _result;
  }

  int getShadowOpacity(BuildContext context, double shrinkOffset) {
    double _result = 1.0;
    if ((MediaQuery.of(context).padding.top) != 0) {
      _result = max(
          min(expandedHeight - shrinkOffset - (MediaQuery.of(context).padding.top) / 3, (MediaQuery.of(context).padding.top)) /
              (MediaQuery.of(context).padding.top),
          0);
    } else {
      _result = 1.0;
    }
    return ((1 - _result) * 255).round();
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Container(
          height: ((expandedHeight - shrinkOffset + 0) > (MediaQuery.of(context).padding.top))
              ? (expandedHeight - shrinkOffset + 0)
              : (MediaQuery.of(context).padding.top),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(getShadowOpacity(context, shrinkOffset)),
                blurRadius: 8.0,
                spreadRadius: 20.0,
                offset: Offset(
                  0.0,
                  -20.0,
                ),
              ),
            ],
            gradient: LinearGradient(
              colors: <Color>[
                Theme.of(context).brightness == Brightness.light ? Color(0xFF005090) : Color(0xFF003070),
                Theme.of(context).brightness == Brightness.light ? Color(0xFF5070F0) : Color(0xFF3050D0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Opacity(
            opacity: getOpacity(context, shrinkOffset),
            child: SafeArea(
              top: false,
              bottom: false,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FittedBox(
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey,
                        ),
                        onPressed: () {
                          ///Enable equal width to the two sides in landscape
                          ///Doesn't really work that well with the soft keyboard
                          FlutterNavigationBar().equalSides = true;
                        },
                      ),
                    ),
                    Text(
                      'Title',
                      style: TextStyle(
                        fontSize: Theme.of(context).primaryTextTheme.title.fontSize,
                        fontWeight: FontWeight.normal,
                        fontFamily: Theme.of(context).primaryTextTheme.title.fontFamily,
                        color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey.shade300,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    FittedBox(
                      child: IconButton(
                        icon: const Icon(
                          Icons.save_alt,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          ///Disable equal width to the two sides in landscape
                          FlutterNavigationBar().equalSides = false;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
