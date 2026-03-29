import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/localization/app_localizations.dart';
import 'create_account_screen.dart';
import 'login_screen.dart';

class OnboardingWelcomeScreen extends StatelessWidget {
  const OnboardingWelcomeScreen({super.key});

  static const String _cornerLogoA = 'assets/images/Logo Icon.png';
  static const String _cornerLogoB = 'assets/images/Logo Icon-2.png';

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.purple100, // #F3F3F7
      body: Stack(
        children: [
          const Positioned(
            top: 0,
            right: -8,
            child: _CornerSymbol(
              assetPath: _cornerLogoB,
              width: 190,
              opacity: 0.3,
            ),
          ),
          const Positioned(
            left: 0,
            bottom: 0,
            child: _CornerSymbol(
              assetPath: _cornerLogoA,
              width: 210,
              opacity: 0.3,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(flex: 5),
                  Text(
                    l.onboardingTitle,
                    textAlign: TextAlign.center,
                    style: theme.headlineMedium?.copyWith(
                      fontSize: 26,
                      height: 1.05,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkBlue800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l.onboardingSubtitle,
                    textAlign: TextAlign.center,
                    style: theme.bodyMedium?.copyWith(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    l.tryFreeTrial,
                    textAlign: TextAlign.center,
                    style: theme.labelLarge?.copyWith(
                      fontSize: 14,
                      color: AppColors.darkBlue800,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const CreateAccountScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A98A5),
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Text(
                        l.getStarted,
                        style: theme.labelLarge?.copyWith(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      l.alreadyHaveAccount,
                      style: theme.bodyMedium?.copyWith(
                        fontSize: 14,
                        color: AppColors.purple600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(flex: 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CornerSymbol extends StatelessWidget {
  const _CornerSymbol({
    required this.assetPath,
    required this.width,
    required this.opacity,
  });

  final String assetPath;
  final double width;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    // Escurece ligeiramente o PNG para contrastar com #F3F3F7
    return Opacity(
      opacity: opacity,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          AppColors.purple800.withValues(alpha: 0.35),
          BlendMode.srcATop,
        ),
        child: Image.asset(
          assetPath,
          width: width,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
        ),
      ),
    );
  }
}
