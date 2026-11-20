import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../models/element_data.dart';
import '../../../services/element_repository.dart';
import '../widgets/element_tile.dart';
import '../widgets/empty_tile.dart';

class TablePage extends StatefulWidget {
  const TablePage([
    this.elementsFuture,
    Key? key,
  ])  : repository = const AssetElementRepository(),
        super(key: key);

  const TablePage.withRepository({
    required this.repository,
    this.elementsFuture,
    super.key,
  });

  final ElementRepository repository;
  final Future<List<ElementData?>>? elementsFuture;

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  late final Future<List<ElementData?>> _elementsFuture;

  @override
  void initState() {
    super.initState();
    _elementsFuture =
        widget.elementsFuture ?? widget.repository.loadElementsGrid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elements'),
      ),
      body: FutureBuilder<List<ElementData?>>(
        future: _elementsFuture,
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading periodic table: ${snapshot.error}',
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          }
          if (snapshot.hasData) {
            return _buildTable(snapshot.data!);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildTable(List<ElementData?> elements) {
    const totalHeight = AppConstants.rowCount *
        (AppConstants.contentSize + (AppConstants.gutterWidth * 2));

    return SingleChildScrollView(
      child: SizedBox(
        height: totalHeight,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: elements.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: AppConstants.rowCount,
          ),
          itemBuilder: (context, index) {
            final element = elements[index];
            if (element != null) {
              return ElementTile(element);
            }
            return const EmptyTile();
          },
        ),
      ),
    );
  }
}
