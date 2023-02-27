import 'package:flutter/material.dart';

class MediaQuerySingleton {
  static late Size screenSize;

  static init(Size screen) {
    screenSize = screen;
  }

  Size getScreenSize() {
    return screenSize;
  }
}
