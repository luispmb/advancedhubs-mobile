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
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.darkBlue600,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Text(
                  'Total Estimado',
                  style: theme.labelLarge?.copyWith(
                    fontSize: 16,
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  _MockRenovationsData.totalEstimado,
                  style: theme.headlineMedium?.copyWith(
                    fontSize: 17,
                    color: AppColors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const _FinishesGuideScreen(),
                  ),
                );
              },
              child: Text(
                _MockRenovationsData.verGuiaLabel,
                style: theme.labelLarge?.copyWith(
                  fontSize: 15,
                  color: AppColors.darkBlue600,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.darkBlue600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF5FCFF),
              border: Border.all(color: const Color(0xFF75B9FF), width: 1.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(
                    Icons.info_outline,
                    size: 24,
                    color: Color(0xFF0D83E8),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _MockRenovationsData.disclaimer,
                    style: theme.bodyMedium?.copyWith(
                      fontSize: 17,
                      color: AppColors.darkBlue600,
                      height: 1.25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const _TabsBottomActionsInline(),
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
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.group.initiallyExpanded;
  }

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
                    _RenovationGroupIcon(group: g),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        g.title,
                        style: theme.labelLarge?.copyWith(
                          fontSize: 17,
                          color: AppColors.darkBlue600,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      g.totalRange,
                      style: theme.bodyMedium?.copyWith(
                        fontSize: 15,
                        color: AppColors.darkBlue600,
                        fontWeight: FontWeight.w600,
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
                    if (i > 0) const Divider(height: 14, color: AppColors.gray600),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            g.items[i].label,
                            style: theme.bodyMedium?.copyWith(
                              fontSize: 15,
                              color: AppColors.darkBlue600,
                            ),
                          ),
                        ),
                        Text(
                          g.items[i].range,
                          style: theme.bodyMedium?.copyWith(
                            fontSize: 15,
                            color: AppColors.darkBlue600,
                            fontWeight: FontWeight.w700,
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

class _RenovationGroupIcon extends StatelessWidget {
  const _RenovationGroupIcon({required this.group});

  final _RenovationGroup group;

  @override
  Widget build(BuildContext context) {
    if (group.iconAssetPath != null) {
      return Image.asset(
        group.iconAssetPath!,
        width: 18,
        height: 18,
        fit: BoxFit.contain,
      );
    }
    return Icon(
      group.iconData ?? Icons.build_outlined,
      size: 18,
      color: AppColors.darkBlue600,
    );
  }
}

class _FinishesGuideScreen extends StatefulWidget {
  const _FinishesGuideScreen();

  @override
  State<_FinishesGuideScreen> createState() => _FinishesGuideScreenState();
}

class _FinishesGuideScreenState extends State<_FinishesGuideScreen> {
  int _selectedTab = 0;

  static const _tabs = ['Resumo', 'Cozinha', 'Casa de Banho'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final sections = _guideSectionsForTab(_selectedTab);

    return Scaffold(
      backgroundColor: AppColors.purple100,
      appBar: AppBar(
        backgroundColor: AppColors.purple100,
        surfaceTintColor: AppColors.purple100,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkBlue600),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Guia de Acabamentos',
          style: theme.titleLarge?.copyWith(
            color: AppColors.darkBlue600,
            fontWeight: FontWeight.w700,
            fontSize: 24 / 2, // keep compact style from mock
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: AppColors.darkBlue600),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text(
                'Escolhe o nível certo para o teu projeto',
                style: theme.labelLarge?.copyWith(
                  color: AppColors.darkBlue600,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
              child: Text(
                'Três níveis de acabamentos pensados para diferentes estratégias de investimento. '
                'Preços indicativos para apartamento T2 (98m²).',
                style: theme.bodyMedium?.copyWith(
                  color: AppColors.darkBlue600.withValues(alpha: 0.8),
                  fontSize: 13,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: AppColors.purple100,
              child: Row(
                children: [
                  for (int i = 0; i < _tabs.length; i++)
                    Expanded(
                      child: InkWell(
                        onTap: () => setState(() => _selectedTab = i),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: _selectedTab == i
                                    ? AppColors.purple600
                                    : AppColors.gray700,
                                width: _selectedTab == i ? 2 : 1,
                              ),
                            ),
                          ),
                          child: Text(
                            _tabs[i],
                            textAlign: TextAlign.center,
                            style: theme.labelLarge?.copyWith(
                              fontSize: 14,
                              fontWeight:
                                  _selectedTab == i ? FontWeight.w700 : FontWeight.w500,
                              color: _selectedTab == i
                                  ? AppColors.darkBlue600
                                  : AppColors.darkBlue600.withValues(alpha: 0.45),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                itemBuilder: (context, index) =>
                    _GuideTierCard(data: sections[index]),
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemCount: sections.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<_GuideTierData> _guideSectionsForTab(int tab) {
  switch (tab) {
    case 1:
      return const [
        _GuideTierData(
          tier: 'Económico',
          priceRange: '3.500 - 4.500€',
          description:
              'Ideal para revenda rápida a primeiro comprador. Prioriza funcionalidade sobre estética.',
          bullets: [
            'Móveis IKEA ou equivalente',
            'Bancada laminado branco',
            'Eletrodomésticos básicos incluídos',
            'Torneira cromada standard',
          ],
        ),
        _GuideTierData(
          tier: 'Intermédio',
          priceRange: '5.500 - 7.000€',
          description:
              'Melhor custo-benefício. Acabamentos atuais que valorizam sem sobrecusto.',
          bullets: [
            'Móveis lacados ou folheado madeira',
            'Bancada pedra compacta ou quartzo',
            'Eletrodomésticos classe A eficientes',
            'Torneira extraível + salpicos vidro',
          ],
        ),
        _GuideTierData(
          tier: 'Premium',
          priceRange: '8.500 - 12.000€',
          description: 'Para mercado high-end ou localizações premium.',
          bullets: [
            'Móveis medida design contemporâneo',
            'Bancada e ilha em pedra natural',
            'Eletrodomésticos premium integrados',
            'Iluminação LED com perfis e dimerização',
          ],
        ),
      ];
    case 2:
      return const [
        _GuideTierData(
          tier: 'Económico',
          priceRange: '1.800€ - 2.500€',
          description: 'Renovação completa com materiais standard.',
          bullets: [
            'Louças brancas standard',
            'Azulejo branco 30x60',
            'Base duche acrílico + cortina',
          ],
        ),
        _GuideTierData(
          tier: 'Intermédio',
          priceRange: '3.000€ - 4.200€',
          description: 'Acabamentos modernos que agregam valor.',
          bullets: [
            'Louças suspensas linha moderna',
            'Porcelânico grande formato',
            'Base duche + vidro temperado',
          ],
        ),
        _GuideTierData(
          tier: 'Premium',
          priceRange: '5.000€ - 7.500€',
          description: 'Design statement com materiais premium.',
          bullets: [
            'Louças design',
            'Mármore natural / porcelânico pedra',
            'Chuveiro walk-in vidro 10mm',
          ],
        ),
      ];
    default:
      return const [
        _GuideTierData(
          tier: 'Económico',
          priceRange: '15.000€ - 20.000€',
          rows: [
            _GuideInlineRow('Tempo de Execução', '4-6 semanas'),
            _GuideInlineRow('Premium', '+8% a +12%', valueColor: AppColors.roiGreen),
            _GuideInlineRow('Público-Alvo', 'Primeiro Comprador; Investidor Iniciante'),
            _GuideInlineRow('Quando Escolher', 'Flip Rápido; Zonas Periféricas; Orçamento Limitado'),
          ],
        ),
        _GuideTierData(
          tier: 'Intermédio',
          priceRange: '25.000€ - 35.000€',
          rows: [
            _GuideInlineRow('Tempo', '6-8 semanas'),
            _GuideInlineRow('Valorização', '+15% a +20%', valueColor: AppColors.roiGreen),
            _GuideInlineRow('Público-Alvo', 'Jovens Casais; Famílias Classe Média'),
            _GuideInlineRow('Quando Escolher', 'Melhor ROI; Zonas Urbanas; Balanço Ideal Custo/Qualidade'),
          ],
          highlightedFooter:
              '💡 Recomendação: Para a maioria dos projetos flip, o nível Intermédio '
              'oferece o melhor ROI (€/tempo investido).',
        ),
      ];
  }
}

class _GuideTierCard extends StatelessWidget {
  const _GuideTierCard({required this.data});

  final _GuideTierData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final tagColor = switch (data.tier) {
      'Económico' => const Color(0xFFDDEBFF),
      'Intermédio' => const Color(0xFFE8E6F7),
      _ => const Color(0xFFD7ECEC),
    };
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.gray600),
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: tagColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  data.tier,
                  style: theme.labelLarge?.copyWith(
                    fontSize: 14,
                    color: AppColors.darkBlue600,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                data.priceRange,
                style: theme.labelLarge?.copyWith(
                  fontSize: 16,
                  color: AppColors.darkBlue600,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          if (data.description != null) ...[
            const SizedBox(height: 10),
            Text(
              data.description!,
              style: theme.bodyMedium?.copyWith(
                fontSize: 14,
                color: AppColors.darkBlue600,
                height: 1.25,
              ),
            ),
          ],
          if (data.rows.isNotEmpty) ...[
            const SizedBox(height: 10),
            for (int i = 0; i < data.rows.length; i++) ...[
              if (i > 0) const Divider(height: 14, color: AppColors.gray600),
              _GuideRowItem(row: data.rows[i]),
            ],
          ],
          if (data.bullets.isNotEmpty) ...[
            const SizedBox(height: 8),
            for (final b in data.bullets) ...[
              const SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(Icons.check, size: 16, color: AppColors.roiGreen),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      b,
                      style: theme.bodyMedium?.copyWith(
                        fontSize: 14,
                        color: AppColors.darkBlue600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
          if (data.highlightedFooter != null) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFEDEAF9),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFCFC8ED)),
              ),
              child: Text(
                data.highlightedFooter!,
                style: theme.bodySmall?.copyWith(
                  fontSize: 12,
                  color: AppColors.darkBlue600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _GuideRowItem extends StatelessWidget {
  const _GuideRowItem({required this.row});

  final _GuideInlineRow row;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            row.label,
            style: theme.bodyMedium?.copyWith(
              fontSize: 14,
              color: AppColors.darkBlue600.withValues(alpha: 0.78),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            row.value,
            textAlign: TextAlign.right,
            style: theme.bodyMedium?.copyWith(
              fontSize: 14,
              color: row.valueColor ?? AppColors.darkBlue600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _GuideTierData {
  const _GuideTierData({
    required this.tier,
    required this.priceRange,
    this.description,
    this.rows = const [],
    this.bullets = const [],
    this.highlightedFooter,
  });

  final String tier;
  final String priceRange;
  final String? description;
  final List<_GuideInlineRow> rows;
  final List<String> bullets;
  final String? highlightedFooter;
}

class _GuideInlineRow {
  const _GuideInlineRow(this.label, this.value, {this.valueColor});
  final String label;
  final String value;
  final Color? valueColor;
}
