import 'package:flutter/widgets.dart';

abstract final class AppConstants {
  static const int rowCount = 10;
  static const int colCount = 18;

  static const double contentSize = 64.0;
  static const double gutterWidth = 2.0;

  static const EdgeInsets gutterInset = EdgeInsets.all(gutterWidth);

  /// Dimensions for the periodic table grid (18 columns x 10 rows).
  /// Each cell width and height is contentSize + (gutterWidth * 2) = 68.0.
  static const double cellDimension = contentSize + (gutterWidth * 2);
  static const double baseTableWidth = colCount * cellDimension; // 1224.0
  static const double baseTableHeight = rowCount * cellDimension; // 680.0
  static const double tableAspectRatio =
      baseTableWidth / baseTableHeight; // 1.8

  /// Maximum extent for resizability before clamping in fullscreen.
  static const double maxTableWidth = 1620.0;
  static const double maxTableHeight = 900.0;

  /// Minimum desktop window dimensions (including titlebar / app chrome).
  static const double minDesktopWindowWidth = 1240.0;
  static const double minDesktopWindowHeight = 760.0;

  static const String elementsGridJsonAsset = 'assets/elementsGrid.json';
  static const String fontRobotoCondensed = 'Roboto Condensed';
  static const String fontShareTechMono = 'Share Tech Mono';
}
