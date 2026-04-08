import 'package:casa_gpt/l10n/casa_gpt_localizations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../chat/presentation/screens/bottom_shelf_chat_screen.dart';

part 'page_detail_tab_investment_mock.part.dart';
part 'page_detail_tab_investment_header.part.dart';
part 'page_detail_tab_investment_investment.part.dart';
part 'page_detail_tab_investment_market.part.dart';
part 'page_detail_tab_investment_renovations.part.dart';
part 'page_detail_tab_investment_burocracia.part.dart';
part 'page_detail_tab_investment_fiscalidade.part.dart';
part 'page_detail_tab_investment_fab.part.dart';

/// Ecrã Page Detail com tabs Investimento e Mercado.
/// Hero, resumo do imóvel; ao carregar em Mercado mostra o conteúdo do tab Mercado.
class PageDetailTabInvestmentScreen extends StatefulWidget {
  const PageDetailTabInvestmentScreen({super.key});

  @override
  State<PageDetailTabInvestmentScreen> createState() =>
      _PageDetailTabInvestmentScreenState();
}

class _PageDetailTabInvestmentScreenState
    extends State<PageDetailTabInvestmentScreen> {
  int _selectedTabIndex = 0;
  double _tabSwipeDx = 0;

  void _onTabSwipeEnd(DragEndDetails details, int tabCount) {
    final vx = details.velocity.pixelsPerSecond.dx;
    const velocityThreshold = 180.0;
    const distanceThreshold = 48.0;
    final goNext =
        vx < -velocityThreshold || _tabSwipeDx < -distanceThreshold;
    final goPrev =
        vx > velocityThreshold || _tabSwipeDx > distanceThreshold;
    _tabSwipeDx = 0;
    if (goNext && !goPrev && _selectedTabIndex < tabCount - 1) {
      setState(() => _selectedTabIndex++);
    } else if (goPrev && !goNext && _selectedTabIndex > 0) {
      setState(() => _selectedTabIndex--);
    } else if (goNext && goPrev) {
      if (vx < 0 && _selectedTabIndex < tabCount - 1) {
        setState(() => _selectedTabIndex++);
      } else if (vx > 0 && _selectedTabIndex > 0) {
        setState(() => _selectedTabIndex--);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = CasaGptLocalizations.of(context);
    final tabLabels = [
      l10n.tabInvestment,
      l10n.tabMarket,
      l10n.tabWorks,
      l10n.tabBureaucracy,
      l10n.tabTaxation,
    ];
    return Scaffold(
      backgroundColor: AppColors.purple100,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _HeroSection(
                onBack: () => Navigator.of(context).pop(),
                onShare: () {},
                onFavorite: () {},
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _PropertyOverview(),
                    _TabBarRow(
                      selectedIndex: _selectedTabIndex,
                      tabLabels: tabLabels,
                      onTabSelected: (index) {
                        setState(() {
                          _selectedTabIndex = index;
                          _tabSwipeDx = 0;
                        });
                      },
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.deferToChild,
                      onHorizontalDragStart: (_) => _tabSwipeDx = 0,
                      onHorizontalDragUpdate: (details) {
                        _tabSwipeDx += details.delta.dx;
                      },
                      onHorizontalDragEnd: (details) =>
                          _onTabSwipeEnd(details, tabLabels.length),
                      onHorizontalDragCancel: () => _tabSwipeDx = 0,
                      child: KeyedSubtree(
                        key: ValueKey<int>(_selectedTabIndex),
                        child: switch (_selectedTabIndex) {
                          0 => const _InvestmentContent(),
                          1 => const _MarketContent(),
                          2 => const _RenovationsContent(),
                          3 => const _BurocraciaContent(),
                          _ => const _FiscalidadeContent(),
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 24,
            bottom: 120,
            child: _CasaGPTFab(
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      decoration: BoxDecoration(
                        color: AppColors.purple100,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: const BottomShelfChatScreen(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TabsBottomActionsInline extends StatelessWidget {
  const _TabsBottomActionsInline();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () => _showContactsSheet(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF52989E),
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                'Ver Contactos',
                style: theme.titleMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.darkBlue600,
                side: const BorderSide(color: AppColors.darkBlue600, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                backgroundColor: AppColors.white,
              ),
              child: Text(
                'Simulador de Crédito',
                style: theme.titleMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkBlue600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

Future<void> _showContactsSheet(BuildContext context) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.45),
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(ctx).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(ctx).size.height * 0.9,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        clipBehavior: Clip.antiAlias,
        child: const _ContactsSheet(),
      ),
    ),
  );
}

class _ContactsSheet extends StatefulWidget {
  const _ContactsSheet();

  @override
  State<_ContactsSheet> createState() => _ContactsSheetState();
}

class _ContactsSheetState extends State<_ContactsSheet> {
  static const List<_ContactAgency> _agencies = [
    _ContactAgency(name: 'Keller Williams (KW Ábaco)', phone: '+351 912 345 678'),
    _ContactAgency(name: 'Imovirtual'),
    _ContactAgency(name: 'Idealista'),
    _ContactAgency(name: 'Century 21'),
    _ContactAgency(name: 'Century 21'),
  ];

  int? _revealedIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return SafeArea(
      top: false,
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contactos',
                            style: theme.titleLarge?.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.darkBlue600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '8 imobiliárias têm este imóvel',
                            style: theme.bodyMedium?.copyWith(
                              fontSize: 15,
                              color: AppColors.gray1000,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.close_rounded,
                        size: 30,
                        color: AppColors.gray900.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.gray600),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.74,
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  itemCount: _agencies.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, i) {
                    final a = _agencies[i];
                    final revealed = _revealedIndex == i && a.phone != null;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                a.name,
                                style: theme.titleMedium?.copyWith(
                                  fontSize: 21 / 2,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.darkBlue600,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.link_rounded,
                              size: 20,
                              color: AppColors.gray900.withValues(alpha: 0.85),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.neutralLightGrey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone_outlined,
                                size: 16,
                                color: AppColors.gray900.withValues(alpha: 0.65),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  revealed
                                      ? a.phone!
                                      : 'Contacto disponível',
                                  style: theme.bodyMedium?.copyWith(
                                    fontSize: 28 / 2,
                                    color: revealed
                                        ? AppColors.darkBlue600
                                        : AppColors.gray900.withValues(alpha: 0.55),
                                    fontWeight: revealed
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              _RevealContactButton(
                                revealed: revealed,
                                onTap: () {
                                  setState(() {
                                    _revealedIndex = revealed ? null : i;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: bottomInset > 0 ? bottomInset - 2 : 8),
        ],
      ),
    );
  }
}

class _RevealContactButton extends StatelessWidget {
  const _RevealContactButton({
    required this.revealed,
    required this.onTap,
  });

  final bool revealed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: revealed ? const Color(0xFFE8EAF0) : const Color(0xFF52989E),
      borderRadius: BorderRadius.circular(9),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(
            revealed ? Icons.check_rounded : Icons.visibility_outlined,
            size: 20,
            color: revealed ? const Color(0xFF52989E) : Colors.white,
          ),
        ),
      ),
    );
  }
}

class _ContactAgency {
  const _ContactAgency({
    required this.name,
    this.phone,
  });

  final String name;
  final String? phone;
}
