part of 'page_detail_tab_investment_screen.dart';

class _InvestmentContent extends StatelessWidget {
  const _InvestmentContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.purple100,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _InvestmentSummaryCards(),
          const SizedBox(height: 16),
          const _ProjectDurationCard(),
          const SizedBox(height: 16),
          _ProjectVisionCard(),
          const _TabsBottomActionsInline(),
        ],
      ),
    );
  }
}

class _InvestmentSummaryCards extends StatelessWidget {
  const _InvestmentSummaryCards();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _PurchaseMetricCard(
                  label: 'Preço de Compra',
                  value: _MockDetailData.purchasePrice,
                  change: _MockDetailData.roiPercent,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: _SimpleMetricCard(
                  label: 'Custo Total do Projeto',
                  value: _MockDetailData.totalCost,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _SalesMetricCard(
                  label: 'Venda Estimada',
                  value: _MockDetailData.estimatedSale,
                  timeHint: _MockDetailData.estimatedSaleTime,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: _SimpleMetricCard(
                  label: 'ROI Esperado',
                  value: _MockDetailData.expectedRoi,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SimpleMetricCard extends StatelessWidget {
  const _SimpleMetricCard({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.bodySmall?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.gray1000,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: theme.headlineMedium?.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.darkBlue600,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _PurchaseMetricCard extends StatelessWidget {
  const _PurchaseMetricCard({
    required this.label,
    required this.value,
    required this.change,
  });

  final String label;
  final String value;
  final String change;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    const changeColor = AppColors.roiGreen;

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.bodySmall?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.gray1000,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: theme.headlineMedium?.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.darkBlue600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.trending_up,
                size: 16,
                color: changeColor,
              ),
              const SizedBox(width: 4),
              Text(
                change,
                style: theme.bodySmall?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: changeColor,
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _SalesMetricCard extends StatelessWidget {
  const _SalesMetricCard({
    required this.label,
    required this.value,
    required this.timeHint,
  });

  final String label;
  final String value;
  final String timeHint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.bodySmall?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.gray1000,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: theme.headlineMedium?.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.darkBlue600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            timeHint,
            style: theme.bodySmall?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.gray900.withValues(alpha: 0.85),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

/// Widget reutilizado pelos outros parts deste ecrã (ex.: tab Mercado).
class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.labelLarge?.copyWith(
              fontSize: 12,
              color: AppColors.gray1000,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.headlineMedium?.copyWith(
              fontSize: 18,
              color: AppColors.darkBlue600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectDurationCard extends StatelessWidget {
  const _ProjectDurationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.timer_outlined,
                  size: 20, color: AppColors.purple600),
              const SizedBox(width: 8),
              Text(
                'Duração do Projeto',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.purple800,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 98,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 22,
                  left: 42,
                  right: 42,
                  child: Container(
                    height: 2,
                    color: AppColors.gray700,
                    width: double.infinity,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _DurationStep(
                        assetPath: 'assets/images/payments.png',
                        title: 'Compra',
                        value: 'Mês 0',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _DurationStep(
                        icon: Icons.build_outlined,
                        title: 'Obras',
                        value: '6 meses',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _DurationStep(
                        assetPath: 'assets/images/real_estate_agent.png',
                        title: 'Venda',
                        value: '+2 meses',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DurationStep extends StatelessWidget {
  const _DurationStep({
    this.icon,
    this.assetPath,
    required this.title,
    required this.value,
  });

  final IconData? icon;
  final String? assetPath;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            color: AppColors.purple200,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: assetPath != null
                ? Image.asset(
                    assetPath!,
                    width: 22,
                    height: 22,
                    fit: BoxFit.contain,
                  )
                : Icon(
                    icon,
                    size: 22,
                    color: AppColors.purple600,
                  ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: theme.bodySmall?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.gray1000,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          textAlign: TextAlign.center,
          style: theme.bodyLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.darkBlue600,
          ),
        ),
      ],
    );
  }
}

class _ProjectVisionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_outline,
                  size: 20, color: AppColors.purple600),
              const SizedBox(width: 8),
              Text(
                _MockDetailData.projectVisionTitle,
                style: theme.labelLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.purple800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.gray700),
          const SizedBox(height: 12),
          Text(
            _MockDetailData.projectVisionText,
            style: theme.bodyMedium?.copyWith(
              fontSize: 14,
              color: AppColors.gray1000,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
