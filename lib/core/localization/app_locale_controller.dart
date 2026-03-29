import 'package:flutter/widgets.dart';

/// Idioma da app (PT/EN), alinhado com [MaterialApp.locale] e `flutter gen-l10n`.
class AppLocaleController {
  AppLocaleController._();

  static final ValueNotifier<Locale> localeNotifier =
      ValueNotifier<Locale>(const Locale('pt'));

  static Locale _localeFromPlatform() {
    final platform = WidgetsBinding.instance.platformDispatcher.locale;
    final code = platform.languageCode.toLowerCase();
    if (code.startsWith('en')) return const Locale('en');
    return const Locale('pt');
  }

  /// Chamar em [main] após [WidgetsFlutterBinding.ensureInitialized].
  static void bootstrap() {
    localeNotifier.value = _localeFromPlatform();
  }

  static void setLocale(Locale locale) {
    localeNotifier.value = locale;
  }

  static void togglePtEn() {
    final current = localeNotifier.value.languageCode.toLowerCase();
    if (current.startsWith('en')) {
      setLocale(const Locale('pt'));
    } else {
      setLocale(const Locale('en'));
    }
  }
}
