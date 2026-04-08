import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../map/presentation/screens/map_screen.dart' show MapContent;
import '../../../property_detail/presentation/screens/page_detail_tab_investment_screen.dart';
import '../../data/portugal_places_data.dart';
import '../../data/portugal_places_repository.dart';
import '../../data/property_search_backend.dart';
import '../../domain/location_place.dart';
import '../../domain/search_radius.dart';
import '../widgets/app_drawer.dart';
import '../widgets/filters_sheet.dart';
import '../widgets/property_card.dart';
import '../widgets/search_radius_menu_button.dart';
import '../widgets/trial_subscribe_sheet.dart';

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
    const PropertyItem(
      title: 'Apartamento T1',
      price: '285.000€',
      roiPercent: '+5%',
      location: 'Campolide, Lisboa',
      typology: 'T1',
      area: '52m²',
      state: 'Novo',
    ),
    const PropertyItem(
      title: 'Moradia T3',
      price: '410.000€',
      roiPercent: '+8%',
      location: 'Ramalde, Porto',
      typology: 'T3',
      area: '180m²',
      state: 'Renovar',
    ),
  ];

  /// Mock: filtrar por token da localidade escolhida (até existir API real).
  static List<PropertyItem> propertiesMatchingPlace(LocationPlace place) {
    final parts =
        place.displayLabel.split(',').map((s) => s.trim().toLowerCase()).toList();
    final primary = parts.isNotEmpty ? parts[0] : '';
    final secondary = parts.length > 1 ? parts[1] : '';
    final matches = properties.where((p) {
      final loc = p.location.toLowerCase();
      if (primary.isNotEmpty && loc.contains(primary)) return true;
      if (secondary.isNotEmpty && loc.contains(secondary)) return true;
      return false;
    }).toList();
    return matches.isNotEmpty ? matches : properties;
  }

  /// Lista após aplicar filtros (mock alinhado ao layout de resultados filtrados).
  static final List<PropertyItem> filteredProperties = [
    const PropertyItem(
      title: 'Moradia',
      price: '320.000€',
      roiPercent: '18%',
      location: 'Ramalde, Porto',
      typology: 'T3',
      area: '160m²',
      state: 'Ruína',
    ),
    const PropertyItem(
      title: 'Moradia',
      price: '298.000€',
      roiPercent: '+12%',
      location: 'Campanhã, Porto',
      typology: 'T2',
      area: '140m²',
      state: 'Renovar',
    ),
  ];
}

/// Ecrã "Page Search - List v1" do Figma.
/// Cabeçalho fixo (menu, pesquisa, Lista/Mapa, filtros); abaixo: lista de cards ou mapa consoante o tab.
class PageSearchListScreen extends StatefulWidget {
  const PageSearchListScreen({super.key, this.showTrialBanner = false});

  /// Mostrar faixa de trial no topo (ex.: após «Continuar com trial de 7 dias» na subscrição).
  final bool showTrialBanner;

  @override
  State<PageSearchListScreen> createState() => _PageSearchListScreenState();
}

