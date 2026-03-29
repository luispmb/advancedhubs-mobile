import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:casa_gpt/l10n/casa_gpt_localizations.dart';

import 'core/localization/app_locale_controller.dart';
import 'core/theme/app_theme.dart';
import 'features/search/presentation/screens/page_search_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppLocaleController.bootstrap();
  runApp(const CasaGPTApp());
}

/// Ponto de entrada da aplicação CasaGPT.
class CasaGPTApp extends StatelessWidget {
  const CasaGPTApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: AppLocaleController.localeNotifier,
      builder: (context, locale, _) {
        return MaterialApp(
          title: 'CasaGPT',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          locale: locale,
          supportedLocales: CasaGptLocalizations.supportedLocales,
          localizationsDelegates: const [
            CasaGptLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const PageSearchListScreen(),
        );
      },
    );
  }
}
