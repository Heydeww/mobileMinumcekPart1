import 'package:flutter/material.dart';
import 'package:minum_cekk_app/core/app_text_styles.dart';

// ── STATUS LABEL BUTTON ────────────────────────────────────────────────────────
// A purely decorative status badge derived from the Figma design (node 6228-13506).
//
// DESIGN SPEC (extracted via Figma MCP):
//   • Size          : 200 × 56 px
//   • Border radius : 16 px
//   • Drop shadow   : 0 4 4 0 rgba(0,0,0,0.25)
//   • Typography    : AppTextStyles.secondaryText  (Poppins 24 SemiBold — exact match)
//   • Text color    : Colors.white  (universal across all variants)
//
// USAGE EXAMPLE:
//   final colors = Theme.of(context).extension<AppColorsExtension>()!;
//
//   StatusLabelButton(
//     text: 'Waspada',
//     backgroundColor: colors.btnDanger,
//   );
//
// VARIANTS:
//   Waspada     → colors.btnDanger    (#B91939)
//   Hati-Hati   → colors.btnWarning   (#F7A832)
//   Aman        → colors.btnSafe      (#86BC26)
//   Sangat Aman → colors.btnVerySafe  (#008036)
// ─────────────────────────────────────────────────────────────────────────────

class StatusLabelButton extends StatelessWidget {
  const StatusLabelButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    this.onPressed,
  });

  /// The label text rendered inside the button (e.g. "Waspada", "Aman").
  final String text;

  /// Background color token — pass the appropriate color from [AppColorsExtension].
  /// e.g. `Theme.of(context).extension<AppColorsExtension>()!.btnDanger`
  final Color backgroundColor;

  /// Optional callback. The widget itself is non-interactive by default;
  /// wrap with [GestureDetector] or use this callback when interactions
  /// are needed in a future sprint.
  final VoidCallback? onPressed;

  // ── Design tokens (Figma-extracted) ──────────────────────────────────────
  static const double _width = 200;
  static const double _height = 56;
  static const double _borderRadius = 16;

  @override
  Widget build(BuildContext context) {
    final Widget badge = Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(_borderRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000), // rgba(0, 0, 0, 0.25)
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: AppTextStyles.secondaryText.copyWith(
          color: Colors.white,
          height: 1.5, // Figma lineHeight: 1.5em
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );

    if (onPressed != null) {
      return GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: badge,
      );
    }

    return badge;
  }
}
