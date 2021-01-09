import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integron/Utils/DB/Draft/DraftDB.dart';

import 'package:integron/main.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());
  //
  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);
  //
  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
  //
  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
  testWidgets("Draft put", (WidgetTester tester)async{
    await DraftDB.set(
      images: ['image1', 'image2'],
    );
  });
}