import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'casa_gpt_localizations_en.dart';
import 'casa_gpt_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of CasaGptLocalizations
/// returned by `CasaGptLocalizations.of(context)`.
///
/// Applications need to include `CasaGptLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/casa_gpt_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: CasaGptLocalizations.localizationsDelegates,
///   supportedLocales: CasaGptLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the CasaGptLocalizations.supportedLocales
/// property.
abstract class CasaGptLocalizations {
  CasaGptLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static CasaGptLocalizations of(BuildContext context) {
    return Localizations.of<CasaGptLocalizations>(
        context, CasaGptLocalizations)!;
  }

  static const LocalizationsDelegate<CasaGptLocalizations> delegate =
      _CasaGptLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// No description provided for @drawerPropertySearch.
  ///
  /// In pt, this message translates to:
  /// **'Pesquisa de Imóveis'**
  String get drawerPropertySearch;

  /// No description provided for @drawerCreditSimulator.
  ///
  /// In pt, this message translates to:
  /// **'Simulador de Crédito'**
  String get drawerCreditSimulator;

  /// No description provided for @drawerFavorites.
  ///
  /// In pt, this message translates to:
  /// **'Favoritos'**
  String get drawerFavorites;

  /// No description provided for @drawerMyAccount.
  ///
  /// In pt, this message translates to:
  /// **'A minha conta'**
  String get drawerMyAccount;

  /// No description provided for @drawerHelp.
  ///
  /// In pt, this message translates to:
  /// **'Ajuda'**
  String get drawerHelp;

  /// No description provided for @appBrandName.
  ///
  /// In pt, this message translates to:
  /// **'casanvest.ai'**
  String get appBrandName;

  /// No description provided for @languageLabelEnglish.
  ///
  /// In pt, this message translates to:
  /// **'English'**
  String get languageLabelEnglish;

  /// No description provided for @languageLabelPortuguese.
  ///
  /// In pt, this message translates to:
  /// **'Português'**
  String get languageLabelPortuguese;

  /// No description provided for @searchPropertiesPlaceholder.
  ///
  /// In pt, this message translates to:
  /// **'Pesquisar imóveis'**
  String get searchPropertiesPlaceholder;

  /// No description provided for @searchLocationPlaceholder.
  ///
  /// In pt, this message translates to:
  /// **'Pesquisar localização...'**
  String get searchLocationPlaceholder;

  /// No description provided for @topDeals.
  ///
  /// In pt, this message translates to:
  /// **'Top Deals'**
  String get topDeals;

  /// No description provided for @topDealsForYou.
  ///
  /// In pt, this message translates to:
  /// **'Top deals para si'**
  String get topDealsForYou;

  /// No description provided for @viewAll.
  ///
  /// In pt, this message translates to:
  /// **'Ver todos'**
  String get viewAll;

  /// No description provided for @properties.
  ///
  /// In pt, this message translates to:
  /// **'Propriedades'**
  String get properties;

  /// No description provided for @listTab.
  ///
  /// In pt, this message translates to:
  /// **'Lista'**
  String get listTab;

  /// No description provided for @mapTab.
  ///
  /// In pt, this message translates to:
  /// **'Mapa'**
  String get mapTab;

  /// No description provided for @filters.
  ///
  /// In pt, this message translates to:
  /// **'Filtros'**
  String get filters;

  /// No description provided for @applyFilters.
  ///
  /// In pt, this message translates to:
  /// **'Aplicar Filtros'**
  String get applyFilters;

  /// No description provided for @clear.
  ///
  /// In pt, this message translates to:
  /// **'Limpar'**
  String get clear;

  /// No description provided for @riskLevel.
  ///
  /// In pt, this message translates to:
  /// **'Nível de Risco'**
  String get riskLevel;

  /// No description provided for @minRoi.
  ///
  /// In pt, this message translates to:
  /// **'ROI Mínimo'**
  String get minRoi;

  /// No description provided for @priceLabel.
  ///
  /// In pt, this message translates to:
  /// **'Preço'**
  String get priceLabel;

  /// No description provided for @typology.
  ///
  /// In pt, this message translates to:
  /// **'Tipologia'**
  String get typology;