class _PageSearchListScreenState extends State<PageSearchListScreen> {
  /// 0 = Lista, 1 = Mapa
  int _selectedViewIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AppliedSearchFilters? _appliedFilters;
  LocationPlace? _selectedPlace;
  int _radiusKm = 5;
  final PropertySearchBackend _searchBackend = DebugPropertySearchBackend();

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<LocationPlace> _allPlaces = const [];
  List<LocationPlace> _suggestionMatches = const [];
  bool _placesLoaded = false;
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
    _searchFocusNode.addListener(() => setState(() {}));
    loadPortugalPlacesFromAsset().then((list) {
      if (!mounted) return;
      setState(() {
        _allPlaces = list;
        _placesLoaded = true;
        final q = _searchController.text;
        if (q.trim().length >= 2) {
          _suggestionMatches = filterPortugalPlaces(_allPlaces, q);
        }
      });
    });
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.removeListener(_onSearchTextChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    if (_selectedPlace != null &&
        _searchController.text.trim() != _selectedPlace!.displayLabel) {
      setState(() => _selectedPlace = null);
    }
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 140), () {
      if (!mounted) return;
      final q = _searchController.text;
      setState(() {
        _suggestionMatches =
            _placesLoaded ? filterPortugalPlaces(_allPlaces, q) : const [];
      });
    });
  }

  bool _showSuggestionDropdown() {
    if (!_searchFocusNode.hasFocus) return false;
    final t = _searchController.text.trim();
    if (t.length < 2) return false;
    if (_selectedPlace != null && t == _selectedPlace!.displayLabel) {
      return false;
    }
    if (_appliedFilters != null &&
        _appliedFilters!.locationLabel.trim().isNotEmpty &&
        t == _appliedFilters!.locationLabel.trim()) {
      return false;
    }
    return true;
  }

  void _onPickSuggestion(LocationPlace place) {
    setState(() {
      _searchController.text = place.displayLabel;
      if (_appliedFilters != null) {
        _appliedFilters =
            _appliedFilters!.copyWith(locationLabel: place.displayLabel);
        _selectedPlace = null;
      } else {
        _selectedPlace = place;
      }
    });
    _searchFocusNode.unfocus();
    unawaited(_syncSearchToBackend());
  }

  void _onInlineSearchCleared() {
    setState(() {
      _selectedPlace = null;
      if (_appliedFilters != null) {
        _appliedFilters = _appliedFilters!.copyWith(locationLabel: '');
      }
      _suggestionMatches = const [];
    });
  }

  Future<void> _syncSearchToBackend() async {
    if (!mounted) return;
    if (_selectedPlace != null) {
      await _searchBackend.submitSearchArea(
        place: _selectedPlace!,
        radiusKm: _radiusKm,
      );
      return;
    }
    final applied = _appliedFilters;
    if (applied != null && applied.locationLabel.trim().isNotEmpty) {
      await _searchBackend.submitSearchArea(
        place: LocationPlace(
          id: 'filter:${applied.locationLabel.hashCode}',
          displayLabel: applied.locationLabel.trim(),
          kind: 'municipality',
        ),
        radiusKm: _radiusKm,
      );
    }
  }

  void _setRadiusKm(int km) {
    setState(() {
      _radiusKm = km;
      if (_appliedFilters != null) {
        _appliedFilters = _appliedFilters!.copyWith(
          radiusLabel: formatSearchRadiusKm(km),
        );
      }
    });
    unawaited(_syncSearchToBackend());
  }

  Future<void> _openFilters() async {
    final result = await showModalBottomSheet<AppliedSearchFilters?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, __) => FiltersSheet(
              initial: _appliedFilters,
              onCleared: () {
                if (!mounted) return;
                setState(() {
                  _appliedFilters = null;
                  _radiusKm = 5;
                  _selectedPlace = null;
                  _searchController.clear();
                  _suggestionMatches = const [];
                });
              },
            ),
      ),
    );
    if (!mounted || result == null) return;
    setState(() {
      _appliedFilters = result;
      _selectedPlace = null;
      _radiusKm = parseSearchRadiusKm(result.radiusLabel);
      _searchController.text = result.locationLabel;
    });
    unawaited(_syncSearchToBackend());
  }

  @override
  Widget build(BuildContext context) {
    final applied = _appliedFilters;
    final showTrial = widget.showTrialBanner;
    final hasLocationQuery = applied != null || _selectedPlace != null;
    final listItems = applied != null
        ? _MockSearchData.filteredProperties
        : _selectedPlace != null
            ? _MockSearchData.propertiesMatchingPlace(_selectedPlace!)
            : _MockSearchData.properties;
    final resultsCount =
        applied?.resultsCount ?? (hasLocationQuery ? listItems.length : 0);

    final bottomContentInset = MediaQuery.paddingOf(context).bottom;
    final mainColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SearchHeader(
          onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
          onFiltersTap: _openFilters,
          searchController: _searchController,
          searchFocusNode: _searchFocusNode,
          placesLoaded: _placesLoaded,
          suggestionMatches: _suggestionMatches,
          showSuggestionDropdown: _showSuggestionDropdown(),
          onPickSuggestion: _onPickSuggestion,
          onInlineSearchCleared: _onInlineSearchCleared,
          applied: applied,
          radiusKm: _radiusKm,
          onRadiusKmChanged: _setRadiusKm,
          selectedViewIndex: _selectedViewIndex,
          onListTabTap: () => setState(() => _selectedViewIndex = 0),
          onMapTabTap: () => setState(() => _selectedViewIndex = 1),
          resultsCount: hasLocationQuery ? resultsCount : null,
        ),
        Expanded(
          child: _selectedViewIndex == 0
              ? SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: 28,
                    bottom: 24 + bottomContentInset,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!hasLocationQuery) ...[
                        _TopDealsSection(items: _MockSearchData.topDeals),
                        const SizedBox(height: 32),
                      ],
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: _PropertiesSection(
                          items: listItems,
                          hideTitle: hasLocationQuery,
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox.expand(child: MapContent()),
        ),
      ],
    );

    final paddedMain = ColoredBox(
      color: AppColors.purple100,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.deferToChild,
        child: SafeArea(
          top: !showTrial,
          // false: o fundo purple100 vai até ao fundo do ecrã (evita faixa branca do
          // home indicator). O recuo para o conteúdo está no padding do ScrollView.
          bottom: false,
          child: mainColumn,
        ),
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      backgroundColor: AppColors.purple100,
      body: ColoredBox(
        color: AppColors.purple100,
        child: showTrial
            ? AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light.copyWith(
                  statusBarColor: Colors.transparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _TrialExpiryBanner(
                      onSubscribeTap: () {
                        showTrialSubscribeSheet(context);
                      },
                    ),
                    Expanded(child: paddedMain),
                  ],
                ),
              )
            : paddedMain,
      ),
    );
  }
}

