import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  static late double leftPadding;
  static late double topPadding;
  static late double rightPadding;
  static late double bottomPadding;

  static init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    leftPadding = _mediaQueryData.padding.left;
    topPadding = _mediaQueryData.padding.top;
    rightPadding = _mediaQueryData.padding.right;
    bottomPadding = _mediaQueryData.padding.bottom;

    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}

class Gaps {
  static const h4 = const SizedBox(width: 4.0);
  static const h8 = const SizedBox(width: 8.0);
  static const h12 = const SizedBox(width: 12.0);
  static const h18 = const SizedBox(width: 18.0);
  static const h24 = const SizedBox(width: 24.0);

  static const v4 = const SizedBox(height: 4.0);
  static const v8 = const SizedBox(height: 8.0);
  static const v12 = const SizedBox(height: 12.0);
  static const v18 = const SizedBox(height: 18.0);
  static const v24 = const SizedBox(height: 24.0);
  static const v36 = const SizedBox(height: 36.0);
  static const v96 = const SizedBox(height: 96.0);
}
