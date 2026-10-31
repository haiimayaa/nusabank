import 'package:flutter_test/flutter_test.dart';
import 'package:nusabank/main.dart';

void main() {
  testWidgets('NusaBank app test', (WidgetTester tester) async {
    await tester.pumpWidget(const NusaBankApp());
    expect(find.text('NUSABANK'), findsOneWidget);
    expect(find.text('Selamat Datang'), findsOneWidget);
    expect(find.text('Mulai'), findsOneWidget);
  });
}
