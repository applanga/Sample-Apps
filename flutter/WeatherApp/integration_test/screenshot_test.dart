import 'package:applanga_flutter/applanga_flutter.dart';
import 'package:flutter/material.dart';
import 'package:weather_sample/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  const _pumpSettleDuration = Duration(seconds: 5);
  const Key cityName = Key('cityName');

  testWidgets('Take all screenshots with ApplangaWidget',
      (WidgetTester tester) async {
    for (var _locale in AppLocalizations.supportedLocales) {
      await tester.pumpWidget(
          MyApp(
            key: ObjectKey(_locale),
            startupLocale: _locale,
          ),
          _pumpSettleDuration);
      await tester.ensureVisible(find.byKey(cityName));
      // First Screen && Screenshot
      await ApplangaFlutter.I.captureScreenshotWithTag("HomePage");
      await tester.pumpAndSettle(_pumpSettleDuration);

      // Drawer Screenshot
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle(_pumpSettleDuration);
      await ApplangaFlutter.I.captureScreenshotWithTag("Drawer");
      await tester.pumpAndSettle(_pumpSettleDuration);

      // Second Screen && Screenshot
      await tester.tap(find.byIcon(Icons.calendar_today_rounded));
      await tester.pumpAndSettle(_pumpSettleDuration);
      await ApplangaFlutter.I.captureScreenshotWithTag("ForecastPage");

      // Third Screen && Screenshot
      await tester.pumpAndSettle(_pumpSettleDuration);
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle(_pumpSettleDuration);
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle(_pumpSettleDuration);
      await ApplangaFlutter.I.captureScreenshotWithTag("SettingsPage");
      await tester.pumpAndSettle(_pumpSettleDuration);
    }
  });
}
