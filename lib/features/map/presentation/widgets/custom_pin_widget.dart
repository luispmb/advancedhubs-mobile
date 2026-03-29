import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../data/models/property_model.dart';

/// Marcador do mapa: preço e percentagem. Estado visual isSelected (azul escuro vs branco).
class CustomPinWidget extends StatelessWidget {
  const CustomPinWidget({
    super.key,
    required this.property,
    required this.isSelected,
    required this.onTap,
  });

  final PropertyModel property;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final isPositive = property.percentage.startsWith('+');
    final percentColor = isPositive ? AppColors.roiGreen : AppColors.roiRed;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.darkBlue800 : AppColors.white,
            border: Border.all(
              color: isSelected ? AppColors.darkBlue800 : AppColors.darkBlue200,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                property.price,
                style: theme.labelLarge?.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? AppColors.white : AppColors.darkBlue800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                property.percentage,
                style: theme.labelLarge?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppColors.roiGreenBorder : percentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