/// Faixa escura no topo do ecrã principal quando o utilizador entra com trial de 7 dias.
class _TrialExpiryBanner extends StatelessWidget {
  const _TrialExpiryBanner({required this.onSubscribeTap});

  final VoidCallback onSubscribeTap;

  static const Color _bannerBg = Color(0xFF1A1B2F);
  static const Color _ctaBg = Color(0xFF2E3248);

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final topInset = MediaQuery.viewPaddingOf(context).top;
    return Material(
      color: _bannerBg,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12, topInset + 8, 12, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.white,
                        fontSize: 13,
                        height: 1.3,
                      ),
                  children: [
                    TextSpan(text: l.trialBannerLine1a),
                    TextSpan(
                      text: l.trialBannerLine1b,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    TextSpan(text: '\n${l.trialBannerLine2}'),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Material(
              color: _ctaBg,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                onTap: onSubscribeTap,
                borderRadius: BorderRadius.circular(14),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Text(
                    l.subscribeNow,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Cabeçalho: menu, pesquisa inline + km, sugestões por baixo, tabs Lista/Mapa e filtros.
class _SearchHeader extends StatelessWidget {
  const _SearchHeader({
    required this.onMenuTap,
    required this.onFiltersTap,
    required this.searchController,
    required this.searchFocusNode,
    required this.placesLoaded,
    required this.suggestionMatches,
    required this.showSuggestionDropdown,
    required this.onPickSuggestion,
    required this.onInlineSearchCleared,
    required this.radiusKm,
    required this.onRadiusKmChanged,
    required this.selectedViewIndex,
    required this.onListTabTap,
    required this.onMapTabTap,
    this.applied,
    this.resultsCount,
  });

  final VoidCallback onMenuTap;
  final VoidCallback onFiltersTap;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final bool placesLoaded;
  final List<LocationPlace> suggestionMatches;
  final bool showSuggestionDropdown;
  final ValueChanged<LocationPlace> onPickSuggestion;
  final VoidCallback onInlineSearchCleared;
  final int radiusKm;
  final ValueChanged<int> onRadiusKmChanged;
  final AppliedSearchFilters? applied;
  final int? resultsCount;
  final int selectedViewIndex;
  final VoidCallback onListTabTap;
  final VoidCallback onMapTabTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final hasFilters = applied != null;
    final showResultsLine =
        selectedViewIndex == 0 && resultsCount != null;

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _InlineLocationSearchRow(
                  controller: searchController,
                  focusNode: searchFocusNode,
                  hintText: context.l10n.searchLocationPlaceholder,
                  placesLoaded: placesLoaded,
                  suggestionMatches: suggestionMatches,
                  showSuggestionDropdown: showSuggestionDropdown,
                  onPickSuggestion: onPickSuggestion,
                  onCleared: onInlineSearchCleared,
                  radiusKm: radiusKm,
                  onRadiusKmChanged: onRadiusKmChanged,
                ),
                const SizedBox(height: 12),
                _ListMapTabs(
                  onFiltersTap: onFiltersTap,
                  selectedViewIndex: selectedViewIndex,
                  onListTabTap: onListTabTap,
                  onMapTabTap: onMapTabTap,
                  filterBadgeCount: hasFilters ? applied!.activeFilterCount : 0,
                ),
                if (showResultsLine) ...[
                  const SizedBox(height: 12),
                  Text(
                    context.l10n.searchResultsFormatted(resultsCount!),
                    style: theme.bodyMedium?.copyWith(
                      fontSize: 14,
                      color: const Color(0xFF667085),
                    ),
                  ),
                ],
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

/// Campo de texto + raio km; sugestões em [Overlay] por cima do conteúdo (não empurram o layout).
class _InlineLocationSearchRow extends StatefulWidget {
  const _InlineLocationSearchRow({
    required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.placesLoaded,
    required this.suggestionMatches,
    required this.showSuggestionDropdown,
    required this.onPickSuggestion,
    required this.onCleared,
    required this.radiusKm,
    required this.onRadiusKmChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final bool placesLoaded;
  final List<LocationPlace> suggestionMatches;
  final bool showSuggestionDropdown;
  final ValueChanged<LocationPlace> onPickSuggestion;
  final VoidCallback onCleared;
  final int radiusKm;
  final ValueChanged<int> onRadiusKmChanged;

  @override
  State<_InlineLocationSearchRow> createState() =>
      _InlineLocationSearchRowState();
}

class _InlineLocationSearchRowState extends State<_InlineLocationSearchRow> {
  static const double _fieldHeight = 44;
  static const double _radius = 8;

  final LayerLink _layerLink = LayerLink();
  final GlobalKey _searchFieldKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  double _fieldWidth = 0;

  @override
  void initState() {
    super.initState();
    if (widget.showSuggestionDropdown) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _syncOverlay());
    }
  }

  @override
  void didUpdateWidget(covariant _InlineLocationSearchRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showSuggestionDropdown) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _syncOverlay());
    } else {
      _removeOverlay();
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
  }

  void _measureField() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final box =
          _searchFieldKey.currentContext?.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) return;
      final w = box.size.width;
      if ((w - _fieldWidth).abs() > 0.5) {
        setState(() => _fieldWidth = w);
        _overlayEntry?.markNeedsBuild();
      }
    });
  }

