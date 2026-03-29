# advancedhubs-mobile

Frontend móvel da aplicação imobiliária **CasaGPT**: pesquisa de imóveis, mapa, detalhe com tabs (investimento, mercado, obras, burocracia, fiscalidade), onboarding e chat (UI).

## Requisitos

- [Flutter](https://docs.flutter.dev/get-started/install) (SDK compatível com `pubspec.yaml`, atualmente `>=3.0.0 <4.0.0`)
- Xcode / Android Studio conforme as plataformas que fores compilar

## Arranque rápido

```bash
flutter pub get
flutter gen-l10n   # opcional; também corre com pub get se `generate: true` estiver ativo
flutter run
```

## Testes e análise

```bash
flutter test
dart analyze
```

## Estrutura do código

- `lib/features/` — ecrãs por domínio (search, map, property_detail, onboarding, chat)
- `lib/core/` — tema, localização e controlos partilhados
- `lib/l10n/` — ficheiros ARB (`app_pt.arb`, `app_en.arb`) e classes geradas `CasaGptLocalizations`

## Internacionalização

- Strings de UI em **ARB**; código acede via `context.l10n` (extensão em `lib/core/localization/app_localizations.dart`).
- Idioma inicial segue o telemóvel (PT ou EN); o **drawer** inclui atalho para alternar PT/EN.

## Notas

- Dados de imóveis e métricas são maioritariamente **mock** até existir API/backend.
