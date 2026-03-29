part of 'page_detail_tab_investment_screen.dart';

class _HeroSection extends StatelessWidget {
  const _HeroSection({
    required this.onBack,
    required this.onShare,
    required this.onFavorite,
  });

  final VoidCallback onBack;
  final VoidCallback onShare;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 363,
      pinned: false,
      backgroundColor: AppColors.purple100,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: _OverlayButton(icon: Icons.arrow_back, onPressed: onBack),
      ),
      actions: [
        _OverlayButton(icon: Icons.share, onPressed: onShare),
        const SizedBox(width: 8),
        _OverlayButton(icon: Icons.favorite_border, onPressed: onFavorite),
        const SizedBox(width: 24),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: const Color(0xFFC4C4C4),
          child: const Center(
            child: Icon(Icons.home_work_outlined, size: 64, color: AppColors.gray900),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(24),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) => _SliderDot(active: i == 0)),
          ),
        ),
      ),
    );
  }
}

class _OverlayButton extends StatelessWidget {
  const _OverlayButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white.withValues(alpha: 0.9),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 32,
          height: 32,
          child: Center(child: Icon(icon, size: 20, color: AppColors.darkBlue600)),
        ),
      ),
    );
  }
}

class _SliderDot extends StatelessWidget {
  const _SliderDot({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 8 : 6.5,
      height: active ? 8 : 6.5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? AppColors.white : AppColors.white.withValues(alpha: 0.5),
      ),
    );
  }
}

class _PropertyOverview extends StatelessWidget {
  const _PropertyOverview();

  @override
  Widget build(BuildContext context) {
    final l10n = CasaGptLocalizations.of(context);
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _MockDetailData.title,
            style: theme.bodyMedium?.copyWith(
              fontSize: 14,
              color: AppColors.purple800,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _MockDetailData.price,
                style: theme.headlineMedium?.copyWith(
                  fontSize: 28,
                  color: AppColors.darkBlue600,
                ),
              ),
              const Spacer(),
              const _RoiBadge(roi: _MockDetailData.roiPercent),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 18, color: AppColors.gray900),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                _MockDetailData.location,
                style: theme.bodyMedium?.copyWith(
                  fontSize: 14,
                  color: AppColors.gray900,
                ),
              ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _DetailChip(icon: Icons.bed_outlined, label: _MockDetailData.typology),
              const SizedBox(width: 16),
              _DetailChip(icon: Icons.square_foot_outlined, label: _MockDetailData.area),
              const SizedBox(width: 16),
              _DetailChip(
                icon: Icons.build_outlined,
                label: _MockDetailData.state == 'Renovar'
                    ? l10n.renovate
                    : _MockDetailData.state,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            l10n.description,
            style: theme.labelLarge?.copyWith(
              fontSize: 14,
              color: AppColors.gray1000,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _MockDetailData.description,
            style: theme.bodyMedium?.copyWith(
              fontSize: 14,
              color: Colors.black,
              height: 1.3,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () {},
            child: Text(
              l10n.showMore,
              style: theme.labelLarge?.copyWith(
                fontSize: 12,
                color: AppColors.purple600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoiBadge extends StatelessWidget {
  const _RoiBadge({required this.roi});

  final String roi;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.roiGreenBg,
        border: Border.all(color: AppColors.roiGreenBorder),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ROI',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 16,
                  color: AppColors.roiGreen,
                ),
          ),
          const SizedBox(width: 4),
          Text(
            roi,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.roiGreen,
                ),
          ),
        ],
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  const _DetailChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppColors.purple600),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 14,
                color: AppColors.purple600,
              ),
        ),
      ],
    );
  }
}

class _TabBarRow extends StatelessWidget {
  const _TabBarRow({
    required this.selectedIndex,
    required this.tabLabels,
    required this.onTabSelected,
  });

  final int selectedIndex;
  final List<String> tabLabels;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.gray700)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: List.generate(
            tabLabels.length,
            (i) => _DetailTab(
              label: tabLabels[i],
              selected: i == selectedIndex,
              onTap: () => onTabSelected(i),
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailTab extends StatelessWidget {
  const _DetailTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? AppColors.purple600 : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 14,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? AppColors.purple600 : AppColors.gray900,
              ),
        ),
      ),
    );
  }
}