  /// No description provided for @areaM2.
  ///
  /// In pt, this message translates to:
  /// **'Área (m²)'**
  String get areaM2;

  /// No description provided for @minShort.
  ///
  /// In pt, this message translates to:
  /// **'Mín'**
  String get minShort;

  /// No description provided for @maxShort.
  ///
  /// In pt, this message translates to:
  /// **'Máx'**
  String get maxShort;

  /// No description provided for @businessType.
  ///
  /// In pt, this message translates to:
  /// **'Tipo de Negócio'**
  String get businessType;

  /// No description provided for @fixFlip.
  ///
  /// In pt, this message translates to:
  /// **'Fix & Flip'**
  String get fixFlip;

  /// No description provided for @buyHold.
  ///
  /// In pt, this message translates to:
  /// **'Buy & Hold'**
  String get buyHold;

  /// No description provided for @filterLocation.
  ///
  /// In pt, this message translates to:
  /// **'Localização'**
  String get filterLocation;

  /// No description provided for @filterLocationHint.
  ///
  /// In pt, this message translates to:
  /// **'Cidade, distrito ou zona'**
  String get filterLocationHint;

  /// No description provided for @filterRadius.
  ///
  /// In pt, this message translates to:
  /// **'+ 0km'**
  String get filterRadius;

  /// No description provided for @onboardingTitle.
  ///
  /// In pt, this message translates to:
  /// **'Encontra o teu\npróximo negócio'**
  String get onboardingTitle;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'As melhores oportunidades de investimento\nimobiliário, analisadas e prontas para ti'**
  String get onboardingSubtitle;

  /// No description provided for @tryFreeTrial.
  ///
  /// In pt, this message translates to:
  /// **'Experimentar 7 dias grátis'**
  String get tryFreeTrial;

  /// No description provided for @getStarted.
  ///
  /// In pt, this message translates to:
  /// **'Começar'**
  String get getStarted;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In pt, this message translates to:
  /// **'Já tenho conta'**
  String get alreadyHaveAccount;

  /// No description provided for @loginTitle.
  ///
  /// In pt, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Entra para continuar a investir com confiança.'**
  String get loginSubtitle;

  /// No description provided for @forgotPassword.
  ///
  /// In pt, this message translates to:
  /// **'Esqueceu-se da senha?'**
  String get forgotPassword;

  /// No description provided for @logIn.
  ///
  /// In pt, this message translates to:
  /// **'Entrar'**
  String get logIn;

  /// No description provided for @orWord.
  ///
  /// In pt, this message translates to:
  /// **'ou'**
  String get orWord;

  /// No description provided for @noAccountYet.
  ///
  /// In pt, this message translates to:
  /// **'Ainda não tens conta? '**
  String get noAccountYet;

  /// No description provided for @noAccountYetShort.
  ///
  /// In pt, this message translates to:
  /// **'Já tens conta? '**
  String get noAccountYetShort;

  /// No description provided for @minCharsPassword.
  ///
  /// In pt, this message translates to:
  /// **'Mínimo 8 caracteres'**
  String get minCharsPassword;

  /// No description provided for @createAccount.
  ///
  /// In pt, this message translates to:
  /// **'Criar conta'**
  String get createAccount;

  /// No description provided for @logInLink.
  ///
  /// In pt, this message translates to:
  /// **'Fazer login'**
  String get logInLink;

  /// No description provided for @createAccountTitle.
  ///
  /// In pt, this message translates to:
  /// **'Criar Conta'**
  String get createAccountTitle;

  /// No description provided for @startTrialSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Começa o teu trial de 7 dias grátis'**
  String get startTrialSubtitle;

  /// No description provided for @firstName.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In pt, this message translates to:
  /// **'Apelido'**
  String get lastName;

  /// No description provided for @emailLabel.
  ///
  /// In pt, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @mobile.
  ///
  /// In pt, this message translates to:
  /// **'Telemóvel'**
  String get mobile;

  /// No description provided for @passwordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @subscribeTitle.
  ///
  /// In pt, this message translates to:
  /// **'Investe com Confiança'**
  String get subscribeTitle;

  /// No description provided for @subscribeSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Acesso total às melhores oportunidades\ndo mercado imobiliário'**
  String get subscribeSubtitle;

