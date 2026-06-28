import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/app_colors.dart';
import '../core/app_text_styles.dart';

// ── PHOTO VALIDATION SCREEN ───────────────────────────────────────────────────
//
// This screen acts as a "checkpoint" between taking a photo and sending it to
// the AI API.  The user can either:
//   • BATALKAN  → Navigator.pop(context, false)  — discard and return to camera
//   • PINDAI MINUMAN → Navigator.pop(context, true)  — proceed with AI scan
//
// The caller (ScannerScreen) awaits the boolean result and acts accordingly.
// The Gallery flow bypasses this screen entirely (per product specification).
// ─────────────────────────────────────────────────────────────────────────────

class PhotoValidationScreen extends StatelessWidget {
  /// Absolute file-system path of the captured image.
  final String imagePath;

  const PhotoValidationScreen({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    // ── Layout proportions derived from Figma frame (440 × 956) ─────────────
    // Card group:   x=16, y=152 → w=408, h=451
    // Inner image:  x=29+16=45, y=34+152=186 → w=350, h=384
    // Question tx:  y=627 (offset from 152+451=603 → 24px below card)
    // Sub text:     y=693
    // BATALKAN btn: x=16, y=731 → w=192, h=48
    // PINDAI btn:   x=232, y=731 → w=192, h=48
    // ─────────────────────────────────────────────────────────────────────────

    return Scaffold(
      backgroundColor: colors.fillCanvas,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Header ───────────────────────────────────────────────────────
            // Mirrors the pattern used by ProductInfoScreen / PentingScreen:
            // ic_back.svg (32×32) + title text, horizontal padding 16.
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context, false),
                    child: SvgPicture.asset(
                      'assets/icons/ic_back.svg',
                      width: 32,
                      height: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Pindai Minuman',
                      style: AppTextStyles.pageTitle.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Body ─────────────────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── White card with captured image ────────────────────────
                    // Figma: Rectangle 408x — w=408, h=451, borderRadius=24,
                    //        shadow = 0 4 4 0 rgba(0,0,0,0.25)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x40000000), // rgba(0,0,0,0.25)
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      // Inner padding mirrors Figma inner-rect offset:
                      // x=29, y=34 inside the 408×451 card.
                      padding: const EdgeInsets.fromLTRB(29, 34, 29, 34),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: AspectRatio(
                          // Inner rect ratio: 350 / 384 ≈ 0.9115
                          aspectRatio: 350 / 384,
                          child: Image.file(
                            File(imagePath),
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Center(
                              child: Icon(
                                Icons.broken_image_outlined,
                                size: 80,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Question text ─────────────────────────────────────────
                    // Figma style_PJNIYD: Poppins 600, 24px, center-aligned,
                    // fill = #000000 (textSecondary in light mode).
                    Text(
                      'APAKAH FOTO MINUMAN SUDAH\nSESUAI?',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.secondaryText.copyWith(
                        color: colors.textSecondary,
                        height: 1.377,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // ── Sub-text hint ─────────────────────────────────────────
                    // Figma style_UBGNS6: Poppins 600, 10px.
                    Text(
                      '(Pastikan merek dan volume produk bisa terlihat dalam satu foto)',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.beverageDetail.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Action buttons row ────────────────────────────────────
                    // Figma: two side-by-side pill buttons, each 192×48,
                    // gap between them = 232-16-192 = 24px.
                    Row(
                      children: [
                        // BATALKAN — fill_DDKRDO = #B91939 (btnDanger)
                        Expanded(
                          child: _ActionButton(
                            label: 'BATALKAN',
                            backgroundColor: colors.btnDanger,
                            onTap: () => Navigator.pop(context, false),
                          ),
                        ),

                        const SizedBox(width: 24),

                        // PINDAI MINUMAN — fill_EAAD0Y = #4FC3F7 (primary)
                        Expanded(
                          child: _ActionButton(
                            label: 'PINDAI MINUMAN',
                            backgroundColor: colors.primary,
                            onTap: () => Navigator.pop(context, true),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Private helper widget ─────────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Figma: height = 48, borderRadius = 50px (full pill)
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000), // rgba(0,0,0,0.25)
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          // Figma style_Q12GBV: Poppins 600, 16px, letterSpacing -3.125%
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5, // ≈ 16 * -0.03125
            color: Colors.white,
            height: 1.6875,
          ),
        ),
      ),
    );
  }
}
