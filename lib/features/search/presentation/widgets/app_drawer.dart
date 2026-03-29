import 'package:flutter/material.dart';

import '../../../../core/localization/app_locale_controller.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';

/// Caminho do logo para o drawer (reutilizar o do FAB).
const String _logoAsset = 'assets/images/Screenshot 2026-03-11 at 18.21.48.png';

/// Barra lateral: logo CASAGPT, navegação e alternância PT/EN.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

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
            _DrawerHeader(onClose: () => Navigator.of(context).pop()),
            const SizedBox(height: 24),
            _DrawerItem(
              icon: Icons.home_outlined,
              label: l.drawerPropertySearch,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            _DrawerItem(
              icon: Icons.place_outlined,
              label: l.drawerCreditSimulator,
              onTap: () => Navigator.of(context).pop(),
            ),
            _DrawerItem(
              icon: Icons.favorite_border,
              label: l.drawerFavorites,
              onTap: () => Navigator.of(context).pop(),
            ),
            const Spacer(),
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
  const _DrawerHeader({required this.onClose});

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
            'CASAGPT',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
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
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
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
      onTap: onTap,
    );
  }
}