  /// No description provided for @benefitTopDeals.
  ///
  /// In pt, this message translates to:
  /// **'Top oportunidades atualizadas diariamente'**
  String get benefitTopDeals;

  /// No description provided for @benefitReports.
  ///
  /// In pt, this message translates to:
  /// **'Relatórios completos de investimento'**
  String get benefitReports;

  /// No description provided for @benefitSimulator.
  ///
  /// In pt, this message translates to:
  /// **'Simulador de financiamento'**
  String get benefitSimulator;

  /// No description provided for @benefitChat.
  ///
  /// In pt, this message translates to:
  /// **'Chat contextual por imóvel'**
  String get benefitChat;

  /// No description provided for @annualPlanTitle.
  ///
  /// In pt, this message translates to:
  /// **'Anual, 299€'**
  String get annualPlanTitle;

  /// No description provided for @annualPlanSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Apenas 24.92€/mês + IVA'**
  String get annualPlanSubtitle;

  /// No description provided for @monthlyPlanTitle.
  ///
  /// In pt, this message translates to:
  /// **'Mensal, 29.90€'**
  String get monthlyPlanTitle;

  /// No description provided for @monthlyPlanSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Por mês + IVA'**
  String get monthlyPlanSubtitle;

  /// No description provided for @subscribe.
  ///
  /// In pt, this message translates to:
  /// **'Subscrever'**
  String get subscribe;

  /// No description provided for @subscribeNow.
  ///
  /// In pt, this message translates to:
  /// **'Subscrever agora'**
  String get subscribeNow;

  /// No description provided for @continueTrial.
  ///
  /// In pt, this message translates to:
  /// **'Continuar com trial gratuito de 7 dias'**
  String get continueTrial;

  /// No description provided for @trialBannerLine1a.
  ///
  /// In pt, this message translates to:
  /// **'O teu trial acaba em '**
  String get trialBannerLine1a;

  /// No description provided for @trialBannerLine1b.
  ///
  /// In pt, this message translates to:
  /// **'7 dias.'**
  String get trialBannerLine1b;

  /// No description provided for @trialBannerLine2.
  ///
  /// In pt, this message translates to:
  /// **'Subscreve agora, só cobrado no fim.'**
  String get trialBannerLine2;

  /// No description provided for @legalConsent.
  ///
  /// In pt, this message translates to:
  /// **'Ao continuar, aceitas a Política de\nPrivacidade e os Termos & Condições.'**
  String get legalConsent;

  /// No description provided for @legalConsentAlt.
  ///
  /// In pt, this message translates to:
  /// **'Ao continuar, aceitas a Política de Privacidade e\nos Termos & Condições.'**
  String get legalConsentAlt;

  /// No description provided for @trialEnds5Days.
  ///
  /// In pt, this message translates to:
  /// **'O teu trial acaba em 5 dias.\nSubscreve agora, só cobrado no fim.'**
  String get trialEnds5Days;

  /// No description provided for @trialEnds2Days.
  ///
  /// In pt, this message translates to:
  /// **'O teu trial acaba em 2 dias'**
  String get trialEnds2Days;

  /// No description provided for @subscribeKeepAccess.
  ///
  /// In pt, this message translates to:
  /// **'Subscreve agora para continuar a ter acesso às\nmelhores oportunidades.'**
  String get subscribeKeepAccess;

  /// No description provided for @choosePlan.
  ///
  /// In pt, this message translates to:
  /// **'Escolhe o teu Plano'**
  String get choosePlan;

  /// No description provided for @renovate.
  ///
  /// In pt, this message translates to:
  /// **'Renovar'**
  String get renovate;

  /// No description provided for @purchaseSegment195.
  ///
  /// In pt, this message translates to:
  /// **'Compra 195k (82%)'**
  String get purchaseSegment195;

  /// No description provided for @worksSegment38.
  ///
  /// In pt, this message translates to:
  /// **'Obras 38k (16%)'**
  String get worksSegment38;

  /// No description provided for @feesSegment58.
  ///
  /// In pt, this message translates to:
  /// **'Taxas 5.8k (2%)'**
  String get feesSegment58;

  /// No description provided for @description.
  ///
  /// In pt, this message translates to:
  /// **'Descrição'**
  String get description;

