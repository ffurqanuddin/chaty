

import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ThemeValue {
  defaultTheme,
  purple,
  theme3,
  darkMode,

  urchin,
}

enum VerificationTickValue {
  defaultTick,
  amber,
  pink,
  red,
  green,
}

bool darkModeValue = false;

final themeValueStateProvider = StateProvider((ref) => 0);
final currentThemeStateProvider =
StateProvider<ThemeValue>((ref) => ThemeValue.defaultTheme);
final currentVerificationTickStateProvider =
StateProvider<VerificationTickValue>(
        (ref) => VerificationTickValue.defaultTick);