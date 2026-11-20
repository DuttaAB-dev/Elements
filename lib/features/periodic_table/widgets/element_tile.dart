import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../models/element_data.dart';
import '../../element_details/screens/detail_page.dart';

class ElementTile extends StatelessWidget implements PreferredSizeWidget {
  const ElementTile(
    this.element, {
    super.key,
    this.isLarge = false,
  });

  final ElementData element;
  final bool isLarge;

  @override
  Size get preferredSize =>
      const Size.fromHeight(AppConstants.contentSize * 1.5);

  @override
  Widget build(BuildContext context) {
    final primaryColor = element.primaryColor;
    final secondaryColor = element.secondaryColor;
    final textColor = element.accentColor;

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
      margin: AppConstants.gutterInset,
      width: AppConstants.contentSize,
      height: AppConstants.contentSize,
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
