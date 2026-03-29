import 'dart:math' as math;

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
      backgroundColor: AppColors.white,
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
                        setState(() => _selectedTabIndex = index);
                      },
                    ),
                    if (_selectedTabIndex == 0) const _InvestmentContent(),
                    if (_selectedTabIndex == 1) const _MarketContent(),
                    if (_selectedTabIndex == 2) const _RenovationsContent(),
                    if (_selectedTabIndex == 3) const _BurocraciaContent(),
                    if (_selectedTabIndex == 4) const _FiscalidadeContent(),
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
