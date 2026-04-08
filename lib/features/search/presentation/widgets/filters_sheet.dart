import 'package:flutter/material.dart';

import 'package:casa_gpt/l10n/casa_gpt_localizations.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/search_radius.dart';

/// Devolvido por [FiltersSheet] ao confirmar com "Aplicar Filtros".
class AppliedSearchFilters {
  const AppliedSearchFilters({
    required this.locationLabel,
    required this.radiusLabel,
    required this.activeFilterCount,
    this.resultsCount = 43,
  });

  final String locationLabel;
  final String radiusLabel;
  final int activeFilterCount;
  final int resultsCount;

  AppliedSearchFilters copyWith({
    String? locationLabel,
    String? radiusLabel,
    int? activeFilterCount,
    int? resultsCount,
  }) {
    return AppliedSearchFilters(
      locationLabel: locationLabel ?? this.locationLabel,
      radiusLabel: radiusLabel ?? this.radiusLabel,
      activeFilterCount: activeFilterCount ?? this.activeFilterCount,
      resultsCount: resultsCount ?? this.resultsCount,
    );
  }
}

/// Track shape que desenha a linha do slider à largura total, alinhada às extremidades do histograma.
class _FullWidthRangeSliderTrackShape extends RoundedRectRangeSliderTrackShape {
  const _FullWidthRangeSliderTrackShape();

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
    Offset offset = Offset.zero,
  }) {
    final trackHeight = sliderTheme.trackHeight ?? 4;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    return Rect.fromLTRB(
      offset.dx,
      trackTop,
      offset.dx + parentBox.size.width,
      trackTop + trackHeight,
    );
  }
}

/// Modal de Filtros: ROI, Localização, Preço, Tipologia, Área, Tipo de Negócio.
class FiltersSheet extends StatefulWidget {
  const FiltersSheet({super.key, this.initial, this.onCleared});

  /// Estado aplicado anteriormente (reabrir o sheet com os mesmos valores).
  final AppliedSearchFilters? initial;

  /// Chamado ao tocar em «Limpar» para repor o ecrã de pesquisa ao estado sem filtros aplicados.
  final VoidCallback? onCleared;

  @override
  State<FiltersSheet> createState() => _FiltersSheetState();
}

class _FiltersSheetState extends State<FiltersSheet> {
  double _roiValue = 5;
  late final TextEditingController _locationController;
  double _priceMin = 30000;
  double _priceMax = 400000;
  int? _selectedTipologia;
  final _areaMinController = TextEditingController(text: '130');
  final _areaMaxController = TextEditingController(text: '250');
  bool _fixAndFlip = true;
  String _radiusLabel = '5 km';

  @override
  void initState() {
    super.initState();
    final i = widget.initial;
    _locationController = TextEditingController(
      text: i != null ? i.locationLabel : 'Leiria, Portugal',
    );
    if (i != null) {
      _radiusLabel = formatSearchRadiusKm(parseSearchRadiusKm(i.radiusLabel));
    }
  }

  @override
  void dispose() {
    _locationController.dispose();
    _areaMinController.dispose();
    _areaMaxController.dispose();
    super.dispose();
  }

  void _limpar() {
    setState(() {
      _roiValue = 0;
      _locationController.text = '';
      _priceMin = 30000;
      _priceMax = 1600000;
      _selectedTipologia = null;
      _areaMinController.clear();
      _areaMaxController.clear();
      _fixAndFlip = true;
      _radiusLabel = '5 km';
    });
    widget.onCleared?.call();
  }

  int _computeActiveFilterCount() {
    int c = 0;
    if (_roiValue > 0) c++;
    if (_locationController.text.trim().isNotEmpty) c++;
    if (_selectedTipologia != null) c++;
    if (_areaMinController.text.trim().isNotEmpty ||
        _areaMaxController.text.trim().isNotEmpty) {
      c++;
    }
    const fullMin = _priceMinLimit;
    const fullMax = _priceMaxLimit;
    if (_priceMin > fullMin || _priceMax < fullMax) c++;
    if (!_fixAndFlip) c++;
    return c == 0 ? 1 : c;
  }

