import 'package:flutter_test/flutter_test.dart';

import 'package:lista_de_tarefas/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Flutter App'), findsOneWidget);
    expect(find.text('Bem-vindo ao seu novo app Flutter!'), findsOneWidget);
  });
}