  /// No description provided for @showMore.
  ///
  /// In pt, this message translates to:
  /// **'Ver mais'**
  String get showMore;

  /// No description provided for @showLess.
  ///
  /// In pt, this message translates to:
  /// **'Ver menos'**
  String get showLess;

  /// No description provided for @tabInvestment.
  ///
  /// In pt, this message translates to:
  /// **'Investimento'**
  String get tabInvestment;

  /// No description provided for @tabMarket.
  ///
  /// In pt, this message translates to:
  /// **'Mercado'**
  String get tabMarket;

  /// No description provided for @tabWorks.
  ///
  /// In pt, this message translates to:
  /// **'Obras'**
  String get tabWorks;

  /// No description provided for @tabBureaucracy.
  ///
  /// In pt, this message translates to:
  /// **'Burocracia'**
  String get tabBureaucracy;

  /// No description provided for @tabTaxation.
  ///
  /// In pt, this message translates to:
  /// **'Fiscalidade'**
  String get tabTaxation;

  /// No description provided for @viewDetails.
  ///
  /// In pt, this message translates to:
  /// **'Ver detalhe'**
  String get viewDetails;

  /// No description provided for @apartmentT1.
  ///
  /// In pt, this message translates to:
  /// **'Apartamento T1'**
  String get apartmentT1;

  /// No description provided for @apartmentT2.
  ///
  /// In pt, this message translates to:
  /// **'Apartamento T2'**
  String get apartmentT2;

  /// No description provided for @apartmentT3.
  ///
  /// In pt, this message translates to:
  /// **'Apartamento T3'**
  String get apartmentT3;

  /// No description provided for @chatContextLeiria.
  ///
  /// In pt, this message translates to:
  /// **'Contexto: Apartamento T2 em Leiria'**
  String get chatContextLeiria;

  /// No description provided for @chatWelcome.
  ///
  /// In pt, this message translates to:
  /// **'Olá Rita\nComo posso ajudar?'**
  String get chatWelcome;

  /// No description provided for @chatSuggestionRisk.
  ///
  /// In pt, this message translates to:
  /// **'Quais são os riscos deste imóvel?'**
  String get chatSuggestionRisk;

  /// No description provided for @chatSuggestionZone.
  ///
  /// In pt, this message translates to:
  /// **'Esta zona tem potencial?'**
  String get chatSuggestionZone;

  /// No description provided for @chatSuggestionRoi.
  ///
  /// In pt, this message translates to:
  /// **'Porquê ROI positivo aqui?'**
  String get chatSuggestionRoi;

  /// No description provided for @askAnything.
  ///
  /// In pt, this message translates to:
  /// **'Pergunte-me algo'**
  String get askAnything;

  /// No description provided for @chatDisclaimerCasanvest.
  ///
  /// In pt, this message translates to:
  /// **'A Casanvest.ai pode cometer erros. Valide a informação.'**
  String get chatDisclaimerCasanvest;

  /// No description provided for @chatDisclaimerCasaGpt.
  ///
  /// In pt, this message translates to:
  /// **'A casanvest.ai pode cometer erros. Valide a informação.'**
  String get chatDisclaimerCasaGpt;

  /// No description provided for @chatDemoReply.
  ///
  /// In pt, this message translates to:
  /// **'Boa pergunta 👀\nAinda estou em modo demo visual, sem backend ligado.'**
  String get chatDemoReply;

  /// No description provided for @searchResultsFormatted.
  ///
  /// In pt, this message translates to:
  /// **'{count} resultados'**
  String searchResultsFormatted(int count);
}

class _CasaGptLocalizationsDelegate
    extends LocalizationsDelegate<CasaGptLocalizations> {
  const _CasaGptLocalizationsDelegate();

  @override
  Future<CasaGptLocalizations> load(Locale locale) {
    return SynchronousFuture<CasaGptLocalizations>(
        lookupCasaGptLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_CasaGptLocalizationsDelegate old) => false;
}

CasaGptLocalizations lookupCasaGptLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return CasaGptLocalizationsEn();
    case 'pt':
      return CasaGptLocalizationsPt();
  }

  throw FlutterError(
      'CasaGptLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
