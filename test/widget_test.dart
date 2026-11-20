import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Elements/main.dart';

class MockElementRepository implements ElementRepository {
  const MockElementRepository(this.elements);

  final List<ElementData?> elements;

  @override
  Future<List<ElementData?>> loadElementsGrid() async => elements;
}

void main() {
  const sampleElement = ElementData(
    number: 1,
    name: 'Hydrogen',
    symbol: 'H',
    extract:
        'Hydrogen is the chemical element with the symbol H and atomic number 1.',
    source: 'https://en.wikipedia.org/wiki/Hydrogen',
    atomicWeight: '1.008',
    category: 'Reactive Nonmetal',
    colors: [Color(0xFF536DFE), Color(0xFF8E99F3)],
  );

  testWidgets('Elements app smoke test and detail navigation',
      (WidgetTester tester) async {
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

  testWidgets('Elements app supports repository injection',
      (WidgetTester tester) async {
    const mockRepo = MockElementRepository([sampleElement]);

    await tester.pumpWidget(
      const ElementsApp.withRepository(repository: mockRepo),
    );
    await tester.pumpAndSettle();

    expect(find.text('Elements'), findsOneWidget);
    expect(find.text('H'), findsOneWidget);
  });

  testWidgets('Elements table is centered and scales on desktop viewports',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    const mockRepo = MockElementRepository([sampleElement]);

    await tester.pumpWidget(
      const ElementsApp.withRepository(repository: mockRepo),
    );
    await tester.pumpAndSettle();

    expect(find.text('Elements'), findsOneWidget);
    expect(find.byType(FittedBox), findsOneWidget);
    expect(find.byType(Center), findsWidgets);
  });

  testWidgets('Elements table handles small/mobile viewports with scrolling',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    const mockRepo = MockElementRepository([sampleElement]);

    await tester.pumpWidget(
      const ElementsApp.withRepository(repository: mockRepo),
    );
    await tester.pumpAndSettle();

    expect(find.text('Elements'), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsWidgets);
  });
}
