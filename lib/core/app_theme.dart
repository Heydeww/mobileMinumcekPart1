import 'package:flutter/material.dart';

import 'app_colors.dart';

// ── APP THEME ─────────────────────────────────────────────────────────────────
// Single source of truth for ThemeData. Consume in MaterialApp like:
//
//   MaterialApp(
//     theme:      AppTheme.lightTheme,
//     darkTheme:  AppTheme.darkTheme,
//     themeMode:  ThemeMode.system,   // or ThemeMode.light / .dark
//   )
//
// Then read extension colours anywhere in the widget tree:
//
//   final colors = Theme.of(context).extension<AppColorsExtension>()!;
//   Container(color: colors.fillCanvas);
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppTheme {
  AppTheme._(); // Non-instantiable utility class.

  // ── Shared typography ───────────────────────────────────────────────────────
  // Defined once and referenced by both themes to keep them in sync.
  static const String _fontFamily = 'Poppins'; // Swap to your project font.

  // ── Light theme ─────────────────────────────────────────────────────────────
  static ThemeData get lightTheme => _build(
        brightness: Brightness.light,
        colors: AppColorsExtension.light,
      );

  // ── Dark theme ──────────────────────────────────────────────────────────────
  static ThemeData get darkTheme => _build(
        brightness: Brightness.dark,
        colors: AppColorsExtension.dark,
      );

  // ── Internal builder ────────────────────────────────────────────────────────
  // Kept private so callers never bypass the light/dark API above.
  static ThemeData _build({
    required Brightness brightness,
    required AppColorsExtension colors,
  }) {
    final bool isLight = brightness == Brightness.light;

    // Seed a M3-compatible ColorScheme from our primary & surface tokens.
    // Only a subset of the generated colours will actually surface in widgets
    // because we override all custom surfaces via AppColorsExtension.
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: colors.primary,
      onPrimary: isLight ? Colors.white : Colors.black,
      primaryContainer: colors.corner,
      onPrimaryContainer: colors.textPrimary,
      secondary: colors.secondary,
      onSecondary: isLight ? Colors.white : Colors.black,
      secondaryContainer: colors.thirdBackground,
      onSecondaryContainer: colors.textPrimary,
      surface: colors.background,
      onSurface: colors.textPrimary,
      error: colors.btnDanger,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      fontFamily: _fontFamily,
      scaffoldBackgroundColor: colors.fillCanvas,

      // ── AppBar ──────────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: colors.fillCanvas,
        foregroundColor: colors.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: colors.textPrimary,
        ),
        iconTheme: IconThemeData(color: colors.textPrimary),
      ),

      // ── ElevatedButton ──────────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: isLight ? Colors.black : Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: TextStyle(
            fontFamily: _fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ── OutlinedButton ──────────────────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          side: BorderSide(color: colors.primary, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: TextStyle(
            fontFamily: _fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ── Card ────────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: colors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.zero,
      ),

      // ── Divider ─────────────────────────────────────────────────────────────
      dividerTheme: DividerThemeData(
        color: colors.line,
        thickness: 1,
        space: 1,
      ),

      // ── BottomNavigationBar ─────────────────────────────────────────────────
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.primary,
        selectedItemColor: isLight ? Colors.black : Colors.white,
        unselectedItemColor: isLight ? Colors.black87 : Colors.white70,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 12,
        ),
      ),

      // ── SnackBar ────────────────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.secondary,
        contentTextStyle: TextStyle(
          fontFamily: _fontFamily,
          color: isLight ? Colors.white : Colors.black,
          fontSize: 14,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // ── Global text styles (base/body only — override per-screen as needed) ─
      textTheme: TextTheme(
        // Headlines
        headlineLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: colors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: colors.textPrimary,
        ),
        headlineSmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colors.textPrimary,
        ),
        // Body
        bodyLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: colors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: colors.textPrimary,
        ),
        bodySmall: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: colors.textSecondary,
        ),
        // Labels
        labelLarge: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: colors.textPrimary,
        ),
      ),

      // ── Custom extensions ───────────────────────────────────────────────────
      // Registered here so they are available anywhere via Theme.of(context).
      extensions: <ThemeExtension<dynamic>>[colors],
    );
  }
}
