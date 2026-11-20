import 'dart:convert';

// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kRowCount = 10;
const kContentSize = 64.0;
const kGutterWidth = 2.0;
const kGutterInset = EdgeInsets.all(kGutterWidth);

const Widget _kEmptyTile = Padding(
  padding: kGutterInset,
  child: ColoredBox(color: Color(0xFF424242)),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final gridList = rootBundle
      .loadString('assets/elementsGrid.json')
      .then((source) => jsonDecode(source)['elements'] as List)
      .then((list) => list
          .map((json) => json != null ? ElementData.fromJson(json) : null)
          .toList());

  runApp(ElementsApp(gridList));
}

class ElementData {
  const ElementData({
    required this.name,
    required this.category,
    required this.symbol,
    required this.extract,
    required this.source,
    required this.atomicWeight,
    required this.number,
    required this.colors,
  });

  ElementData.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        category = json['category'] as String,
        symbol = json['symbol'] as String,
        extract = json['extract'] as String,
        source = json['source'] as String,
        atomicWeight = json['atomic_weight'] as String,
        number = json['number'] as int,
        colors = (json['colors'] as List)
            .map((value) => Color(value as int))
            .toList(growable: false);

  final String name, category, symbol, extract, source, atomicWeight;
  final int number;
  final List<Color> colors;
}

class ElementsApp extends StatelessWidget {
  const ElementsApp(this.gridList, {super.key});

  final Future<List<ElementData?>> gridList;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: Colors.black87,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF424242),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      textTheme:
          Typography.whiteMountainView.apply(fontFamily: 'Roboto Condensed'),
      primaryTextTheme:
          Typography.whiteMountainView.apply(fontFamily: 'Share Tech Mono'),
    );

    return MaterialApp(
      title: 'Elements',
      theme: theme,
      home: TablePage(gridList),
    );
  }
}

class TablePage extends StatelessWidget {
  const TablePage(this.gridList, {super.key});

  final Future<List<ElementData?>> gridList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elements'),
      ),
      body: FutureBuilder<List<ElementData?>>(
        future: gridList,
        builder: (_, snapshot) => snapshot.hasData
            ? _buildTable(snapshot.data!)
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildTable(List<ElementData?> elements) {
    return SingleChildScrollView(
      child: SizedBox(
        height: kRowCount * (kContentSize + (kGutterWidth * 2)),
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: elements.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: kRowCount,
          ),
          itemBuilder: (context, index) {
            final element = elements[index];
            if (element != null) {
              return ElementTile(element);
            }
            return _kEmptyTile;
          },
        ),
      ),
    );
  }
}

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
      backgroundColor: Color.lerp(Colors.grey[850], element.colors[0], 0.07),
      appBar: AppBar(
        backgroundColor: Color.lerp(Colors.grey[850], element.colors[1], 0.2),
        surfaceTintColor: Colors.transparent,
        bottom: ElementTile(element, isLarge: true),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 700,
          ),
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

class ElementTile extends StatelessWidget implements PreferredSizeWidget {
  const ElementTile(this.element, {super.key, this.isLarge = false});

  final ElementData element;
  final bool isLarge;

  @override
  Size get preferredSize => const Size.fromHeight(kContentSize * 1.5);

  @override
  Widget build(BuildContext context) {
    final primaryColor = element.colors[0];
    final secondaryColor = element.colors[1];
    final textColor = Color.lerp(primaryColor, secondaryColor, 0.5)!;

    final tileText = <Widget>[
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          '${element.number}',
          style: TextStyle(fontSize: 10.0, color: primaryColor),
        ),
      ),
      Text(
        element.symbol,
        style: Theme.of(context)
            .primaryTextTheme
            .titleMedium
            ?.copyWith(color: textColor, fontWeight: FontWeight.bold),
      ),
      Text(
        element.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textScaler: TextScaler.linear(isLarge ? 0.65 : 1),
        style: TextStyle(color: secondaryColor),
      ),
    ];

    final tile = Container(
      margin: kGutterInset,
      width: kContentSize,
      height: kContentSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.lerp(Colors.black, primaryColor, 0.26)!,
            Color.lerp(Colors.black, secondaryColor, 0.26)!,
          ],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4.0),
          onTap: !isLarge
              ? () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(element),
                    ),
                  )
              : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: tileText,
            ),
          ),
        ),
      ),
    );

    final heroTile = isLarge ? Transform.scale(scale: 1.75, child: tile) : tile;

    return Hero(
      tag: 'hero-${element.symbol}',
      flightShuttleBuilder: (_, anim, __, ___, ____) => ScaleTransition(
        scale: anim.drive(Tween(begin: 1, end: 1.75)),
        child: tile,
      ),
      child: heroTile,
    );
  }
}