  void _pickRadius() {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: kSearchRadiusKmOptions
              .map(
                (km) => ListTile(
                  title: Text(formatSearchRadiusKm(km)),
                  onTap: () {
                    setState(() => _radiusLabel = formatSearchRadiusKm(km));
                    Navigator.of(ctx).pop();
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _aplicar() {
    Navigator.of(context).pop(
      AppliedSearchFilters(
        locationLabel: _locationController.text.trim(),
        radiusLabel: _radiusLabel,
        activeFilterCount: _computeActiveFilterCount(),
        resultsCount: 43,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context).textTheme;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(theme, l),
            Flexible(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                behavior: HitTestBehavior.deferToChild,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildRoiSection(theme, l),
                    const SizedBox(height: 24),
                    _buildLocalizacaoSection(theme, l),
                    const SizedBox(height: 24),
                    _buildPrecoSection(theme, l),
                    const SizedBox(height: 24),
                    _buildTipologiaSection(theme, l),
                    const SizedBox(height: 24),
                    _buildAreaSection(theme, l),
                    const SizedBox(height: 24),
                    _buildTipoNegocioSection(theme, l),
                    const SizedBox(height: 32),
                    _buildFooter(theme, l),
                  ],
                ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(TextTheme theme, CasaGptLocalizations l) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              l.filters,
              textAlign: TextAlign.center,
              style: theme.titleLarge?.copyWith(
                color: AppColors.darkBlue800,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close, color: AppColors.darkBlue600, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildRoiSection(TextTheme theme, CasaGptLocalizations l) {
    final isPositive = _roiValue >= 0;
    final valueText = '${_roiValue >= 0 ? '+' : ''}${_roiValue.round()}%';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.minRoi,
          style: theme.labelLarge?.copyWith(
            color: AppColors.darkBlue600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.purple600,
            inactiveTrackColor: AppColors.gray600,
            thumbColor: AppColors.purple600,
            overlayColor: AppColors.purple600.withValues(alpha: 0.2),
          ),
          child: Slider(
            value: _roiValue,
            min: -20,
            max: 50,
            divisions: 70,
            onChanged: (v) => setState(() => _roiValue = v),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '-20%',
              style: theme.bodySmall?.copyWith(color: AppColors.gray900),
            ),
            Text(
              valueText,
              style: theme.labelLarge?.copyWith(
                color: isPositive ? AppColors.roiGreen : AppColors.roiRed,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '+50%',
              style: theme.bodySmall?.copyWith(color: AppColors.gray900),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocalizacaoSection(TextTheme theme, CasaGptLocalizations l) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.filterLocation,
          style: theme.labelLarge?.copyWith(
            color: AppColors.darkBlue600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.darkBlue200, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    hintText: l.filterLocationHint,
                    hintStyle: const TextStyle(color: AppColors.gray900, fontSize: 15),
                  ),
                  style: theme.bodyMedium?.copyWith(color: AppColors.darkBlue600, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Material(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: _pickRadius,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.darkBlue200, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _radiusLabel,
                        style: theme.bodyMedium?.copyWith(
                          color: AppColors.darkBlue600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.darkBlue600,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static const double _priceMinLimit = 30000;
  static const double _priceMaxLimit = 1600000;

  Widget _buildPrecoSection(TextTheme theme, CasaGptLocalizations l) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.priceLabel,
          style: theme.labelLarge?.copyWith(
            color: AppColors.darkBlue600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${_formatPrice(_priceMin)} – ${_formatPrice(_priceMax)}',
          style: theme.bodyMedium?.copyWith(
            color: AppColors.darkBlue600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        _PriceHistogramSlider(
          valueMin: _priceMin,
          valueMax: _priceMax,
          absoluteMin: _priceMinLimit,
          absoluteMax: _priceMaxLimit,
          onChanged: (a, b) => setState(() {
            _priceMin = a;
            _priceMax = b;
          }),
        ),
      ],
    );
  }

  String _formatPrice(double v) {
    final s = v.round().toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return '$buf€';
  }

  Widget _buildTipologiaSection(TextTheme theme, CasaGptLocalizations l) {
    const labels = ['T0', 'T1', 'T2', 'T3', 'T4', 'T5+'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.typology,
          style: theme.labelLarge?.copyWith(
            color: AppColors.darkBlue600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: List.generate(labels.length, (i) {
            final selected = _selectedTipologia == i;
            return Padding(
              padding: EdgeInsets.only(right: i < labels.length - 1 ? 8 : 0),
              child: Material(
                color: selected ? AppColors.white : AppColors.neutralLightGrey,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: () => setState(() => _selectedTipologia = selected ? null : i),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selected ? AppColors.purple600 : AppColors.darkBlue200,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      labels[i],
                      style: theme.labelLarge?.copyWith(
                        color: selected ? AppColors.purple600 : AppColors.gray900,
                        fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildAreaSection(TextTheme theme, CasaGptLocalizations l) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.areaM2,
          style: theme.labelLarge?.copyWith(
            color: AppColors.darkBlue600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.darkBlue200, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _areaMinController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    hintText: l.minShort,
                    hintStyle: const TextStyle(color: AppColors.gray900, fontSize: 15),
                  ),
                  style: theme.bodyMedium?.copyWith(color: AppColors.darkBlue600, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.darkBlue200, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _areaMaxController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    hintText: l.maxShort,
                    hintStyle: const TextStyle(color: AppColors.gray900, fontSize: 15),
                  ),
                  style: theme.bodyMedium?.copyWith(color: AppColors.darkBlue600, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTipoNegocioSection(TextTheme theme, CasaGptLocalizations l) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.businessType,
          style: theme.labelLarge?.copyWith(
            color: AppColors.darkBlue600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _TipoNegocioChip(
                label: l.fixFlip,
                icon: Icons.build_outlined,
                selected: _fixAndFlip,
                onTap: () => setState(() => _fixAndFlip = true),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _TipoNegocioChip(
                label: l.buyHold,
                icon: Icons.trending_up_outlined,
                selected: !_fixAndFlip,
                onTap: () => setState(() => _fixAndFlip = false),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooter(TextTheme theme, CasaGptLocalizations l) {
    return Row(
      children: [
        TextButton(
          onPressed: _limpar,
          child: Text(
            l.clear,
            style: theme.labelLarge?.copyWith(
              color: AppColors.darkBlue600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Spacer(),
        FilledButton(
          onPressed: _aplicar,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.purple600,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(l.applyFilters),
        ),
      ],
    );
  }
}

class _TipoNegocioChip extends StatelessWidget {
  const _TipoNegocioChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? AppColors.purple600 : AppColors.white,
            border: Border.all(
              color: selected ? AppColors.purple600 : AppColors.darkBlue200,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: selected ? AppColors.white : AppColors.gray900,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: theme.labelLarge?.copyWith(
                  color: selected ? AppColors.white : AppColors.gray900,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Dados mock do histograma de preços (distribuição com pico no centro-esquerda).
List<double> _histogramHeights(int bars) {
  final h = <double>[];
  const peak = 0.35;
  for (var i = 0; i < bars; i++) {
    final t = i / (bars - 1);
    final curve = 1.2 * (1 - (t - peak) * (t - peak) / (peak * peak));
    h.add((curve.clamp(0.0, 1.0) * 0.3 + 0.15 + 0.1 * (1 - t)));
  }
  final maxH = h.reduce((a, b) => a > b ? a : b);
  return h.map((e) => e / maxH).toList();
}

class _PriceHistogramSlider extends StatelessWidget {
  const _PriceHistogramSlider({
    required this.valueMin,
    required this.valueMax,
    required this.absoluteMin,
    required this.absoluteMax,
    required this.onChanged,
  });

  final double valueMin;
  final double valueMax;
  final double absoluteMin;
  final double absoluteMax;
  final void Function(double min, double max) onChanged;

  static const int _numBars = 40;
  static const double _barChartHeight = 44;

  @override
  Widget build(BuildContext context) {
    final heights = _histogramHeights(_numBars);
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final barWidth = w / _numBars;
        final normMin = (valueMin - absoluteMin) / (absoluteMax - absoluteMin);
        final normMax = (valueMax - absoluteMin) / (absoluteMax - absoluteMin);

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                height: _barChartHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(_numBars, (i) {
                    final barStart = i / _numBars;
                    final barEnd = (i + 1) / _numBars;
                    final inRange = barEnd > normMin && barStart < normMax;
                    return Container(
                      width: barWidth - 1,
                      height: _barChartHeight * heights[i],
                      margin: const EdgeInsets.only(right: 1),
                      decoration: BoxDecoration(
                        color: inRange ? AppColors.purple600 : AppColors.darkBlue200.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    );
                  }),
                ),
              ),
            ),
            SizedBox(
              height: 24,
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  rangeTrackShape: const _FullWidthRangeSliderTrackShape(),
                  trackHeight: 4,
                  overlayShape: const RoundSliderOverlayShape(),
                  rangeThumbShape: const RoundRangeSliderThumbShape(),
                  activeTrackColor: AppColors.purple600,
                  inactiveTrackColor: AppColors.darkBlue200.withValues(alpha: 0.5),
                  activeTickMarkColor: Colors.transparent,
                  inactiveTickMarkColor: Colors.transparent,
                  thumbColor: AppColors.purple600,
                  overlayColor: AppColors.purple600.withValues(alpha: 0.2),
                ),
                child: RangeSlider(
                  values: RangeValues(valueMin, valueMax),
                  min: absoluteMin,
                  max: absoluteMax,
                  divisions: _numBars * 2,
                  onChanged: (v) => onChanged(v.start, v.end),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

