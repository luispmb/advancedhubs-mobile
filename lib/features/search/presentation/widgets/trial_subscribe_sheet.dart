import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';

/// Bottom sheet branco com planos (após «Subscrever agora» no banner de trial).
Future<void> showTrialSubscribeSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.45),
    builder: (ctx) {
      return SizedBox(
        height: MediaQuery.sizeOf(ctx).height,
        child: const _TrialSubscribeSheetBody(),
      );
    },
  );
}

class _TrialSubscribeSheetBody extends StatefulWidget {
  const _TrialSubscribeSheetBody();

  @override
  State<_TrialSubscribeSheetBody> createState() =>
      _TrialSubscribeSheetBodyState();
}

class _TrialSubscribeSheetBodyState extends State<_TrialSubscribeSheetBody> {
  bool _annualSelected = true;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context).textTheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.72,
      minChildSize: 0.45,
      maxChildSize: 0.92,
      expand: false,
      builder: (context, scrollController) {
        return DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.fromLTRB(
              20,
              10,
              20,
              20 + MediaQuery.paddingOf(context).bottom,
            ),
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: AppColors.gray700.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                l.trialEnds2Days,
                style: theme.headlineMedium?.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkBlue800,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l.subscribeKeepAccess,
                style: theme.bodyMedium?.copyWith(
                  fontSize: 15,
                  color: AppColors.gray1000,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                l.choosePlan,
                style: theme.labelLarge?.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.gray1000,
                ),
              ),
              const SizedBox(height: 14),
              _LightPlanCard(
                selected: _annualSelected,
                title: l.annualPlanTitle,
                subtitle: l.annualPlanSubtitle,
                badge: _annualSelected ? '16% OFF' : null,
                onTap: () => setState(() => _annualSelected = true),
              ),
              const SizedBox(height: 12),
              _LightPlanCard(
                selected: !_annualSelected,
                title: l.monthlyPlanTitle,
                subtitle: l.monthlyPlanSubtitle,
                onTap: () => setState(() => _annualSelected = false),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.darkBlue800,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    l.subscribe,
                    style: theme.labelLarge?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l.legalConsentAlt,
                textAlign: TextAlign.center,
                style: theme.bodySmall?.copyWith(
                  fontSize: 11,
                  color: AppColors.gray900,
                  height: 1.35,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LightPlanCard extends StatelessWidget {
  const _LightPlanCard({
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
    final theme = Theme.of(context).textTheme;
    final borderColor =
        selected ? AppColors.purple600 : AppColors.gray700.withValues(alpha: 0.5);
    final titleColor =
        selected ? AppColors.darkBlue800 : AppColors.gray900.withValues(alpha: 0.55);
    final subtitleColor =
        selected ? AppColors.darkBlue600 : AppColors.gray900.withValues(alpha: 0.45);

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
                border: Border.all(color: borderColor, width: selected ? 2 : 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.headlineMedium?.copyWith(
                            color: titleColor,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: theme.bodyMedium?.copyWith(
                            color: subtitleColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected ? AppColors.purple600 : borderColor,
                        width: 2,
                      ),
                    ),
                    child: selected
                        ? Center(
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color: AppColors.purple600,
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
            right: 48,
            top: -9,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.purple600,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge!,
                style: theme.labelLarge?.copyWith(
                  fontSize: 10,
                  color: AppColors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
