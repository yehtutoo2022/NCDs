import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';
import '../../model/favorite_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';
import '../../model/favorite_provider.dart';

double expansionTitleFontSize = 16.0;
double expansionSubtitleFontSize = 14.0;

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}

void changeEngLanguage(BuildContext context, Locale newLocale) {
  Locales.change(context, 'en');
  showSnackbar(context, 'Language changed to English');
}

void changeMyanLanguage(BuildContext context, Locale newLocale) {
  Locales.change(context, 'my');
  showSnackbar(context, 'မြန်မာဘာသာသို့ပြောင်းပြီး');
}

void increaseExpansionFontSize() {
  expansionTitleFontSize += 2.0;
  expansionSubtitleFontSize += 2.0;
}

void decreaseExpansionFontSize() {
  expansionTitleFontSize -= 2.0;
  expansionSubtitleFontSize -= 2.0;
}
