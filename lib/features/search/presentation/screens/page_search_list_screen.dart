import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../map/presentation/screens/map_screen.dart' show MapContent;
import '../../../property_detail/presentation/screens/page_detail_tab_investment_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/filters_sheet.dart';
import '../widgets/property_card.dart';

/// Dados mock para a lista de pesquisa (substituir por repositório/API).
class _MockSearchData {
  static final List<PropertyItem> topDeals = [
    const PropertyItem(
      title: 'Apartamento T2',
      price: '195.000€',
      roiPercent: '+6%',
      location: 'Caldas da Rainha, Leiria',
      typology: 'T2',
      area: '66m²',
      state: 'Renovar',
    ),
    const PropertyItem(
      title: 'Apartamento T2',
      price: '195.000€',
      roiPercent: '+6%',
      location: 'Caldas da Rainha, Leiria',
      typology: 'T2',
      area: '66m²',
      state: 'Renovar',
    ),
  ];

  static final List<PropertyItem> properties = [
    const PropertyItem(
      title: 'Apartamento T2',
      price: '195.000€',
      roiPercent: '+6%',
      location: 'Caldas da Rainha, Leiria',
      typology: 'T2',
      area: '66m²',
      state: 'Renovar',
    ),
    const PropertyItem(
      title: 'Apartamento T2',
      price: '195.000€',
      roiPercent: '+6%',
      location: 'Caldas da Rainha, Leiria',
      typology: 'T2',
      area: '66m²',
      state: 'Renovar',
    ),
  ];
}

/// Ecrã "Page Search - List v1" do Figma.
/// Cabeçalho fixo (menu, pesquisa, Lista/Mapa, filtros); abaixo: lista de cards ou mapa consoante o tab.
class PageSearchListScreen extends StatefulWidget {
  const PageSearchListScreen({super.key});

  @override
  State<PageSearchListScreen> createState() => _PageSearchListScreenState();
}

class _PageSearchListScreenState extends State<PageSearchListScreen> {
  /// 0 = Lista, 1 = Mapa
  int _selectedViewIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isMapView = _selectedViewIndex == 1;
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      body: ColoredBox(
        color: AppColors.purple100,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.deferToChild,
          child: SafeArea(
            top: true,
            bottom: !isMapView,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SearchHeader(
                  onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
                  onFiltersTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => DraggableScrollableSheet(
                        initialChildSize: 0.85,
                        minChildSize: 0.5,
                        maxChildSize: 0.95,
                        builder: (_, __) => const FiltersSheet(),
                      ),
                    );
                  },
                  selectedViewIndex: _selectedViewIndex,
                  onListTabTap: () => setState(() => _selectedViewIndex = 0),
                  onMapTabTap: () => setState(() => _selectedViewIndex = 1),
                ),
                Expanded(
                  child: _selectedViewIndex == 0
                      ? SingleChildScrollView(
                          padding: const EdgeInsets.only(
                            left: 24,
                            top: 24,
                            right: 24,
                            bottom: 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _TopDealsSection(items: _MockSearchData.topDeals),
                              const SizedBox(height: 32),
                              _PropertiesSection(
                                items: _MockSearchData.properties,
                              ),
                            ],
                          ),
                        )
                      : SizedBox.expand(child: MapContent()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Cabeçalho: menu, barra de pesquisa, tabs Lista/Mapa e botão filtros.
class _SearchHeader extends StatelessWidget {
  const _SearchHeader({
    required this.onMenuTap,
    required this.onFiltersTap,
    required this.selectedViewIndex,
    required this.onListTabTap,
    required this.onMapTabTap,
  });

  final VoidCallback onMenuTap;
  final VoidCallback onFiltersTap;
  /// 0 = Lista, 1 = Mapa
  final int selectedViewIndex;
  final VoidCallback onListTabTap;
  final VoidCallback onMapTabTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.purple100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: onMenuTap,
                icon: const Icon(Icons.menu, size: 24, color: AppColors.darkBlue600),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
            child: Column(
              children: [
                _SearchBar(placeholder: context.l10n.searchPropertiesPlaceholder),
                const SizedBox(height: 16),
                _ListMapTabs(
                  onFiltersTap: onFiltersTap,
                  selectedViewIndex: selectedViewIndex,
                  onListTabTap: onListTabTap,
                  onMapTabTap: onMapTabTap,
                ),
              ],
            ),
          ),
          if (selectedViewIndex == 0)
            const Divider(height: 1, color: AppColors.gray600),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.placeholder});

  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.search, size: 24, color: AppColors.gray900),
          const SizedBox(width: 8),
          Text(
            placeholder,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  color: AppColors.gray900,
                ),
          ),
        ],
      ),
    );
  }
}

