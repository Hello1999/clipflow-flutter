import 'package:flutter/material.dart';
import 'm3_colors.dart';

class M3Theme {
  const M3Theme._();

  static ThemeData light() => _build(M3Colors.lightColorScheme);
  static ThemeData dark() => _build(M3Colors.darkColorScheme);

  static ThemeData _build(ColorScheme cs) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: cs.background,
      splashFactory: NoSplash.splashFactory,
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: M3Colors.surface2(cs),
        indicatorColor: cs.secondaryContainer,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: cs.onSecondaryContainer, size: 22);
          }
          return IconThemeData(color: cs.onSurfaceVariant, size: 22);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
              color: cs.onSurface,
            );
          }
          return TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
            color: cs.onSurfaceVariant,
          );
        }),
        height: 80,
        elevation: 0,
      ),
      cardTheme: const CardThemeData(
        margin: EdgeInsets.zero,
        elevation: 0,
      ),
      chipTheme: ChipThemeData(
        side: WidgetStateBorderSide.resolveWith((s) => BorderSide(
          color: s.contains(WidgetState.selected)
              ? Colors.transparent
              : cs.outlineVariant,
          width: 1,
        )),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Colors.transparent,
        selectedColor: cs.secondaryContainer,
        checkmarkColor: cs.onSecondaryContainer,
        labelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: cs.onSurfaceVariant,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.selected)) return cs.onPrimary;
          return cs.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.selected)) return cs.primary;
          return cs.surfaceVariant;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
    );
  }
}
