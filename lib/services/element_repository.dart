import 'dart:convert';
import 'package:flutter/services.dart';
import '../core/constants/app_constants.dart';
import '../models/element_data.dart';

abstract interface class ElementRepository {
  Future<List<ElementData?>> loadElementsGrid();
}

class AssetElementRepository implements ElementRepository {
  const AssetElementRepository({
    this.assetBundle,
    this.assetPath = AppConstants.elementsGridJsonAsset,
  });

  final AssetBundle? assetBundle;
  final String assetPath;

  @override
  Future<List<ElementData?>> loadElementsGrid() async {
    final bundle = assetBundle ?? rootBundle;
    final jsonString = await bundle.loadString(assetPath);
    final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
    final rawList = jsonMap['elements'] as List<dynamic>;

    return rawList
        .map((json) => json != null
            ? ElementData.fromJson(json as Map<String, dynamic>)
            : null)
        .toList(growable: false);
  }
}
