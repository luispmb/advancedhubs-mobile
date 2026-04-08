import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';

/// Modelo mock de uma propriedade (substituir por entidade de domínio depois).
class PropertyItem {
  const PropertyItem({
    required this.title,
    required this.price,
    required this.roiPercent,
    required this.location,
    required this.typology,
    required this.area,
    required this.state,
    this.imageUrl,
  });

  final String title;
  final String price;
  final String roiPercent;
  final String location;
  final String typology;
  final String area;
  final String state;
  final String? imageUrl;
}

/// Card de propriedade (Care_Propriety do Figma).
/// Usado em listas horizontais (Top Deals) e verticais (Propriedades).
class PropertyCard extends StatelessWidget {
  const PropertyCard({
    super.key,
    required this.item,
    this.width,
    this.onTap,
    this.onFavoriteToggle,
  });

  final PropertyItem item;
  final double? width;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.neutralLightGrey),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF111827).withValues(alpha: 0.06),
            blurRadius: 100,
            offset: const Offset(4, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _PropertyImage(
                  imageUrl: item.imageUrl,
                  onFavoriteTap: onFavoriteToggle,
                ),
                const SizedBox(height: 12),
                Text(
                  l10nPropertyTypology(context, item.title),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.bodyMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.darkBlue600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.price,
                            maxLines: 1,
                            style: theme.headlineMedium?.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.darkBlue600,
                              height: 1.05,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const _TimeBadge(),
                    const SizedBox(width: 8),
                    _RoiBadge(roiPercent: item.roiPercent),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: AppColors.gray900,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        item.location,
                        style: theme.bodySmall?.copyWith(
                          fontSize: 14,
                          color: AppColors.gray900,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Divider(
                    height: 1, color: AppColors.gray700.withValues(alpha: 0.5)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    _PropertyChip(
                      icon: Icons.bed_outlined,
                      label: item.typology,
                    ),
                    _PropertyChip(
                      icon: Icons.square_foot_outlined,
                      label: item.area,
                    ),
                  _PropertyChip(
                    icon: Icons.build_outlined,
                    label: item.state == 'Renovar'
                        ? context.l10n.renovate
                        : item.state,
                  ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PropertyImage extends StatelessWidget {
  const _PropertyImage({
    this.imageUrl,
    this.onFavoriteTap,
  });

  final String? imageUrl;
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _placeholder(),
                  )
                : _placeholder(),
          ),
          Positioned(
            top: 8,
            right: 11,
            child: Material(
              color: AppColors.white.withValues(alpha: 0.8),
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onFavoriteTap,
                customBorder: const CircleBorder(),
                child: const SizedBox(
                  width: 28,
                  height: 28,
                  child: Center(
                    child: Icon(
                      Icons.favorite_border,
                      size: 20,
                      color: AppColors.darkBlue600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: _ImageSliderIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: const Color(0xFFC4C4C4),
    );
  }
}

class _ImageSliderIndicator extends StatelessWidget {
  const _ImageSliderIndicator();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (i) => _ImageSliderDot(active: i == 0)),
    );
  }
}

class _ImageSliderDot extends StatelessWidget {
  const _ImageSliderDot({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 26 : 10,
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: active ? AppColors.white : AppColors.white.withValues(alpha: 0.45),
      ),
    );
  }
}

class _RoiBadge extends StatelessWidget {
  const _RoiBadge({required this.roiPercent});

  final String roiPercent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.roiGreenBg,
        border: Border.all(color: AppColors.roiGreenBorder),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            roiPercent,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.roiGreen,
                ),
          ),
          const SizedBox(width: 6),
          Icon(
            Icons.info_outline,
            size: 16,
            color: AppColors.roiGreen.withValues(alpha: 0.9),
          ),
        ],
      ),
    );
  }
}

class _TimeBadge extends StatelessWidget {
  const _TimeBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.neutralLightGrey,
        border: Border.all(color: AppColors.darkBlue200),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '10m',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkBlue600,
                ),
          ),
          const SizedBox(width: 6),
          Icon(
            Icons.info_outline,
            size: 15,
            color: AppColors.gray900.withValues(alpha: 0.7),
          ),
        ],
      ),
    );
  }
}

class _PropertyChip extends StatelessWidget {
  const _PropertyChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppColors.purple600),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 14,
                color: AppColors.purple600,
              ),
        ),
      ],
    );
  }
}
