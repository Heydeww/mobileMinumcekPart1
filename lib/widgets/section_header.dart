import 'package:flutter/material.dart';
import 'package:minum_cekk_app/core/app_colors.dart';
import 'package:minum_cekk_app/core/app_text_styles.dart';

// ── SECTION HEADER ────────────────────────────────────────────────────────────
// The title row that sits above each horizontal product list on the Home Screen.
// Consists of a coloured pill label on the left and a circular arrow button on
// the right, separated by a flexible spacer so it spans any screen width.
//
// DESIGN SPEC (extracted via Figma MCP, node 6228-13521 "GO RIGHT"):
//   • Row height      : 48 px
//   • Pill size       : 240 × 48 px
//   • Pill radius     : 24 px (full stadium / pill shape)
//   • Pill text pad   : left 43 px, vertically centred
//   • Pill text style : AppTextStyles.secondTitle (Poppins 20 SemiBold — exact match)
//   • Pill text color : Colors.white
//   • Arrow button    : 48 × 48 px circle, shadow 0 4 4 rgba(0,0,0,0.25)
//   • Arrow icon      : Icons.chevron_right, color = colors.textPrimary
//
// USAGE:
//   SectionHeader(
//     title: 'Minuman Populer',
//     pillColor: colors.primary,
//     onArrowTap: () => Navigator.pushNamed(context, '/popular'),
//   )
// ─────────────────────────────────────────────────────────────────────────────

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    required this.pillColor,
    this.onArrowTap,
  });

  /// The label displayed inside the coloured pill (e.g. "Minuman Populer").
  final String title;

  /// Background color of the pill — pass a token from [AppColorsExtension].
  final Color pillColor;

  /// Called when the right-arrow circle button is tapped.
  final VoidCallback? onArrowTap;

  // ── Design tokens (Figma-extracted) ──────────────────────────────────────
  static const double _rowHeight = 48;
  static const double _pillWidth = 240;
  static const double _pillRadius = 50; // full stadium pill
  static const double _pillTextPaddingLeft = 43;
  static const double _arrowButtonSize = 48;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return SizedBox(
      height: _rowHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Coloured pill label ─────────────────────────────────────────
          Container(
            decoration: BoxDecoration(
              color: pillColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(_pillRadius),
                bottomRight: Radius.circular(_pillRadius),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              title,
              style: AppTextStyles.secondTitle.copyWith(
                color: Colors.white,
                height: 1.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // ── Flexible gap (fills remaining row width) ────────────────────
          const Spacer(),

          // ── Circular arrow button ───────────────────────────────────────
          GestureDetector(
            onTap: onArrowTap,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: _arrowButtonSize,
              height: _arrowButtonSize,
              decoration: BoxDecoration(
                color: colors.background,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x40000000), // rgba(0, 0, 0, 0.25)
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Icon(
                Icons.chevron_right,
                color: colors.textPrimary,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
