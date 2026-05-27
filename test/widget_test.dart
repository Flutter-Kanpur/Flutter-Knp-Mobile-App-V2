import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_knp_mobile_app_v2/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('opens home with community navigation bypassing auth', (
    tester,
  ) async {
    await EasyLocalization.ensureInitialized();

    await tester.pumpWidget(
      ProviderScope(
        child: EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('hi')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: const FlutterKanpurApp(),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Flutter Kanpur'), findsOneWidget);
    expect(find.text('Community'), findsOneWidget);

    await tester.tap(find.text('Community').last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Module Backlog'), findsOneWidget);
    expect(find.text('Community Feed'), findsOneWidget);
  });
}
