import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Pastes a complete value into its associated field without relying on the
/// desktop Edit menu's current text-input client. Clipboard text is not trimmed:
/// whitespace may be significant in credentials.
class PasteTextButton extends StatelessWidget {
  const PasteTextButton({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: MaterialLocalizations.of(context).pasteButtonLabel,
      icon: const Icon(Icons.content_paste),
      onPressed: () async {
        final data = await Clipboard.getData(Clipboard.kTextPlain);
        if (!context.mounted || data?.text == null) {
          return;
        }
        final text = data!.text!;
        controller.value = TextEditingValue(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
        );
        focusNode.requestFocus();
      },
    );
  }
}
