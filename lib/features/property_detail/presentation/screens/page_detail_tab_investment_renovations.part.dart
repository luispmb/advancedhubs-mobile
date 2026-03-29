part of 'page_detail_tab_investment_screen.dart';

/// Conteúdo do tab Obras (Page Detail - Tab Renovations).
class _RenovationsContent extends StatelessWidget {
  const _RenovationsContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      color: AppColors.purple100,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _MockRenovationsData.softCostsTitle,
            style: theme.labelLarge?.copyWith(
              fontSize: 16,
              color: AppColors.darkBlue600,
            ),
          ),
          const SizedBox(height: 12),
          ..._MockRenovationsData.softCosts.map(
            (g) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _RenovationExpandableCard(group: g),
            ),
          ),
          Text(
            _MockRenovationsData.hardCostsTitle,
            style: theme.labelLarge?.copyWith(
              fontSize: 16,
              color: AppColors.darkBlue600,
            ),
          ),
          const SizedBox(height: 12),
          ..._MockRenovationsData.hardCosts.map(
            (g) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _RenovationExpandableCard(group: g),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Estimado',
                  style: theme.labelLarge?.copyWith(
                    fontSize: 16,
                    color: AppColors.darkBlue600,
                  ),
                ),
                Text(
                  _MockRenovationsData.totalEstimado,
                  style: theme.headlineMedium?.copyWith(
                    fontSize: 18,
                    color: AppColors.darkBlue600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: GestureDetector(
              onTap: () {},
              child: Text(
                _MockRenovationsData.verGuiaLabel,
                style: theme.labelLarge?.copyWith(
                  fontSize: 14,
                  color: AppColors.purple600,
                ),
              ),
            ),
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
                    _MockRenovationsData.disclaimer,
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

class _RenovationExpandableCard extends StatefulWidget {
  const _RenovationExpandableCard({required this.group});

  final _RenovationGroup group;

  @override
  State<_RenovationExpandableCard> createState() =>
      _RenovationExpandableCardState();
}

class _RenovationExpandableCardState extends State<_RenovationExpandableCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final g = widget.group;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Row(
                  children: [
                    Icon(g.icon, size: 18, color: AppColors.darkBlue600),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        g.title,
                        style: theme.labelLarge?.copyWith(
                          fontSize: 14,
                          color: AppColors.darkBlue600,
                        ),
                      ),
                    ),
                    Text(
                      g.totalRange,
                      style: theme.bodyMedium?.copyWith(
                        fontSize: 14,
                        color: AppColors.darkBlue600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      _expanded ? Icons.expand_less : Icons.expand_more,
                      size: 20,
                      color: AppColors.darkBlue600,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_expanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Column(
                children: [
                  for (int i = 0; i < g.items.length; i++) ...[
                    if (i > 0) const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            g.items[i].label,
                            style: theme.bodyMedium?.copyWith(
                              fontSize: 14,
                              color: AppColors.darkBlue600,
                            ),
                          ),
                        ),
                        Text(
                          g.items[i].range,
                          style: theme.bodyMedium?.copyWith(
                            fontSize: 14,
                            color: AppColors.darkBlue600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
