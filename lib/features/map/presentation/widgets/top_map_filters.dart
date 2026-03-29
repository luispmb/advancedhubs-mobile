import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';

/// Barra superior flutuante: pesquisa e tabs Lista/Mapa.
class TopMapFilters extends StatelessWidget {
  const TopMapFilters({
    super.key,
    this.searchPlaceholder,
    this.showMapTabSelected = true,
    this.onListTabTap,
    this.onMapTabTap,
    this.onFiltersTap,
    this.onMenuTap,
  });

  final String? searchPlaceholder;
  final bool showMapTabSelected;
  final VoidCallback? onListTabTap;
  final VoidCallback? onMapTabTap;
  final VoidCallback? onFiltersTap;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 48, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onMenuTap ?? () {},
                icon: const Icon(Icons.menu, size: 24, color: AppColors.darkBlue600),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.purple100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, size: 20, color: AppColors.gray900),
                      const SizedBox(width: 8),
                      Text(
                        searchPlaceholder ?? context.l10n.searchPropertiesPlaceholder,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 14,
                              color: AppColors.gray900,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _TabChip(
                  label: context.l10n.listTab,
                  selected: !showMapTabSelected,
                  onTap: onListTabTap,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _TabChip(
                  label: context.l10n.mapTab,
                  selected: showMapTabSelected,
                  onTap: onMapTabTap,
                ),
              ),
              const SizedBox(width: 8),
              Material(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(4),
                child: InkWell(
                  onTap: onFiltersTap ?? () {},
                  borderRadius: BorderRadius.circular(4),
                  child: const SizedBox(
                    width: 36,
                    height: 36,
                    child: Center(
                      child: Icon(Icons.tune, size: 22, color: AppColors.darkBlue600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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
    return Material(
      color: selected ? AppColors.purple200 : Colors.transparent,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 14,
                  color: selected ? AppColors.darkBlue800 : AppColors.gray900,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}
