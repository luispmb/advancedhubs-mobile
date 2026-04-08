import 'package:flutter/material.dart';

import '../../../../core/localization/app_locale_controller.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';

/// Caminho do logo para o drawer (reutilizar o do FAB).
const String _logoAsset = 'assets/images/Screenshot 2026-03-11 at 18.21.48.png';
const String _calculatorAsset = 'assets/images/calculate.png';

/// Barra lateral: marca, navegação e alternância PT/EN.
class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _searchExpanded = false;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final isEn = Localizations.localeOf(context).languageCode.toLowerCase().startsWith('en');
    return Drawer(
      backgroundColor: AppColors.darkBlue800,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DrawerHeader(
              brandName: l.appBrandName,
              onClose: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 24),
            _DrawerExpandableItem(
              icon: Icons.home_outlined,
              label: l.drawerPropertySearch,
              expanded: _searchExpanded,
              onTap: () => setState(() => _searchExpanded = !_searchExpanded),
            ),
            if (_searchExpanded)
              _DrawerItem(
                icon: Icons.favorite_border,
                label: l.drawerFavorites,
                indent: 28,
                onTap: () => Navigator.of(context).pop(),
              ),
            _DrawerItem(
              iconAssetPath: _calculatorAsset,
              label: l.drawerCreditSimulator,
              onTap: () => Navigator.of(context).pop(),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: SizedBox(
                height: 52,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.purple600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    l.subscribe,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.language, color: AppColors.white, size: 24),
              title: Text(
                isEn ? l.languageLabelPortuguese : l.languageLabelEnglish,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              onTap: () {
                AppLocaleController.togglePtEn();
                Navigator.of(context).pop();
              },
            ),
            Divider(height: 1, color: AppColors.white.withValues(alpha: 0.24)),
            _DrawerItem(
              icon: Icons.person_outline,
              label: l.drawerMyAccount,
              onTap: () => Navigator.of(context).pop(),
            ),
            _DrawerItem(
              icon: Icons.help_outline,
              label: l.drawerHelp,
              onTap: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    required this.brandName,
    required this.onClose,
  });

  final String brandName;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 12, 16),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              _logoAsset,
              width: 36,
              height: 36,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.smart_toy_outlined,
                color: AppColors.white,
                size: 36,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            brandName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.menu_open, color: AppColors.white, size: 24),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    this.icon,
    this.iconAssetPath,
    required this.label,
    required this.onTap,
    this.indent = 0,
  });

  final IconData? icon;
  final String? iconAssetPath;
  final String label;
  final VoidCallback onTap;
  final double indent;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 16 + indent, right: 16),
      leading: iconAssetPath != null
          ? Image.asset(
              iconAssetPath!,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.calculate_outlined, color: AppColors.white, size: 24),
            )
          : Icon(icon, color: AppColors.white, size: 24),
      title: Text(
        label,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w500,
            ),
      ),
      onTap: onTap,
    );
  }
}

class _DrawerExpandableItem extends StatelessWidget {
  const _DrawerExpandableItem({
    required this.icon,
    required this.label,
    required this.expanded,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.white, size: 24),
      title: Text(
        label,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w500,
            ),
      ),
      trailing: Icon(
        expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
        color: AppColors.white,
      ),
      onTap: onTap,
    );
  }
}
