import 'package:flutter_knp_mobile_app_v2/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_knp_mobile_app_v2/main.dart';

void main() {
  testWidgets('shows Flutter Kanpur setup screen', (tester) async {
    await tester.pumpWidget(const FlutterKanpurApp());

    expect(find.text('Flutter Kanpur Setup'), findsOneWidget);
    expect(find.text('Supabase Tables'), findsOneWidget);
    expect(find.text('users'), findsOneWidget);
    expect(find.text('events'), findsOneWidget);
  });
}
