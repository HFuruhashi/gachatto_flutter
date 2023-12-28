import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:gachatto_flutter/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("full app test", (WidgetTester tester) async {
    app.main(); // アプリを起動
    await tester.pumpAndSettle(); // 完了まで待機

    // 特定のボタンを見つける
    final Finder tapTarget = find.byTooltip('Increment');

    // ボタンをタップ
    await tester.tap(tapTarget);
    await tester.pumpAndSettle();

    // 期待される結果を確認
    expect(find.text('1'), findsOneWidget);
  });
}
