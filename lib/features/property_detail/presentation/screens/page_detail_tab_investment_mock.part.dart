part of 'page_detail_tab_investment_screen.dart';

/// Dados mock do imóvel e do investimento (substituir por domínio/API).
class _MockDetailData {
  static const String title = 'Apartamento T2';
  static const String price = '195.000€';
  static const String roiPercent = '+6%';
  static const String location = 'Caldas da Rainha, Leiria';
  static const String typology = 'T2';
  static const String area = '66m²';
  static const String state = 'Renovar';
  static const String description =
      'Descubra este encantador apartamento T2 localizado na tranquila e acolhedora área da Codivel, em Odivelas. A 450m, 6 min, do Metro de Odivelas, este imóvel oferece a combinação perfeita de conforto, conveniência e qualidade de vida, sendo ideal para famílias, casais ou investidores.\n\nEste apartamento é uma oportunidade única para quem procura um imóvel bem localizado e com todas as comodidades para uma vida moderna e confortável. Sem dúvida a melhor remodelação no Bairro da Codivel.';
  static const String purchasePrice = '195.000€';
  static const String totalCost = '238.800€';
  static const String estimatedSale = '252.700€';
  static const String expectedRoi = '+6%';
  static const String capitalTotal = '238.800€';
  static const String disclaimer =
      'Pressupostos: obras a 280€/m², venda baseada em 17 comparáveis T2 renovados.';
  static const List<CapitalSegment> capitalSegments = [
    CapitalSegment(label: 'Compra 195k (82%)', percent: 0.82, color: AppColors.purple600),
    CapitalSegment(label: 'Obras 38k (16%)', percent: 0.16, color: AppColors.teal600),
    CapitalSegment(label: 'Taxas 5.8k (2%)', percent: 0.02, color: AppColors.darkBlue800),
  ];
}

/// Dados mock do tab Mercado (substituir por domínio/API).
class _MockMarketData {
  static const String precoPedido = '1.990€/m²';
  static const String mediaZona = '2.130€/m²';
  static const String abaixoMediaBadge = '6.6% Abaixo da média';
  static const String analiseResumo =
      'Imóvel abaixo da mediana de Leiria. Margem de valorização confortável após renovação.';
  static const String estimativaVenda = '252.700€';
  static const String estimativaPerM2 = '/ 2.578€/m²';
  static const String medianaLabel = 'Mediana T2 renovados';
  static const String rangeEstimado = '240.000€ — 265.000€';
  static const String precoMedio = '2.130€/m²';
  static const String absorcao = '104 dias';
  static const String amostra = '17';
  static const String desconto = '-13%';
}

/// Dados mock do tab Obras / Renovations (substituir por domínio/API).
class _MockRenovationsData {
  static const String softCostsTitle = 'Soft Costs (Projetos & Taxas)';
  static const String hardCostsTitle = 'Hard Costs (Empreitada)';
  static const String totalEstimado = '33.280 – 59.060€';
  static const String verGuiaLabel = 'Ver Guia de Acabamentos';
  static const String disclaimer =
      'Valores médios para Leiria. Base 280€/m² assume intervenção parcial. Orçamento real varia conforme estado do imóvel.';

  static const List<_RenovationGroup> softCosts = [
    _RenovationGroup(
      title: 'Projetos & Licenças',
      totalRange: '3.500 - 5.000€',
      icon: Icons.square_foot,
      items: [
        _RenovationLineItem('Projeto de Arquitetura', '1.500 – 2.500€'),
        _RenovationLineItem('Projeto Especialidades', '800 – 1.200€'),
        _RenovationLineItem('Taxas Municipais', '1.200 – 1.300€'),
      ],
    ),
  ];

  static const List<_RenovationGroup> hardCosts = [
    _RenovationGroup(
      title: 'Estrutural',
      totalRange: '10.000 - 16.000€',
      icon: Icons.build,
      items: [
        _RenovationLineItem('Cobertura e Impermeabilização', '6.500 – 9.500€'),
        _RenovationLineItem('Caixilharia e Janelas', '3.500 – 6.500€'),
      ],
    ),
    _RenovationGroup(
      title: 'Instalações',
      totalRange: '7.840 - 13.720€',
      icon: Icons.lightbulb_outline,
      items: [
        _RenovationLineItem('Elétrica Completa', '4.410 – 7.840€'),
        _RenovationLineItem('Canalização e AVAC', '3.430 – 5.880€'),
      ],
    ),
    _RenovationGroup(
      title: 'Acabamentos',
      totalRange: '7.840 - 13.720€',
      icon: Icons.format_paint,
      items: [
        _RenovationLineItem('Revestimentos', '2.940 – 7.840€'),
        _RenovationLineItem('Cozinha Equipada', '5.000 – 8.000€'),
        _RenovationLineItem('Casas de Banho ×2', '4.000 – 8.500€'),
      ],
    ),
  ];
}

