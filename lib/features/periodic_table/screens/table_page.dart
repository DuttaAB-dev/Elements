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
            return _buildTable(context, snapshot.data!);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildTable(BuildContext context, List<ElementData?> elements) {
    const baseWidth = AppConstants.baseTableWidth;
    const baseHeight = AppConstants.baseTableHeight;

    final gridWidget = SizedBox(
      width: baseWidth,
      height: baseHeight,
      child: GridView.builder(
        physics: const ClampingScrollPhysics(),
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
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final availableHeight = constraints.maxHeight;

        // If the viewport is at least as large as the base periodic table,
        // center the table and scale it up to the maximum extent.
        final fitsInViewport =
            availableWidth >= baseWidth && availableHeight >= baseHeight;

        if (fitsInViewport) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppConstants.maxTableWidth,
                maxHeight: AppConstants.maxTableHeight,
              ),
              child: AspectRatio(
                aspectRatio: AppConstants.tableAspectRatio,
                child: FittedBox(
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  child: gridWidget,
                ),
              ),
            ),
          );
        }

        // On smaller screens or compact viewports, ensure content is scrollable
        // and centered along any axis that fits without clipping or overlap.
        return Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: gridWidget,
            ),
          ),
        );
      },
    );
  }
}
