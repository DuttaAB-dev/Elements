import 'package:flutter/widgets.dart';

abstract final class AppConstants {
  static const int rowCount = 10;
  static const int colCount = 18;

  static const double contentSize = 64.0;
  static const double gutterWidth = 2.0;

  static const EdgeInsets gutterInset = EdgeInsets.all(gutterWidth);

  static const String elementsGridJsonAsset = 'assets/elementsGrid.json';
  static const String fontRobotoCondensed = 'Roboto Condensed';
  static const String fontShareTechMono = 'Share Tech Mono';
}
