import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/screens/widgets/paste_text_button.dart';

void main() {
  testWidgets('pastes into the associated credential, not the focused URL', (
    tester,
  ) async {
    final url = TextEditingController(text: 'https://example.com/dav/');
    final password = TextEditingController(text: 'old');
    final urlFocus = FocusNode();
    final passwordFocus = FocusNode();
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.getData') {
          return <String, dynamic>{'text': ' secret +%\n'};
        }
        return null;
      },
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              TextField(controller: url, focusNode: urlFocus),
              TextField(
                controller: password,
                focusNode: passwordFocus,
                obscureText: true,
                decoration: InputDecoration(
                  suffixIcon: PasteTextButton(
                    controller: password,
                    focusNode: passwordFocus,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    urlFocus.requestFocus();
    await tester.pump();
    await tester.tap(find.byIcon(Icons.content_paste));
    await tester.pumpAndSettle();
    expect(url.text, 'https://example.com/dav/');
    expect(password.text, ' secret +%\n');
    expect(
      password.selection,
      TextSelection.collapsed(offset: password.text.length),
    );
    expect(passwordFocus.hasFocus, isTrue);
    await tester.pumpWidget(const SizedBox.shrink());
    url.dispose();
    password.dispose();
    urlFocus.dispose();
    passwordFocus.dispose();
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      null,
    );
  });
}
