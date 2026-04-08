import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/localization/app_localizations.dart';
import 'login_screen.dart';
import 'subscription_offer_screen.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.purple100, // #F3F3F7
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _CircleIconButton(
                    icon: Icons.arrow_back,
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                l.createAccountTitle,
                style: theme.headlineMedium?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l.startTrialSubtitle,
                style: theme.bodyMedium?.copyWith(
                  fontSize: 22 / 3 * 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _LabeledField(
                      label: l.firstName,
                      hint: 'João',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _LabeledField(
                      label: l.lastName,
                      hint: 'Silva',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _LabeledField(
                label: l.emailLabel,
                hint: 'joão.silva@email.com',
              ),
              const SizedBox(height: 14),
              _LabeledField(
                label: l.mobile,
                hint: '+351 912 345 678',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 14),
              _LabeledField(
                label: l.passwordLabel,
                hint: l.minCharsPassword,
                obscureText: true,
              ),
              const SizedBox(height: 26),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const SubscriptionOfferScreen(),
                      ),
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
                    l.createAccount,
                    style: theme.labelLarge?.copyWith(
                      color: AppColors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l.noAccountYetShort,
                    style: theme.bodyMedium?.copyWith(fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      l.logInLink,
                      style: theme.bodyMedium?.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: AppColors.darkBlue800,
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
    this.keyboardType,
    this.obscureText = false,
  });

  final String label;
  final String hint;
  final TextInputType? keyboardType;
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
          keyboardType: keyboardType,
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

