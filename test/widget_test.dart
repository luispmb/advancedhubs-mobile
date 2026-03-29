import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:casa_gpt/main.dart';

void main() {
  testWidgets('CasaGPTApp arranca sem erros', (WidgetTester tester) async {
    await tester.pumpWidget(const CasaGPTApp());
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
