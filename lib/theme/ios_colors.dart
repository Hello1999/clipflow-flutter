import 'package:flutter/cupertino.dart';

extension IOSColors on BuildContext {
  bool get isDark =>
      CupertinoTheme.brightnessOf(this) == Brightness.dark;

  Color get blue =>
      CupertinoDynamicColor.resolve(CupertinoColors.systemBlue, this);
  Color get red =>
      CupertinoDynamicColor.resolve(CupertinoColors.systemRed, this);
  Color get green =>
      CupertinoDynamicColor.resolve(CupertinoColors.systemGreen, this);
  Color get orange =>
      CupertinoDynamicColor.resolve(CupertinoColors.systemOrange, this);
  Color get purple =>
      CupertinoDynamicColor.resolve(CupertinoColors.systemPurple, this);
  Color get teal =>
      CupertinoDynamicColor.resolve(CupertinoColors.systemTeal, this);
  Color get indigo =>
      CupertinoDynamicColor.resolve(CupertinoColors.systemIndigo, this);

  Color get label =>
      CupertinoDynamicColor.resolve(CupertinoColors.label, this);
  Color get label2 =>
      CupertinoDynamicColor.resolve(CupertinoColors.secondaryLabel, this);
  Color get label3 =>
      CupertinoDynamicColor.resolve(CupertinoColors.tertiaryLabel, this);
  Color get label4 =>
      CupertinoDynamicColor.resolve(CupertinoColors.quaternaryLabel, this);

  // Grouped: F2F2F7 / 000000
  Color get groupedBg =>
      CupertinoDynamicColor.resolve(CupertinoColors.systemGroupedBackground, this);
  // Card interior: FFFFFF / 1C1C1E
  Color get cardBg =>
      CupertinoDynamicColor.resolve(CupertinoColors.secondarySystemGroupedBackground, this);
  // Tertiary card: FFFFFF / 2C2C2E
  Color get cardBg3 =>
      CupertinoDynamicColor.resolve(CupertinoColors.tertiarySystemBackground, this);

  Color get fill =>
      CupertinoDynamicColor.resolve(CupertinoColors.systemFill, this);
  Color get fill2 =>
      CupertinoDynamicColor.resolve(CupertinoColors.secondarySystemFill, this);
  Color get fill3 =>
      CupertinoDynamicColor.resolve(CupertinoColors.tertiarySystemFill, this);

  Color get sep =>
      CupertinoDynamicColor.resolve(CupertinoColors.separator, this);
  Color get opaqueSep =>
      CupertinoDynamicColor.resolve(CupertinoColors.opaqueSeparator, this);
}
