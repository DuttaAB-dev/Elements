import 'package:flutter/widgets.dart';

@immutable
class ElementData {
  const ElementData({
    required this.number,
    required this.name,
    required this.symbol,
    required this.category,
    required this.extract,
    required this.source,
    required this.atomicWeight,
    required this.colors,
  });

  factory ElementData.fromJson(Map<String, dynamic> json) {
    return ElementData(
      number: json['number'] as int,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      category: json['category'] as String,
      extract: json['extract'] as String,
      source: json['source'] as String,
      atomicWeight: json['atomic_weight'] as String,
      colors: (json['colors'] as List)
          .map((value) => Color(value as int))
          .toList(growable: false),
    );
  }

  final int number;
  final String name;
  final String symbol;
  final String category;
  final String extract;
  final String source;
  final String atomicWeight;
  final List<Color> colors;

  Color get primaryColor =>
      colors.isNotEmpty ? colors.first : const Color(0xFF536DFE);

  Color get secondaryColor => colors.length > 1 ? colors[1] : primaryColor;

  Color get accentColor =>
      Color.lerp(primaryColor, secondaryColor, 0.5) ?? primaryColor;

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'symbol': symbol,
      'category': category,
      'extract': extract,
      'source': source,
      'atomic_weight': atomicWeight,
      'colors': colors.map((c) => c.toARGB32()).toList(growable: false),
    };
  }
}
