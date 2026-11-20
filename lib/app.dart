import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/periodic_table/screens/table_page.dart';
import 'models/element_data.dart';
import 'services/element_repository.dart';

class ElementsApp extends StatelessWidget {
  const ElementsApp([
    this.gridList,
    Key? key,
  ])  : repository = const AssetElementRepository(),
        super(key: key);

  const ElementsApp.withRepository({
    required this.repository,
    this.gridList,
    super.key,
  });

  final Future<List<ElementData?>>? gridList;
  final ElementRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elements',
      theme: AppTheme.darkTheme,
      home: TablePage.withRepository(
        repository: repository,
        elementsFuture: gridList,
      ),
    );
  }
}
