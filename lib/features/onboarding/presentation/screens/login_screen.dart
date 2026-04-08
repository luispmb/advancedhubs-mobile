import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/localization/app_localizations.dart';
import 'create_account_screen.dart';
import '../../../search/presentation/screens/page_search_list_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.purple100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CircleIconButton(
                icon: Icons.arrow_back,
                onTap: () => Navigator.of(context).maybePop(),
              ),
              const SizedBox(height: 20),
              Text(
                l.loginTitle,
                style: theme.headlineMedium?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l.loginSubtitle,
                style: theme.bodyMedium?.copyWith(
                  fontSize: 16 / 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 26),
              _LabeledField(
                label: l.emailLabel,
                hint: 'joão.silva@email.com',
              ),
              const SizedBox(height: 16),
              _LabeledField(
                label: l.passwordLabel,
                hint: l.minCharsPassword,
                obscureText: true,
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    l.forgotPassword,
                    style: theme.labelLarge?.copyWith(
                      color: AppColors.darkBlue800,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.darkBlue800,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute<void>(
                        builder: (_) => const PageSearchListScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBlue800,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    l.logIn,
                    style: theme.labelLarge?.copyWith(
                      color: AppColors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: Divider(color: AppColors.gray700.withValues(alpha: 0.6)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      l.orWord,
                      style: theme.bodySmall?.copyWith(fontSize: 14),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: AppColors.gray700.withValues(alpha: 0.6)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  Expanded(
                    child: _SocialButton(
                      label: 'Google',
                      customIcon: Image(
                        image: AssetImage('assets/images/google_logo.png'),
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _SocialButton(
                      label: 'Facebook',
                      icon: Icons.facebook,
                      iconColor: Color(0xFF1877F2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l.noAccountYet,
                    style: theme.bodyMedium?.copyWith(fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const CreateAccountScreen(),
                        ),
                      );
                    },
                    child: Text(
                      l.createAccount,
                      style: theme.bodyMedium?.copyWith(
                        fontSize: 17,
                        color: AppColors.darkBlue800,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.hint,
    this.obscureText = false,
  });

  final String label;
  final String hint;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.labelLarge?.copyWith(
            fontSize: 14,
            color: AppColors.gray1000,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: theme.bodyLarge?.copyWith(
              color: AppColors.gray900,
              fontSize: 14,
            ),
            fillColor: AppColors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.purple400, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    this.icon,
    this.iconColor,
    this.customIcon,
  });

  final String label;
  final IconData? icon;
  final Color? iconColor;
  final Widget? customIcon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customIcon ??
                  Icon(
                    icon,
                    color: iconColor,
                    size: 24,
                  ),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.darkBlue800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, size: 20, color: AppColors.darkBlue800),
        ),
      ),
    );
  }
}
