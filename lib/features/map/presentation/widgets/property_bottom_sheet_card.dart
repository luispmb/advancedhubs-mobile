import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/property_model.dart';
import '../../../property_detail/presentation/screens/page_detail_tab_investment_screen.dart';

/// Cartão que desliza no fundo do ecrã ao selecionar um pin no mapa.
class PropertyBottomSheetCard extends StatelessWidget {
  const PropertyBottomSheetCard({
    super.key,
    required this.property,
    required this.onClose,
    this.onFavoriteToggle,
  });

  final PropertyModel property;
  final VoidCallback onClose;
  final VoidCallback? onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final isPositive = property.percentage.startsWith('+');

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AspectRatio(
                            aspectRatio: 16 / 10,
                            child: property.imageUrl != null &&
                                    property.imageUrl!.isNotEmpty
                                ? Image.network(
                                    property.imageUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        _PlaceholderImage(),
                                  )
                                : _PlaceholderImage(),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: 12,
                          child: _CircleIconButton(
                            icon: Icons.favorite_border,
                            onTap: onFavoriteToggle ?? () {},
                          ),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: _CircleIconButton(
                            icon: Icons.close,
                            onTap: onClose,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      l10nPropertyTypology(context, property.type),
                      style: theme.labelLarge?.copyWith(
                        fontSize: 15,
                        color: AppColors.darkBlue600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          property.price,
                          style: theme.headlineMedium?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.darkBlue800,
                          ),
                        ),
                        const SizedBox(width: 10),
                        _InfoChip(
                          label: property.percentage,
                          textColor: isPositive
                              ? AppColors.roiGreen
                              : AppColors.roiRed,
                          backgroundColor: isPositive
                              ? AppColors.roiGreenBg
                              : const Color(0xFFFEE2E2),
                        ),
                        const SizedBox(width: 8),
                        _InfoChip(
                          label: '66m²',
                          textColor: AppColors.purple600,
                          backgroundColor: AppColors.gray600,
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  const PageDetailTabInvestmentScreen(),
                            ),
                          );
                        },
                        child: Text(context.l10n.viewDetails),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 1,
      shadowColor: Colors.black26,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 22, color: AppColors.darkBlue600),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.label,
    required this.textColor,
    required this.backgroundColor,
  });

  final String label;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 12,
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.info_outline, size: 14, color: textColor),
        ],
      ),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.purple200,
      child: const Center(
        child: Icon(Icons.home_work_outlined, size: 48, color: AppColors.purple400),
      ),
    );
  }
}
