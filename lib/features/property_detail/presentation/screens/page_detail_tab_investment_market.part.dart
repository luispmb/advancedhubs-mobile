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
          _MarketSaleEstimateCard(
            valor: _MockMarketData.estimativaVenda,
            perM2: _MockMarketData.estimativaPerM2,
            medianaLabel: _MockMarketData.medianaLabel,
            range: _MockMarketData.rangeEstimado,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _InfoCard(
                  label: 'Preço médio',
                  value: _MockMarketData.precoMedio,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _InfoCard(
                  label: 'Absorção',
                  value: _MockMarketData.absorcao,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _InfoCard(
                  label: 'Amostra',
                  value: _MockMarketData.amostra,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _InfoCard(
                  label: 'Desconto',
                  value: _MockMarketData.desconto,
                ),
              ),
            ],
          ),
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
                const Icon(Icons.analytics_outlined, size: 18, color: AppColors.darkBlue600),
                const SizedBox(width: 4),
                Text(
                  'Análise de Preço',
                  style: theme.labelLarge?.copyWith(
                    fontSize: 14,
                    color: AppColors.darkBlue600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Preço pedido',
                            style: theme.labelLarge?.copyWith(
                              fontSize: 12,
                              color: AppColors.gray1000,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            precoPedido,
                            style: theme.headlineMedium?.copyWith(
                              fontSize: 18,
                              color: AppColors.darkBlue600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Média zona',
                            style: theme.labelLarge?.copyWith(
                              fontSize: 12,
                              color: AppColors.gray1000,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            mediaZona,
                            style: theme.headlineMedium?.copyWith(
                              fontSize: 18,
                              color: AppColors.darkBlue600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4.5),
                  decoration: BoxDecoration(
                    color: AppColors.roiGreenBg,
                    border: Border.all(color: AppColors.roiGreenBorder),
                    borderRadius: BorderRadius.circular(4.5),
                  ),
                  child: Text(
                    badge,
                    style: theme.labelLarge?.copyWith(
                      fontSize: 11,
                      color: AppColors.roiGreen,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  resumo,
                  style: theme.bodyMedium?.copyWith(
                    fontSize: 13,
                    color: AppColors.gray1000,
                    height: 1.3,
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

class _MarketSaleEstimateCard extends StatelessWidget {
  const _MarketSaleEstimateCard({
    required this.valor,
    required this.perM2,
    required this.medianaLabel,
    required this.range,
  });

  final String valor;
  final String perM2;
  final String medianaLabel;
  final String range;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
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
                const Icon(Icons.sell_outlined, size: 18, color: AppColors.darkBlue600),
                const SizedBox(width: 4),
                Text(
                  'Estimativa de Venda Pós-renovação',
                  style: theme.labelLarge?.copyWith(
                    fontSize: 14,
                    color: AppColors.darkBlue600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      valor,
                      style: theme.headlineMedium?.copyWith(
                        fontSize: 24,
                        color: AppColors.darkBlue600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      perM2,
                      style: theme.bodyMedium?.copyWith(
                        fontSize: 14,
                        color: AppColors.darkBlue600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  medianaLabel,
                  style: theme.bodyMedium?.copyWith(
                    fontSize: 12,
                    color: AppColors.gray1000,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.purple100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Range Estimado',
                        style: theme.labelLarge?.copyWith(
                          fontSize: 12,
                          color: AppColors.gray1000,
                        ),
                      ),
                      Text(
                        range,
                        style: theme.labelLarge?.copyWith(
                          fontSize: 14,
                          color: AppColors.darkBlue600,
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
    );
  }
}
