import 'package:flutter/widgets.dart';

import 'package:casa_gpt/l10n/casa_gpt_localizations.dart';

/// Acesso tipado às strings geradas a partir de [lib/l10n/*.arb].
extension CasaGptL10nX on BuildContext {
  CasaGptLocalizations get l10n => CasaGptLocalizations.of(this);
}

/// Tipologias mock (mapa / lista) com tradução explícita em ARB.
String l10nPropertyTypology(BuildContext context, String type) {
  final l = context.l10n;
  return switch (type) {
    'Apartamento T1' => l.apartmentT1,
    'Apartamento T2' => l.apartmentT2,
    'Apartamento T3' => l.apartmentT3,
    _ => type,
  };
}
