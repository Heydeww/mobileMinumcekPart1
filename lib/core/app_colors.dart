import 'package:flutter/material.dart';

// ── RAW COLOR CONSTANTS ───────────────────────────────────────────────────────
// Private class — only consumed by [AppColorsExtension]. Never reference these
// directly in UI code; always go through the ThemeExtension so that light/dark
// variants are resolved automatically by the Flutter theme system.
// ─────────────────────────────────────────────────────────────────────────────
abstract final class _AppColors {
  // ── Universal / Semantic (same across both modes) ──────────────────────────
  static const Color primary = Color(0xFF4FC3F7);

  static const Color btnDanger = Color(0xFFB91939);
  static const Color btnWarning = Color(0xFFF7A832);
  static const Color btnSafe = Color(0xFF86BC26);
  static const Color btnVerySafe = Color(0xFF008036);
  static const Color line = Color(0xFFD9D9D9);
  static const Color thirdBackground = Color(0xFFE1E9EB);

  // ── Light mode ─────────────────────────────────────────────────────────────
  static const Color fillCanvasLight = Color(0xFFF4FBFD);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color cornerLight = Color(0xFFEEEEF3);
  static const Color textPrimaryLight = Color(0xFF263238);
  static const Color textSecondaryLight = Color(0xFF000000);
  static const Color secondaryLight = Color(0xFFB9E7FC);

  // ── Dark mode ──────────────────────────────────────────────────────────────
  static const Color fillCanvasDark = Color(0xFF181919);
  static const Color backgroundDark = Color(0xFF333333);
  static const Color cornerDark = Color(0xFF5F5F61);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color secondaryDark = Color(0xFF204E63);
  
  // No explicit dark equivalent provided for textSecondary in the Figma spec;
  // using a high-contrast light grey that pairs well with the dark surface.
  static const Color textSecondaryDark = Color(0xFFE0E0E0);
}

// ── THEME EXTENSION ───────────────────────────────────────────────────────────
// Registered on [ThemeData] so every widget can resolve the correct colour for
// the active brightness via:
//   Theme.of(context).extension<AppColorsExtension>()!.fillCanvas
// ─────────────────────────────────────────────────────────────────────────────
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.primary,
    required this.btnDanger,
    required this.btnWarning,
    required this.btnSafe,
    required this.btnVerySafe,
    required this.line,
    required this.thirdBackground,
    required this.fillCanvas,
    required this.background,
    required this.corner,
    required this.textPrimary,
    required this.secondary,
    required this.textSecondary,
  });

  // ── Universal ──────────────────────────────────────────────────────────────
  final Color primary;
  final Color btnDanger;
  final Color btnWarning;
  final Color btnSafe;
  final Color btnVerySafe;
  final Color line;
  final Color thirdBackground;

  // ── Dynamic (brightness-aware) ─────────────────────────────────────────────
  final Color fillCanvas;
  final Color background;
  final Color corner;
  final Color textPrimary;
  final Color secondary;
  final Color textSecondary;

  // ── Pre-built instances ─────────────────────────────────────────────────────
  static const AppColorsExtension light = AppColorsExtension(
    primary: _AppColors.primary,
    btnDanger: _AppColors.btnDanger,
    btnWarning: _AppColors.btnWarning,
    btnSafe: _AppColors.btnSafe,
    btnVerySafe: _AppColors.btnVerySafe,
    line: _AppColors.line,
    thirdBackground: _AppColors.thirdBackground,
    fillCanvas: _AppColors.fillCanvasLight,
    background: _AppColors.backgroundLight,
    corner: _AppColors.cornerLight,
    textPrimary: _AppColors.textPrimaryLight,
    secondary: _AppColors.secondaryLight,
    textSecondary: _AppColors.textSecondaryLight,
  );

  static const AppColorsExtension dark = AppColorsExtension(
    primary: _AppColors.primary,
    btnDanger: _AppColors.btnDanger,
    btnWarning: _AppColors.btnWarning,
    btnSafe: _AppColors.btnSafe,
    btnVerySafe: _AppColors.btnVerySafe,
    line: _AppColors.line,
    thirdBackground: _AppColors.thirdBackground,
    fillCanvas: _AppColors.fillCanvasDark,
    background: _AppColors.backgroundDark,
    corner: _AppColors.cornerDark,
    textPrimary: _AppColors.textPrimaryDark,
    secondary: _AppColors.secondaryDark,
    textSecondary: _AppColors.textSecondaryDark,
  );

  // ── ThemeExtension contract ─────────────────────────────────────────────────

  @override
  AppColorsExtension copyWith({
    Color? primary,
    Color? btnDanger,
    Color? btnWarning,
    Color? btnSafe,
    Color? btnVerySafe,
    Color? line,
    Color? thirdBackground,
    Color? fillCanvas,
    Color? background,
    Color? corner,
    Color? textPrimary,
    Color? secondary,
    Color? textSecondary,
  }) {
    return AppColorsExtension(
      primary: primary ?? this.primary,
      btnDanger: btnDanger ?? this.btnDanger,
      btnWarning: btnWarning ?? this.btnWarning,
      btnSafe: btnSafe ?? this.btnSafe,
      btnVerySafe: btnVerySafe ?? this.btnVerySafe,
      line: line ?? this.line,
      thirdBackground: thirdBackground ?? this.thirdBackground,
      fillCanvas: fillCanvas ?? this.fillCanvas,
      background: background ?? this.background,
      corner: corner ?? this.corner,
      textPrimary: textPrimary ?? this.textPrimary,
      secondary: secondary ?? this.secondary,
      textSecondary: textSecondary ?? this.textSecondary,
    );
  }

  /// Flutter calls this when animating between themes (e.g., during a
  /// brightness transition). Linear-interpolates every colour field.
  @override
  AppColorsExtension lerp(AppColorsExtension? other, double t) {
    if (other == null) return this;
    return AppColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      btnDanger: Color.lerp(btnDanger, other.btnDanger, t)!,
      btnWarning: Color.lerp(btnWarning, other.btnWarning, t)!,
      btnSafe: Color.lerp(btnSafe, other.btnSafe, t)!,
      btnVerySafe: Color.lerp(btnVerySafe, other.btnVerySafe, t)!,
      line: Color.lerp(line, other.line, t)!,
      thirdBackground: Color.lerp(thirdBackground, other.thirdBackground, t)!,
      fillCanvas: Color.lerp(fillCanvas, other.fillCanvas, t)!,
      background: Color.lerp(background, other.background, t)!,
      corner: Color.lerp(corner, other.corner, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
    );
  }
}
