import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../search/presentation/screens/page_search_list_screen.dart';

class SubscriptionOfferScreen extends StatefulWidget {
  const SubscriptionOfferScreen({super.key});

  @override
  State<SubscriptionOfferScreen> createState() => _SubscriptionOfferScreenState();
}

class _SubscriptionOfferScreenState extends State<SubscriptionOfferScreen> {
  bool _annualSelected = true;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: const Color(0xFF1D1F42),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              Image.asset(
                'assets/images/image 1.png',
                height: 110,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
              const SizedBox(height: 14),
              Text(
                l.subscribeTitle,
                textAlign: TextAlign.center,
                style: theme.headlineMedium?.copyWith(
                  color: AppColors.white,
                  fontSize: 42 / 2,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                l.subscribeSubtitle,
                textAlign: TextAlign.center,
                style: theme.bodyMedium?.copyWith(
                  color: AppColors.white,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 18),
              _Benefit(text: l.benefitTopDeals),
              _Benefit(text: l.benefitReports),
              _Benefit(text: l.benefitSimulator),
              _Benefit(text: l.benefitChat),
              const Spacer(),
              _PlanCard(
                selected: _annualSelected,
                title: l.annualPlanTitle,
                subtitle: l.annualPlanSubtitle,
                badge: _annualSelected ? '16% OFF' : null,
                onTap: () => setState(() => _annualSelected = true),
              ),
              const SizedBox(height: 10),
              _PlanCard(
                selected: !_annualSelected,
                title: l.monthlyPlanTitle,
                subtitle: l.monthlyPlanSubtitle,
                onTap: () => setState(() => _annualSelected = false),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute<void>(
                      builder: (_) => const PageSearchListScreen(),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A98A5),
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                    l.subscribe,
                  style: theme.labelLarge?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute<void>(
                      builder: (_) =>
                          const PageSearchListScreen(showTrialBanner: true),
                    ),
                    (route) => false,
                  );
                },
                child: Text(
                  l.continueTrial,
                  textAlign: TextAlign.center,
                  style: theme.labelLarge?.copyWith(
                    color: AppColors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l.legalConsent,
                textAlign: TextAlign.center,
                style: theme.bodySmall?.copyWith(
                  color: AppColors.white.withValues(alpha: 0.9),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Benefit extends StatelessWidget {
  const _Benefit({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check, color: AppColors.teal600, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.selected,
    required this.title,
    required this.subtitle,
    this.badge,
    required this.onTap,
  });

  final bool selected;
  final String title;
  final String subtitle;
  final String? badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = selected ? AppColors.white : AppColors.white.withValues(alpha: 0.35);
    final textColor = selected ? AppColors.white : AppColors.white.withValues(alpha: 0.5);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: EdgeInsets.fromLTRB(16, badge != null ? 22 : 16, 16, 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: textColor,
                                fontSize: 14,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: borderColor, width: 2),
                    ),
                    child: selected
                        ? Center(
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (badge != null)
          Positioned(
            right: 52,
            top: -10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge!,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 10,
                      color: AppColors.darkBlue800,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
          ),
      ],
    );
  }
}