  void _syncOverlay() {
    if (!widget.showSuggestionDropdown) {
      _removeOverlay();
      return;
    }
    final overlayState = Overlay.maybeOf(context);
    if (overlayState == null) return;

    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
        builder: (ctx) => _LocationSuggestionsOverlay(
          layerLink: _layerLink,
          fieldWidth: _fieldWidth,
          matches: widget.suggestionMatches,
          onPick: widget.onPickSuggestion,
          onBarrierTap: () => widget.focusNode.unfocus(),
          borderRadius: _radius,
        ),
      );
      overlayState.insert(_overlayEntry!);
    } else {
      _overlayEntry!.markNeedsBuild();
    }
    _measureField();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              CompositedTransformTarget(
                link: _layerLink,
                child: Container(
                  key: _searchFieldKey,
                  height: _fieldHeight,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(_radius),
                    border: Border.all(color: AppColors.darkBlue200),
                  ),
                  alignment: Alignment.center,
                  child: ListenableBuilder(
                    listenable: widget.controller,
                    builder: (context, _) {
                      return TextField(
                        controller: widget.controller,
                        focusNode: widget.focusNode,
                        textInputAction: TextInputAction.search,
                        style: theme.bodyMedium?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkBlue800,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: widget.hintText,
                          hintStyle: theme.bodyMedium?.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: AppColors.gray900.withValues(alpha: 0.55),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          suffixIcon: widget.controller.text.isEmpty
                              ? null
                              : Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.close_rounded,
                                      size: 20,
                                      color: AppColors.gray900
                                          .withValues(alpha: 0.5),
                                    ),
                                    onPressed: () {
                                      widget.controller.clear();
                                      widget.onCleared();
                                      widget.focusNode.requestFocus();
                                    },
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(
                                      minWidth: 32,
                                      minHeight: 32,
                                    ),
                                  ),
                                ),
                        ),
                        onSubmitted: (_) {
                          if (widget.suggestionMatches.isEmpty) return;
                          widget.onPickSuggestion(
                            widget.suggestionMatches.first,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              if (!widget.placesLoaded)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: LinearProgressIndicator(
                    minHeight: 2,
                    borderRadius: BorderRadius.circular(1),
                    color: AppColors.purple600,
                    backgroundColor: AppColors.purple200,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        SearchRadiusMenuButton(
          radiusKm: widget.radiusKm,
          onChanged: widget.onRadiusKmChanged,
          height: _fieldHeight,
          borderRadius: _radius,
        ),
      ],
    );
  }
}

