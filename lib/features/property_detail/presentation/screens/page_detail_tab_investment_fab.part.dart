part of 'page_detail_tab_investment_screen.dart';

class _CasaGPTFab extends StatelessWidget {
  const _CasaGPTFab({required this.onTap});

  final VoidCallback onTap;

  static const String _logoAsset = 'assets/images/Screenshot 2026-03-11 at 18.21.48.png';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.purple100,
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.2),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 56,
          height: 56,
          child: Center(
            child: ClipOval(
              child: Image.asset(
                _logoAsset,
                width: 44,
                height: 44,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.smart_toy_outlined,
                  color: AppColors.purple600,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
