import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/search_radius.dart';

/// Botão «N km» com menu (2–40 km). O menu tem **exatamente** a largura do retângulo do botão.
class SearchRadiusMenuButton extends StatefulWidget {
  const SearchRadiusMenuButton({
    super.key,
    required this.radiusKm,
    required this.onChanged,
    this.height = 44,
    this.borderRadius = 10,
  });

  final int radiusKm;
  final ValueChanged<int> onChanged;
  final double height;
  final double borderRadius;

  @override
  State<SearchRadiusMenuButton> createState() => _SearchRadiusMenuButtonState();
}

class _SearchRadiusMenuButtonState extends State<SearchRadiusMenuButton> {
  final MenuController _menuController = MenuController();
  final GlobalKey _buttonKey = GlobalKey();
  double _anchorWidth = 88;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box =
          _buttonKey.currentContext?.findRenderObject() as RenderBox?;
      if (!mounted || box == null || !box.hasSize) return;
      final w = box.size.width;
      if ((w - _anchorWidth).abs() > 0.5) {
        setState(() => _anchorWidth = w);
      }
    });

    final menuWidth = _anchorWidth;

    return MenuAnchor(
      controller: _menuController,
      alignmentOffset: const Offset(0, 6),
      style: MenuStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        elevation: WidgetStateProperty.all(10),
        shadowColor: WidgetStateProperty.all(
          const Color(0xFF101828).withValues(alpha: 0.12),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        minimumSize: WidgetStateProperty.all(Size(menuWidth, 0)),
        maximumSize: WidgetStateProperty.all(Size(menuWidth, double.infinity)),
      ),
      menuChildren: [
        for (final km in kSearchRadiusKmOptions)
          MenuItemButton(
            onPressed: () {
              widget.onChanged(km);
              _menuController.close();
            },
            style: ButtonStyle(
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
              ),
              minimumSize: WidgetStateProperty.all(Size(menuWidth, 0)),
              maximumSize: WidgetStateProperty.all(Size(menuWidth, 48)),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.hovered) ||
                    states.contains(WidgetState.focused)) {
                  return const Color(0xFFE8EDF3);
                }
                return Colors.transparent;
              }),
            ),
            child: SizedBox(
              width: menuWidth - 12,
              child: Text(
                formatSearchRadiusKm(km),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.bodyMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: km == widget.radiusKm
                      ? FontWeight.w700
                      : FontWeight.w500,
                  color: AppColors.darkBlue800,
                ),
              ),
            ),
          ),
      ],
      builder: (context, controller, child) {
        final open = controller.isOpen;
        return Material(
          key: _buttonKey,
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            onTap: () => open ? controller.close() : controller.open(),
            child: Container(
              height: widget.height,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(color: AppColors.darkBlue200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    formatSearchRadiusKm(widget.radiusKm),
                    style: theme.bodyMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkBlue800,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Icon(
                    open ? Icons.expand_less : Icons.expand_more,
                    size: 20,
                    color: AppColors.gray900.withValues(alpha: 0.65),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
