import 'package:clashmi/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class CommonWidget {
  static const double kLatencyWidget = 60;
  static Widget createNeedPermission(
    BuildContext context,
    String text,
    Function() onPermission,
    Function() onRefresh,
  ) {
    final tcontext = Translations.of(context);
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          const SizedBox(height: 50),
          ElevatedButton(
            child: Text(text),
            onPressed: () async {
              onPermission();
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            child: Text(tcontext.meta.refresh),
            onPressed: () async {
              onRefresh();
            },
          ),
        ],
      ),
    );
  }
}
