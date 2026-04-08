part of 'page_detail_tab_investment_screen.dart';

/// Conteúdo do tab Fiscalidade (Page Detail - Tab Fiscalidade, 390×932).
class _FiscalidadeContent extends StatelessWidget {
  const _FiscalidadeContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      color: AppColors.purple100,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _FiscalidadeSectionCard(
            title: _MockFiscalidadeData.custosEntradaTitle,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ..._MockFiscalidadeData.custosEntradaLines.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
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
                          e.value,
                          style: theme.bodyMedium?.copyWith(
                            fontSize: 15,
                            color: AppColors.darkBlue600,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: theme.labelLarge?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkBlue600,
                      ),
                    ),
                    Text(
                      _MockFiscalidadeData.custosEntradaTotal,
                      style: theme.labelLarge?.copyWith(
                        fontSize: 16,
                        color: AppColors.darkBlue600,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _MockFiscalidadeData.beneficiosTitle,
            style: theme.labelLarge?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.darkBlue600,
            ),
          ),
          const SizedBox(height: 10),
          _FiscalidadeBeneficioCard(
            title: _MockFiscalidadeData.beneficioIvaTitle,
            text: _MockFiscalidadeData.beneficioIvaText,
          ),
          const SizedBox(height: 10),
          _FiscalidadeBeneficioCard(
            title: _MockFiscalidadeData.beneficioImiTitle,
            text: _MockFiscalidadeData.beneficioImiText,
          ),
          const SizedBox(height: 16),
          _FiscalidadeSectionCard(
            title: _MockFiscalidadeData.impostosSaidaTitle,
            child: Column(
              children: [
                _FiscalidadeRow(
                  label: _MockFiscalidadeData.maisValiasLabel,
                  value: _MockFiscalidadeData.maisValiasValue,
                  theme: theme,
                ),
                const SizedBox(height: 10),
                _FiscalidadeRow(
                  label: _MockFiscalidadeData.ircLabel,
                  value: _MockFiscalidadeData.ircValue,
                  theme: theme,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.warningBg,
              border: Border.all(color: AppColors.warningBorder),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.warning_amber_rounded, size: 20, color: Color(0xFFB38600)),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: theme.bodyMedium?.copyWith(
                        fontSize: 13,
                        color: AppColors.gray1000,
                        height: 1.3,
                      ),
                      children: [
                        TextSpan(text: _MockFiscalidadeData.warningText),
                        TextSpan(
                          text: _MockFiscalidadeData.warningLink,
                          style: theme.bodyMedium?.copyWith(
                            fontSize: 13,
                            color: AppColors.darkBlue600,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
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

class _FiscalidadeSectionCard extends StatelessWidget {
  const _FiscalidadeSectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

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
          Text(
            title,
            style: theme.labelLarge?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.darkBlue600,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _FiscalidadeRow extends StatelessWidget {
  const _FiscalidadeRow({
    required this.label,
    required this.value,
    required this.theme,
  });

  final String label;
  final String value;
  final TextTheme? theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: theme?.bodyMedium?.copyWith(
              fontSize: 15,
              color: AppColors.darkBlue600,
            ),
          ),
        ),
        Text(
          value,
          style: theme?.bodyMedium?.copyWith(
            fontSize: 16,
            color: AppColors.darkBlue600,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _FiscalidadeBeneficioCard extends StatelessWidget {
  const _FiscalidadeBeneficioCard({required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFFFF8),
        border: Border.all(color: const Color(0xFF22D3A5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 20,
            color: AppColors.roiGreen,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.labelLarge?.copyWith(
                    fontSize: 16,
                    color: AppColors.roiGreen,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: theme.bodyMedium?.copyWith(
                    fontSize: 14,
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
