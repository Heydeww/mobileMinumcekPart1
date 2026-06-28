import 'package:flutter/material.dart';

// ── APP TEXT STYLES ───────────────────────────────────────────────────────────
// Single source of truth for every text style in the app.
//
// DESIGN CONTRACT:
//   • All sizes and weights match the Figma specification exactly.
//   • Colors are intentionally OMITTED here. Apply them at the call site
//     using the active AppColorsExtension, e.g.:
//
//       Text(
//         'Hello',
//         style: AppTextStyles.pageTitle.copyWith(
//           color: colors.textPrimary,
//         ),
//       )
//
// INTEGRATION WITH TextTheme (optional):
//   In app_theme.dart, you can map these onto Material's named TextTheme slots
//   inside the _build() method so that widgets that rely on TextTheme
//   (e.g. ListTile, AppBar) automatically use Figma-compliant styles:
//
//     textTheme: TextTheme(
//       headlineLarge : AppTextStyles.pageTitle,
//       headlineMedium: AppTextStyles.secondaryText,
//       headlineSmall : AppTextStyles.subtitle,
//       titleMedium   : AppTextStyles.readingTitle,
//       bodyLarge     : AppTextStyles.readingText,
//       bodyMedium    : AppTextStyles.newsText,
//       bodySmall     : AppTextStyles.beverageDetail,
//       labelLarge    : AppTextStyles.newsButtonText,
//       labelMedium   : AppTextStyles.settingsMenuText,
//       labelSmall    : AppTextStyles.bottomNavText,
//     ).apply(
//       // Propagate the correct foreground color for the current brightness:
//       bodyColor    : colors.textPrimary,
//       displayColor : colors.textPrimary,
//     ),
//
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppTextStyles {
  AppTextStyles._(); // Non-instantiable utility class.

  static const String _font = 'Poppins';

  // ── 1. Judul Page / Page Title ────────────────────────────────────────────
  // Usage: Screen hero title, primary identity text.
  static const TextStyle pageTitle = TextStyle(
    fontFamily: _font,
    fontSize: 40,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  // ── 2. Secondary Text ─────────────────────────────────────────────────────
  // Usage: Section headings, prominent labels below a page title.
  static const TextStyle secondaryText = TextStyle(
    fontFamily: _font,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  // ── 3. Sub Judul / Second Title ──────────────────────────────────────────
  // Usage: Card headers, dialog titles, tab labels.
  static const TextStyle secondTitle = TextStyle(
    fontFamily: _font,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  // ── 4. Judul Text Bacaan / Reading Title ──────────────────────────────────
  // Usage: Article / content block headings.
  static const TextStyle readingTitle = TextStyle(
    fontFamily: _font,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // ── 5. Text Baca / Reading Text ───────────────────────────────────────────
  // Usage: Long-form body copy, paragraphs.
  static const TextStyle readingText = TextStyle(
    fontFamily: _font,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.6, // Generous leading for comfortable reading.
  );

  // ── 6. Text Button Berita / News Button Text ──────────────────────────────
  // Usage: CTA buttons inside news/article cards.
  static const TextStyle newsButtonText = TextStyle(
    fontFamily: _font,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.0,
  );

  // ── 7. Text Berita / News Text ────────────────────────────────────────────
  // Usage: News card body copy, secondary body text.
  static const TextStyle newsText = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  // ── 8. Text Tombol Menu Bawah / Bottom Nav Text ───────────────────────────
  // Usage: BottomNavigationBar labels.
  static const TextStyle bottomNavText = TextStyle(
    fontFamily: _font,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.0,
  );

  // ── 9. Text Tombol Menu Pengaturan / Settings Menu Text ───────────────────
  // Usage: Settings screen list tile labels, secondary small labels.
  static const TextStyle settingsMenuText = TextStyle(
    fontFamily: _font,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  // ── 10. Text Detail Minuman / Beverage Detail Text ────────────────────────
  // Usage: Fine-print details on beverage cards (e.g. volume, sugar content).
  static const TextStyle beverageDetail = TextStyle(
    fontFamily: _font,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );


  // ── 11. Nama Minuman Halaman Informasi / Beverage Name  ────────────────────────
  // Usage: Fine-print details on beverage cards (e.g. volume, sugar content).
  static const TextStyle beverageNameTitle = TextStyle(
    fontFamily: _font,
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );
}
