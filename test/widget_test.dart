import 'package:flutter_test/flutter_test.dart';
import 'package:Elements/main.dart';

void main() {
  testWidgets('Elements app smoke test and detail navigation',
      (WidgetTester tester) async {
    final sampleElement = ElementData.fromJson({
      'number': 1,
      'name': 'Hydrogen',
      'symbol': 'H',
      'extract':
          'Hydrogen is the chemical element with the symbol H and atomic number 1.',
      'source': 'https://en.wikipedia.org/wiki/Hydrogen',
      'atomic_weight': '1.008',
      'category': 'Reactive Nonmetal',
      'colors': [0xFF536DFE, 0xFF8E99F3],
    });

    final mockGridList = Future.value(<ElementData?>[sampleElement, null]);

    await tester.pumpWidget(ElementsApp(mockGridList));
    await tester.pumpAndSettle();

    expect(find.text('Elements'), findsOneWidget);
    expect(find.text('H'), findsOneWidget);
    expect(find.text('Hydrogen'), findsOneWidget);

    await tester.tap(find.text('H'));
    await tester.pumpAndSettle();

    expect(find.text('REACTIVE NONMETAL'), findsOneWidget);
    expect(find.text('1.008'), findsOneWidget);
    expect(find.text('Atomic Weight'), findsOneWidget);
  });
}
