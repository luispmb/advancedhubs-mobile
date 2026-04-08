import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_theme.dart';

/// Ecrã "Bottom Shelf - Chat" do Figma.
/// Cabeçalho com bot info, área de mensagens, sugestões e input.
class BottomShelfChatScreen extends StatelessWidget {
  const BottomShelfChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final suggestions = [
      l.chatSuggestionRisk,
      l.chatSuggestionZone,
      l.chatSuggestionRoi,
    ];
    return ColoredBox(
      color: AppColors.purple100,
      child: SafeArea(
        child: Column(
          children: [
            _ChatHeader(
              onClose: () => Navigator.of(context).maybePop(),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _MessageBubble(text: l.chatWelcome),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _SuggestionPills(
                          suggestions: suggestions,
                          onTap: (_) {},
                        ),
                        const SizedBox(height: 16),
                        _PromptInput(
                          placeholder: l.askAnything,
                          onSend: () {},
                          onAttach: () {},
                        ),
                        const SizedBox(height: 8),
                        _Disclaimer(text: l.chatDisclaimerCasaGpt),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Cabeçalho do bottom sheet: avatar, nome, contexto e botão fechar.
class _ChatHeader extends StatelessWidget {
  const _ChatHeader({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        border: Border(
          bottom: BorderSide(color: AppColors.gray700, width: 1),
        ),
      ),
      child: Row(
        children: [
          _BotAvatar(),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l.appBrandName,
                  style: theme.headlineMedium,
                ),
                const SizedBox(height: 2),
                Text(
                  l.chatContextLeiria,
                  style: theme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          _CloseButton(onPressed: onClose),
        ],
      ),
    );
  }
}

/// Avatar do bot (placeholder; depois pode ser imagem do Figma).
class _BotAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.purple600,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 2.25,
            offset: const Offset(0, 1.125),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6.75,
            offset: const Offset(0, 2.25),
          ),
        ],
      ),
      child: const Icon(
        Icons.smart_toy_outlined,
        color: AppColors.white,
        size: 20,
      ),
    );
  }
}

/// Botão fechar (X).
class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.8),
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(30),
        child: const SizedBox(
          width: 32,
          height: 32,
          child: Center(
            child: Icon(
              Icons.close,
              size: 19,
              color: AppColors.darkBlue800,
            ),
          ),
        ),
      ),
    );
  }
}

/// Balão de mensagem (bot ou utilizador).
class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

/// Pills de sugestão (borda roxa, texto primário).
class _SuggestionPills extends StatelessWidget {
  const _SuggestionPills({
    required this.suggestions,
    required this.onTap,
  });

  final List<String> suggestions;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: suggestions
          .map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _SuggestionPill(
                label: s,
                onTap: () => onTap(s),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _SuggestionPill extends StatelessWidget {
  const _SuggestionPill({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.purple600),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.purple600,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Campo de input + botões anexar e enviar.
class _PromptInput extends StatelessWidget {
  const _PromptInput({
    required this.placeholder,
    required this.onSend,
    required this.onAttach,
  });

  final String placeholder;
  final VoidCallback onSend;
  final VoidCallback onAttach;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.purple400),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              placeholder,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.gray900,
                  ),
            ),
          ),
          const SizedBox(width: 16),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _IconButton(
                icon: Icons.attach_file,
                color: AppColors.teal600,
                onPressed: onAttach,
              ),
              const SizedBox(width: 16),
              _IconButton(
                icon: Icons.arrow_upward,
                backgroundColor: AppColors.purple600,
                iconColor: AppColors.white,
                onPressed: onSend,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.icon,
    required this.onPressed,
    this.color,
    this.backgroundColor,
    this.iconColor,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final useBackground = backgroundColor != null;
    return Material(
      color: useBackground ? backgroundColor : Colors.transparent,
      borderRadius: BorderRadius.circular(useBackground ? 16 : 0),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(useBackground ? 16 : 24),
        child: SizedBox(
          width: 24,
          height: 24,
          child: Center(
            child: Icon(
              icon,
              size: 24,
              color: iconColor ?? color ?? AppColors.darkBlue800,
            ),
          ),
        ),
      ),
    );
  }
}

/// Texto de disclaimer pequeno e centralizado.
class _Disclaimer extends StatelessWidget {
  const _Disclaimer({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
