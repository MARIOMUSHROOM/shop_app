import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shop_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("try click", (tester) async {
    app.main();
    await tester.pumpAndSettle();
    final textDONE = find.text('Done');
    // final textField = find.byType(TabBar).first;
    await tester.tap(textDONE);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 10));
    final gesture =
        await tester.startGesture(Offset(0, 300)); //Position of the scrollview
    await gesture.moveBy(Offset(0, -300)); //How much to scroll by
    await Future.delayed(const Duration(seconds: 10));
    await tester.pump();
  });
}
