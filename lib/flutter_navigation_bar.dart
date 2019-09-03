import 'dart:async';

import "package:flutter/services.dart";
import 'package:flutter/material.dart';

class FlutterNavigationBar {
  static const MethodChannel _channel =
      const MethodChannel('flutter_navigation_bar');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Null> setNavigationBarTransparent() async {
    await _channel.invokeMethod('setNavigationBarTransparent');
    return null;
  }

}
