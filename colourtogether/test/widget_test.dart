import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:colourtogether/main.dart';

void main() {
  testWidgets('Lobby shows invite input and join action', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ColourTogetherApp());

    expect(find.text('Join a room'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Join room'), findsOneWidget);
  });
}