/// Tabs "Lista" e "Mapa" + botão filtros.
class _ListMapTabs extends StatelessWidget {
  const _ListMapTabs({
    required this.onFiltersTap,
    required this.selectedViewIndex,
    required this.onListTabTap,
    required this.onMapTabTap,
  });

  final VoidCallback onFiltersTap;
  final int selectedViewIndex;
  final VoidCallback onListTabTap;
  final VoidCallback onMapTabTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2.571),
          decoration: BoxDecoration(
            color: AppColors.purple200,
            border: Border.all(color: const Color(0xFFF2F4F7)),
            borderRadius: BorderRadius.circular(3.6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _TabChip(
                  label: context.l10n.listTab,
                  selected: selectedViewIndex == 0,
                  onTap: onListTabTap),
              _TabChip(
                label: context.l10n.mapTab,
                selected: selectedViewIndex == 1,
                onTap: onMapTabTap,
              ),
            ],
          ),
        ),
        const Spacer(),
        Material(
          color: AppColors.white.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(4),
          child: InkWell(
            onTap: onFiltersTap,
            borderRadius: BorderRadius.circular(4),
            child: const SizedBox(
              width: 36,
              height: 36,
              child: Center(
                child: Icon(Icons.tune, size: 23, color: AppColors.darkBlue600),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.selected,
    this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7.714),
      decoration: BoxDecoration(
        color: selected ? AppColors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(3.6),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: const Color(0xFF101828).withValues(alpha: 0.1),
                  blurRadius: 1.929,
                  offset: const Offset(0, 0.643),
                ),
                BoxShadow(
                  color: const Color(0xFF101828).withValues(alpha: 0.06),
                  blurRadius: 1.286,
                  offset: const Offset(0, 0.643),
                ),
              ]
            : null,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 14,
              color: selected ? AppColors.darkBlue800 : const Color(0xFF667085),
            ),
      ),
    ),
    );
  }
}

class _TopDealsSection extends StatelessWidget {
  const _TopDealsSection({required this.items});

  final List<PropertyItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.topDeals,
              style: theme.headlineMedium?.copyWith(
                fontSize: 18,
                color: AppColors.darkBlue600,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                context.l10n.viewAll,
                style: theme.bodySmall?.copyWith(
                  fontSize: 12,
                  color: AppColors.purple800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          // Altura extra quando os chips do card fazem wrap (ecrãs / testes estreitos).
          height: 380,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return PropertyCard(
                item: items[index],
                width: 282,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const PageDetailTabInvestmentScreen(),
                    ),
                  );
                },
                onFavoriteToggle: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PropertiesSection extends StatelessWidget {
  const _PropertiesSection({required this.items});

  final List<PropertyItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.properties,
          style: theme.headlineMedium?.copyWith(
            fontSize: 18,
            color: AppColors.darkBlue600,
          ),
        ),
        const SizedBox(height: 20),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            return PropertyCard(
              item: items[index],
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const PageDetailTabInvestmentScreen(),
                  ),
                );
              },
              onFavoriteToggle: () {},
            );
          },
        ),
      ],
    );
  }
}
