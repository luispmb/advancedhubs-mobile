part of 'page_detail_tab_investment_screen.dart';

class _InvestmentContent extends StatelessWidget {
  const _InvestmentContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.purple100,
      padding: const EdgeInsets.all(16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _InvestmentCardsGrid(),
          SizedBox(height: 16),
          _CapitalDistributionSection(),
          SizedBox(height: 16),
          _DisclaimerBox(text: _MockDetailData.disclaimer),
        ],
      ),
    );
  }
}
class _InvestmentCardsGrid extends StatelessWidget {
  const _InvestmentCardsGrid();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: _InfoCard(label: 'Preço de Compra', value: _MockDetailData.purchasePrice)),
            SizedBox(width: 16),
            Expanded(child: _InfoCard(label: 'Custo Total', value: _MockDetailData.totalCost)),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _InfoCard(label: 'Venda Estimada', value: _MockDetailData.estimatedSale)),
            SizedBox(width: 16),
            Expanded(child: _InfoCard(label: 'ROI Esperado', value: _MockDetailData.expectedRoi)),
          ],
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
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
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 12,
                  color: AppColors.gray1000,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 18,
                  color: AppColors.darkBlue600,
                ),
          ),
        ],
      ),
    );
  }
}

class _CapitalDistributionSection extends StatelessWidget {
  const _CapitalDistributionSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: const Border(
          bottom: BorderSide(color: AppColors.darkBlue200, width: 0.5),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Icon(Icons.savings_outlined, size: 18, color: AppColors.darkBlue600),
                const SizedBox(width: 4),
                Text(
                  'Distribuição de Capital',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 14,
                        color: AppColors.darkBlue600,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
            child: Column(
              children: [
                const SizedBox(
                  height: 228,
                  child: Center(
                    child: _DonutChart(
                      totalLabel: _MockDetailData.capitalTotal,
                      segments: _MockDetailData.capitalSegments,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: _MockDetailData.capitalSegments
                      .map(
                        (s) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 9,
                              height: 9,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: s.color,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              s.label,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DonutChart extends StatelessWidget {
  const _DonutChart({
    required this.totalLabel,
    required this.segments,
  });

  final String totalLabel;
  final List<CapitalSegment> segments;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = math.min(math.min(constraints.maxWidth, constraints.maxHeight), 228.0);
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(size, size),
                painter: _DonutChartPainter(segments: segments),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    totalLabel,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: 18,
                          color: AppColors.darkBlue600,
                        ),
                  ),
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: AppColors.gray900,
                        ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  _DonutChartPainter({required this.segments});

  final List<CapitalSegment> segments;

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 24.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.shortestSide / 2) - strokeWidth / 2;
    double startAngle = -math.pi / 2;
    for (final s in segments) {
      final sweepAngle = 2 * math.pi * s.percent;
      final paint = Paint()
        ..color = s.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DisclaimerBox extends StatelessWidget {
  const _DisclaimerBox({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    color: Colors.black,
                    height: 1.3,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
