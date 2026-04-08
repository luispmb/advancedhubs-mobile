part of 'page_detail_tab_investment_screen.dart';

/// Conteúdo do tab Mercado (Page Detail - Tab Market).
class _MarketContent extends StatelessWidget {
  const _MarketContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.purple100,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _MarketPriceAnalysisCard(
            precoPedido: _MockMarketData.precoPedido,
            mediaZona: _MockMarketData.mediaZona,
            badge: _MockMarketData.abaixoMediaBadge,
            resumo: _MockMarketData.analiseResumo,
          ),
          const SizedBox(height: 16),
          _MarketSampleCriteriaCard(
            sampleCount: _MockMarketData.amostra,
            radius: _MockMarketData.raio,
            criteriosTipologia: _MockMarketData.criteriosTipologia,
            criteriosArea: _MockMarketData.criteriosArea,
            criteriosEstado: _MockMarketData.criteriosEstado,
            criteriosVendidos: _MockMarketData.criteriosVendidos,
            dadosRecolhidosHint: _MockMarketData.dadosRecolhidosHint,
          ),
          const SizedBox(height: 16),
          _MarketPostRenovationEstimateCard(
            estimativaVenda: _MockMarketData.estimativaVenda,
            estimativaPerM2: _MockMarketData.estimativaPerM2,
            medianaLabel: _MockMarketData.medianaLabel,
            rangeEstimado: _MockMarketData.rangeEstimado,
            precoMedio: _MockMarketData.precoMedio,
            absorcao: _MockMarketData.absorcao,
            amostra: _MockMarketData.amostra,
            desconto: _MockMarketData.desconto,
          ),
          const _TabsBottomActionsInline(),
        ],
      ),
    );
  }
}

class _MarketPriceAnalysisCard extends StatelessWidget {
  const _MarketPriceAnalysisCard({
    required this.precoPedido,
    required this.mediaZona,
    required this.badge,
    required this.resumo,
  });

  final String precoPedido;
  final String mediaZona;
  final String badge;
  final String resumo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.purple200,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.info_outline,
                      size: 18,
                      color: AppColors.purple600,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Análise de Preço',
                  style: theme.titleLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.darkBlue600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Preço Pedido',
                        style: theme.bodySmall?.copyWith(
                          fontSize: 14,
                          color: AppColors.gray900,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        precoPedido,
                        style: theme.headlineMedium?.copyWith(
                          fontSize: 26,
                          color: AppColors.darkBlue600,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Média Zona',
                        style: theme.bodySmall?.copyWith(
                          fontSize: 14,
                          color: AppColors.gray900,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        mediaZona,
                        style: theme.headlineMedium?.copyWith(
                          fontSize: 26,
                          color: AppColors.darkBlue600,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.roiGreenBg,
                  border: Border.all(color: AppColors.roiGreenBorder),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  badge,
                  style: theme.bodySmall?.copyWith(
                    fontSize: 14,
                    color: AppColors.roiGreen,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              resumo,
              style: theme.bodyMedium?.copyWith(
                fontSize: 15,
                color: AppColors.gray1000,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MarketSampleCriteriaCard extends StatelessWidget {
  const _MarketSampleCriteriaCard({
    required this.sampleCount,
    required this.radius,
    required this.criteriosTipologia,
    required this.criteriosArea,
    required this.criteriosEstado,
    required this.criteriosVendidos,
    required this.dadosRecolhidosHint,
  });

  final String sampleCount;
  final String radius;
  final String criteriosTipologia;
  final String criteriosArea;
  final String criteriosEstado;
  final String criteriosVendidos;
  final String dadosRecolhidosHint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.purple200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(
                    Icons.tune_outlined,
                    size: 18,
                    color: AppColors.purple600,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                _MockMarketData.amostraUtilizadaTitle,
                style: theme.titleLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkBlue600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _MarketStatBox(
                  value: sampleCount,
                  label: _MockMarketData.amostraCountLabel,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _MarketStatBox(
                  value: radius,
                  label: _MockMarketData.radiusLabel,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            decoration: BoxDecoration(
              color: AppColors.neutralLightGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _MockMarketData.criteriosTitle,
                  style: theme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.gray1000,
                  ),
                ),
                const SizedBox(height: 12),
                _CriteriaLine(text: criteriosTipologia),
                _CriteriaLine(text: criteriosArea),
                _CriteriaLine(text: criteriosEstado),
                _CriteriaLine(text: criteriosVendidos),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            dadosRecolhidosHint,
            style: theme.bodySmall?.copyWith(
              fontSize: 13,
              color: AppColors.gray900.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }
}

class _MarketStatBox extends StatelessWidget {
  const _MarketStatBox({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.purple200.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: theme.headlineMedium?.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.darkBlue600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: theme.bodySmall?.copyWith(
              fontSize: 14,
              color: AppColors.gray900,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _CriteriaLine extends StatelessWidget {
  const _CriteriaLine({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check, size: 20, color: AppColors.roiGreen),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: theme.bodyMedium?.copyWith(
                fontSize: 15,
                color: AppColors.gray1000,
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MarketPostRenovationEstimateCard extends StatelessWidget {
  const _MarketPostRenovationEstimateCard({
    required this.estimativaVenda,
    required this.estimativaPerM2,
    required this.medianaLabel,
    required this.rangeEstimado,
    required this.precoMedio,
    required this.absorcao,
    required this.amostra,
    required this.desconto,
  });

  final String estimativaVenda;
  final String estimativaPerM2;
  final String medianaLabel;
  final String rangeEstimado;
  final String precoMedio;
  final String absorcao;
  final String amostra;
  final String desconto;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                child: Row(
                  children: [
                    const Icon(
                      Icons.sell_outlined,
                      size: 22,
                      color: AppColors.purple600,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Estimativa de Venda Pós-renovação',
                        style: theme.titleLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.darkBlue600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.gray600),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          estimativaVenda,
                          style: theme.headlineMedium?.copyWith(
                            fontSize: 46 / 2,
                            color: AppColors.darkBlue600,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          estimativaPerM2.replaceFirst('/', '').trim(),
                          style: theme.bodyMedium?.copyWith(
                            fontSize: 24 / 2,
                            color: AppColors.darkBlue600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      medianaLabel,
                      textAlign: TextAlign.center,
                      style: theme.bodyMedium?.copyWith(
                        fontSize: 14,
                        color: AppColors.gray1000,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.neutralLightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Range Estimado',
                            style: theme.bodyMedium?.copyWith(
                              fontSize: 15,
                              color: AppColors.gray1000,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            rangeEstimado,
                            style: theme.bodyMedium?.copyWith(
                              fontSize: 17,
                              color: AppColors.darkBlue600,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _MarketStatTile(title: 'Preço médio', value: precoMedio)),
            const SizedBox(width: 10),
            Expanded(child: _MarketStatTile(title: 'Tempo de Absorção', value: absorcao)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _MarketStatTile(title: 'Amostra', value: amostra)),
            const SizedBox(width: 10),
            Expanded(child: _MarketStatTile(title: 'Desconto', value: desconto)),
          ],
        ),
      ],
    );
  }
}

class _MarketStatTile extends StatelessWidget {
  const _MarketStatTile({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.gray600),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.bodySmall?.copyWith(
              fontSize: 14,
              color: AppColors.gray1000,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.headlineMedium?.copyWith(
              fontSize: 48 / 2,
              color: AppColors.darkBlue600,
              fontWeight: FontWeight.w800,
              letterSpacing: 0,
              height: 1.05,
            ),
          ),
        ],
      ),
    );
  }
}
