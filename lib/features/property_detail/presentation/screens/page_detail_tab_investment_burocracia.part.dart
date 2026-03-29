part of 'page_detail_tab_investment_screen.dart';

/// Conteúdo do tab Burocracia (Page Detail - Tab Burocracia).
class _BurocraciaContent extends StatelessWidget {
  const _BurocraciaContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      color: AppColors.purple100,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _BurocraciaCard(
            type: _BurocraciaCardType.warning,
            title: _MockBurocraciaData.semLicencaTitle,
            text: _MockBurocraciaData.semLicencaText,
            icon: Icons.warning_amber_rounded,
          ),
          const SizedBox(height: 16),
          _BurocraciaCard(
            type: _BurocraciaCardType.success,
            title: _MockBurocraciaData.aruTitle,
            text: _MockBurocraciaData.aruText,
            icon: Icons.check_circle_outline,
          ),
          const SizedBox(height: 16),
          _BurocraciaCard(
            type: _BurocraciaCardType.neutral,
            title: _MockBurocraciaData.viabilidadeTitle,
            text: _MockBurocraciaData.viabilidadeText,
            icon: Icons.description_outlined,
            badge: _MockBurocraciaData.viabilidadeBadge,
          ),
          const SizedBox(height: 16),
          _BurocraciaTimelineCard(
            title: _MockBurocraciaData.timelineTitle,
            items: _MockBurocraciaData.timelineItems,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.infoBoxBg,
              border: Border.all(color: AppColors.infoBoxBorder),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline, size: 16, color: AppColors.darkBlue600),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    _MockBurocraciaData.disclaimer,
                    style: theme.bodyMedium?.copyWith(
                      fontSize: 12,
                      color: Colors.black,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum _BurocraciaCardType { warning, success, neutral }

class _BurocraciaCard extends StatelessWidget {
  const _BurocraciaCard({
    required this.type,
    required this.title,
    required this.text,
    required this.icon,
    this.badge,
  });

  final _BurocraciaCardType type;
  final String title;
  final String text;
  final IconData icon;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final (bg, border, iconColor) = switch (type) {
      _BurocraciaCardType.warning => (
          AppColors.warningBg,
          AppColors.warningBorder,
          const Color(0xFFB38600),
        ),
      _BurocraciaCardType.success => (
          AppColors.successCardBg,
          AppColors.successCardBorder,
          AppColors.roiGreen,
        ),
      _BurocraciaCardType.neutral => (
          AppColors.white,
          AppColors.darkBlue200,
          AppColors.darkBlue600,
        ),
    };
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 22, color: iconColor),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.labelLarge?.copyWith(
                        fontSize: 14,
                        color: AppColors.darkBlue600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      text,
                      style: theme.bodyMedium?.copyWith(
                        fontSize: 13,
                        color: AppColors.gray1000,
                        height: 1.3,
                      ),
                    ),
                    if (badge != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.roiGreenBg,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          badge!,
                          style: theme.labelLarge?.copyWith(
                            fontSize: 12,
                            color: AppColors.roiGreen,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BurocraciaTimelineCard extends StatelessWidget {
  const _BurocraciaTimelineCard({
    required this.title,
    required this.items,
  });

  final String title;
  final List<_BurocraciaTimelineItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.darkBlue200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 20, color: AppColors.darkBlue600),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.labelLarge?.copyWith(
                  fontSize: 14,
                  color: AppColors.darkBlue600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      e.label,
                      style: theme.bodyMedium?.copyWith(
                        fontSize: 14,
                        color: AppColors.darkBlue600,
                      ),
                    ),
                  ),
                  Text(
                    e.duration,
                    style: theme.bodyMedium?.copyWith(
                      fontSize: 14,
                      color: AppColors.darkBlue600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
