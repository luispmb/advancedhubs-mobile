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
          _TopAlertCard(
            type: _TopAlertType.warning,
            title: _MockBurocraciaData.semLicencaTitle,
            text: _MockBurocraciaData.semLicencaText,
          ),
          const SizedBox(height: 16),
          _TopAlertCard(
            type: _TopAlertType.success,
            title: _MockBurocraciaData.aruTitle,
            text: _MockBurocraciaData.aruText,
          ),
          const SizedBox(height: 16),
          _LicenciamentoCard(),
          const SizedBox(height: 16),
          _ViabilidadePdmCard(
            title: _MockBurocraciaData.viabilidadeTitle,
            text: _MockBurocraciaData.viabilidadeText,
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
          const _TabsBottomActionsInline(),
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
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
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
              Image.asset(
                'assets/images/Timeline Icon.png',
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.labelLarge?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkBlue600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
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
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
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

enum _TopAlertType { warning, success }

class _TopAlertCard extends StatelessWidget {
  const _TopAlertCard({
    required this.type,
    required this.title,
    required this.text,
  });

  final _TopAlertType type;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final (bg, border, icon, iconColor) = switch (type) {
      _TopAlertType.warning => (
          AppColors.warningBg,
          AppColors.warningBorder,
          Icons.warning_amber_rounded,
          const Color(0xFFB38600),
        ),
      _TopAlertType.success => (
          AppColors.successCardBg,
          AppColors.successCardBorder,
          Icons.check_circle_outline,
          AppColors.roiGreen,
        ),
    };
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 19, color: iconColor),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.labelLarge?.copyWith(
                    fontSize: 16,
                    color: AppColors.darkBlue600,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  text,
                  style: theme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: AppColors.gray1000,
                    height: 1.22,
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

class _LicenciamentoCard extends StatelessWidget {
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
              const Icon(Icons.assignment_outlined, size: 19, color: AppColors.darkBlue600),
              const SizedBox(width: 8),
              Text(
                'Tipo de Licenciamento',
                style: theme.labelLarge?.copyWith(
                  fontSize: 16,
                  color: AppColors.darkBlue600,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F1FB),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _TagChip(label: 'Comunicação Prévia', selected: true),
                    const SizedBox(width: 8),
                    _TagChip(label: 'Obras Previstas', selected: false),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'As obras planeadas (intervenção em cozinha e WC, substituição de caixilharia) '
                  'requerem Comunicação Prévia à Câmara Municipal. '
                  'Não é necessário aguardar aprovação para iniciar.',
                  style: theme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: AppColors.darkBlue600,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Processo: Submeter comunicação + projeto + taxa (≈300-500). '
            'Obras podem iniciar 10 dias úteis após submissão, salvo notificação contrária.',
            style: theme.bodySmall?.copyWith(
              fontSize: 13,
              color: AppColors.gray1000,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

class _ViabilidadePdmCard extends StatelessWidget {
  const _ViabilidadePdmCard({
    required this.title,
    required this.text,
    required this.badge,
  });

  final String title;
  final String text;
  final String badge;

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
              const Icon(Icons.assignment_outlined, size: 19, color: AppColors.darkBlue600),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.labelLarge?.copyWith(
                  fontSize: 16,
                  color: AppColors.darkBlue600,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Análise do Projeto Proposto',
            style: theme.bodySmall?.copyWith(
              fontSize: 13,
              color: AppColors.gray900,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: theme.bodyMedium?.copyWith(
              fontSize: 14,
              color: AppColors.gray1000,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F1FB),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Conformidade PDM Leiria',
                  style: theme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: AppColors.gray1000,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const _PdmLine(
                  text: 'Uso: Habitacional — conforme ao uso previsto no PDM.',
                ),
                const _PdmLine(
                  text: 'Área: Sem alteração de área bruta (98m²), mantém configuração atual.',
                ),
                const _PdmLine(
                  text: 'Volumetria: Sem alteração de fachadas ou cobertura.',
                ),
                const _PdmLine(
                  text: 'Cércea: Mantém altura existente (conforme Art. 47º PDM).',
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.roiGreenBg,
                border: Border.all(color: AppColors.roiGreenBorder),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                badge,
                style: theme.bodySmall?.copyWith(
                  fontSize: 14,
                  color: AppColors.roiGreen,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PdmLine extends StatelessWidget {
  const _PdmLine({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check, size: 17, color: AppColors.roiGreen),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: theme.bodyMedium?.copyWith(
                fontSize: 14,
                color: AppColors.darkBlue600,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({
    required this.label,
    required this.selected,
  });

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFDEE6FF) : const Color(0xFFE7E6EE),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: theme.bodySmall?.copyWith(
          fontSize: 13,
          color: AppColors.darkBlue600,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
