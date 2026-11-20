import 'package:flutter/material.dart';
import '../../../models/element_data.dart';
import '../../periodic_table/widgets/element_tile.dart';

class DetailPage extends StatelessWidget {
  const DetailPage(this.element, {super.key});

  final ElementData element;

  @override
  Widget build(BuildContext context) {
    final listItems = <Widget>[
      ListTile(
        leading: const Icon(Icons.category_outlined),
        title: Text(element.category.toUpperCase()),
      ),
      ListTile(
        leading: const Icon(Icons.info_outline),
        title: Text(element.extract),
        subtitle: SelectableText(element.source),
      ),
      ListTile(
        leading: const Icon(Icons.numbers_outlined),
        title: Text(element.atomicWeight),
        subtitle: const Text('Atomic Weight'),
      ),
    ];

    return Scaffold(
      backgroundColor: Color.lerp(Colors.grey[850], element.primaryColor, 0.07),
      appBar: AppBar(
        backgroundColor:
            Color.lerp(Colors.grey[850], element.secondaryColor, 0.2),
        surfaceTintColor: Colors.transparent,
        bottom: ElementTile(element, isLarge: true),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 24.0),
            itemCount: listItems.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (_, index) => listItems[index],
          ),
        ),
      ),
    );
  }
}