class _LocationSuggestionsOverlay extends StatelessWidget {
  const _LocationSuggestionsOverlay({
    required this.layerLink,
    required this.fieldWidth,
    required this.matches,
    required this.onPick,
    required this.onBarrierTap,
    required this.borderRadius,
  });

  final LayerLink layerLink;
  final double fieldWidth;
  final List<LocationPlace> matches;
  final ValueChanged<LocationPlace> onPick;
  final VoidCallback onBarrierTap;
  final double borderRadius;

  static const Color _highlight = Color(0xFFE8EDF3);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final w = fieldWidth > 8 ? fieldWidth : 220.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onBarrierTap,
            child: const ColoredBox(color: Colors.transparent),
          ),
        ),
        CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          offset: const Offset(0, 8),
          child: Material(
            elevation: 12,
            shadowColor: const Color(0xFF101828).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(borderRadius + 2),
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              width: w,
              child: matches.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      child: Text(
                        'Sem resultados',
                        style: theme.bodyMedium?.copyWith(
                          color: AppColors.gray900,
                        ),
                      ),
                    )
                  : ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 280),
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        itemCount: matches.length,
                        itemBuilder: (context, i) {
                          final p = matches[i];
                          final selected = i == 0;
                          return Material(
                            color:
                                selected ? _highlight : Colors.transparent,
                            child: InkWell(
                              onTap: () => onPick(p),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p.primaryLine,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.bodyLarge?.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.darkBlue800,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      p.regionCountryLine,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.bodySmall?.copyWith(
                                        fontSize: 12,
                                        color: AppColors.gray900
                                            .withValues(alpha: 0.75),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ),
        ),
      ],
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
    this.filterBadgeCount = 0,
  });

  final VoidCallback onFiltersTap;
  final int selectedViewIndex;
  final VoidCallback onListTabTap;
  final VoidCallback onMapTabTap;
  final int filterBadgeCount;

  @override
  Widget build(BuildContext context) {
    final showBadge = filterBadgeCount > 0;
    final badgeText =
        filterBadgeCount > 99 ? '99+' : '$filterBadgeCount';
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: AppColors.purple200,
            borderRadius: BorderRadius.circular(8),
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
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: onFiltersTap,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: showBadge
                    ? Border.all(color: AppColors.darkBlue600, width: 1)
                    : null,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Center(
                    child: Icon(Icons.tune, size: 23, color: AppColors.darkBlue600),
                  ),
                  if (showBadge)
                    Positioned(
                      right: -4,
                      top: -4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: const BoxDecoration(
                          color: AppColors.darkBlue600,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          badgeText,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                                height: 1,
                              ),
                        ),
                      ),
                    ),
                ],
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
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? AppColors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: const Color(0xFF101828).withValues(alpha: 0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                  BoxShadow(
                    color: const Color(0xFF101828).withValues(alpha: 0.04),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 14,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.topDealsForYou,
                style: theme.headlineMedium?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                  color: AppColors.darkBlue800,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  context.l10n.viewAll,
                  style: theme.bodySmall?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.purple800,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Carrossel edge-to-edge: padding só à esquerda para alinhar com o resto.
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < items.length; i++) ...[
                if (i > 0) const SizedBox(width: 14),
                PropertyCard(
                  item: items[i],
                  width: 296,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const PageDetailTabInvestmentScreen(),
                      ),
                    );
                  },
                  onFavoriteToggle: () {},
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _PropertiesSection extends StatelessWidget {
  const _PropertiesSection({
    required this.items,
    this.hideTitle = false,
  });

  final List<PropertyItem> items;
  final bool hideTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!hideTitle) ...[
          Text(
            context.l10n.properties,
            style: theme.headlineMedium?.copyWith(
              fontSize: 18,
              height: 1.15,
              color: AppColors.darkBlue600,
            ),
          ),
          const SizedBox(height: 12),
        ],
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(height: 20),
          PropertyCard(
            item: items[i],
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const PageDetailTabInvestmentScreen(),
                ),
              );
            },
            onFavoriteToggle: () {},
          ),
        ],
      ],
    );
  }
}