/// Dados mock do tab Burocracia (substituir por domínio/API).
class _MockBurocraciaData {
  static const String semLicencaTitle = 'Sem Licença de Habitabilidade';
  static const String semLicencaText =
      'Imóvel necessita de inspeção e licenciamento antes de venda. Pode atrasar timeline em 2-3 meses.';
  static const String aruTitle = 'Localizado em ARU';
  static const String aruText =
      'Zona de Reabilitação Urbana — elegível para isenções fiscais e IVA a 6%.';
  static const String viabilidadeTitle = 'Viabilidade PDM';
  static const String viabilidadeText =
      'Habitação plurifamiliar. Ampliação até 10% da área existente permitida segundo PDM de Leiria.';
  static const String viabilidadeBadge = 'Uso conforme ao PDM';
  static const String timelineTitle = 'Timeline de Aprovações';
  static const List<_BurocraciaTimelineItem> timelineItems = [
    _BurocraciaTimelineItem('Aprovação de Projeto', '30-60 dias'),
    _BurocraciaTimelineItem('Licença de Obras', '15-30 dias'),
    _BurocraciaTimelineItem('Licença de Habitabilidade', '15-20 dias'),
  ];
  static const String disclaimer =
      'Prazos indicativos para Câmara Municipal de Leiria. Podem variar conforme época do ano e complexidade do projeto.';
}

/// Dados mock do tab Fiscalidade (substituir por domínio/API).
class _MockFiscalidadeData {
  static const String custosEntradaTitle = 'Custos à Entrada';
  static const List<_FiscalidadeLineItem> custosEntradaLines = [
    _FiscalidadeLineItem('IMT (Habitação Própria)', '~5.100€'),
    _FiscalidadeLineItem('Imposto de Selo (IS)', '~1.560€'),
    _FiscalidadeLineItem('Escritura e Registo', '~500€'),
  ];
  static const String custosEntradaTotal = '~7.160€';
  static const String beneficiosTitle = 'Benefícios Durante a Obra';
  static const String beneficioIvaTitle = 'IVA a 6% (aprovado 2026)';
  static const String beneficioIvaText =
      'Para obras em ARU. Poupança estimada de ~2.400€ vs. taxa normal de 23%.';
  static const String beneficioImiTitle = 'Isenção IMI (3 anos)';
  static const String beneficioImiText =
      'Se obra licenciada como reabilitação urbana. Poupança anual ~600€.';
  static const String impostosSaidaTitle = 'Impostos à Saída';
  static const String maisValiasLabel = 'Mais-valias (pessoa singular)';
  static const String maisValiasValue = '28%';
  static const String ircLabel = 'IRC (pessoa coletiva)';
  static const String ircValue = '21%';
  static const String warningText =
      'Isenção parcial de mais-valias se reinvestimento em HPP declarado no mesmo ano fiscal. ';
  static const String warningLink = 'Ver condições e requisitos';
}

class _FiscalidadeLineItem {
  const _FiscalidadeLineItem(this.label, this.value);
  final String label;
  final String value;
}

class _BurocraciaTimelineItem {
  const _BurocraciaTimelineItem(this.label, this.duration);
  final String label;
  final String duration;
}

class _RenovationGroup {
  const _RenovationGroup({
    required this.title,
    required this.totalRange,
    required this.icon,
    required this.items,
  });
  final String title;
  final String totalRange;
  final IconData icon;
  final List<_RenovationLineItem> items;
}

class _RenovationLineItem {
  const _RenovationLineItem(this.label, this.range);
  final String label;
  final String range;
}

class CapitalSegment {
  const CapitalSegment({
    required this.label,
    required this.percent,
    required this.color,
  });
  final String label;
  final double percent;
  final Color color;
}
