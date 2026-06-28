import 'package:flutter/material.dart';
import 'package:minum_cekk_app/core/app_colors.dart';
import 'package:minum_cekk_app/core/app_text_styles.dart';

// ── PRODUCT CARD ──────────────────────────────────────────────────────────────
// A fixed-size product card used in horizontal scroll lists on the Home Screen.
//
// DESIGN SPEC:
//   • Card size          : 176 × 196 px
//   • Border radius      : 16 px
//   • Background         : colors.background  (#FFFFFF)
//   • Border             : 8 px, colors.corner (#EEEEF3 / #5F5F61)
//   • Image zone         : 100 px fixed height bounding box
//   • Product name style : AppTextStyles.readingText
//   • Volume style       : AppTextStyles.beverageDetail
//
// USAGE:
//   ProductCard(
//     imageUrl: product.imageUrl,
//     productName: product.name,
//     volume: product.volume,
//     onTap: () => Navigator.pushNamed(context, '/detail', arguments: product),
//   )
// ─────────────────────────────────────────────────────────────────────────────

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.volume,
    this.onTap,
  });

  /// Asset URL for the product bottle image. Renders a placeholder on empty/error.
  final String imageUrl;

  /// Display name of the product (e.g. "Coca-Cola").
  final String productName;

  /// Volume string (e.g. "390ml").
  final String volume;

  /// Optional tap callback — attach navigation / detail sheet here.
  final VoidCallback? onTap;

  // ── Design tokens ──────────────────────────────────────
  static const double _cardHeight = 196;
  static const double _cardWidth = 176;
  static const double _borderRadius = 16;
  static const double _borderWidth = 8;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: _cardWidth,
        height: _cardHeight,
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: BorderRadius.circular(_borderRadius),
          border: Border.all(
            color: colors.corner,
            width: _borderWidth,
          ),
        ),
        // ClipRRect ensures the image never bleeds outside the rounded card.
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_borderRadius - _borderWidth),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── Product image ─────────────────────────────────────────
              _ProductImage(imageUrl: imageUrl),

              const SizedBox(height: 8),

              // ── Product name ──────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  productName,
                  style: AppTextStyles.readingText.copyWith(
                    color: colors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 4),

              // ── Volume ────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  volume,
                  style: AppTextStyles.beverageDetail.copyWith(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Private image loader ──────────────────────────────────────────────────────
// Handles three states cleanly: empty URL, loading, and load error.
class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) return const SizedBox(height: 100, child: _Placeholder());

    return SizedBox(
      height: 100, // Enforce strict bounding box
      width: double.infinity,
      child: Image.asset(
        imageUrl,
        fit: BoxFit.contain, // scales proportionally without cropping
        errorBuilder: (context, error, stackTrace) => const _Placeholder(),
      ),
    );
  }
}

// ── Placeholder (empty URL or load error) ─────────────────────────────────────
class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Icon(
      Icons.local_drink_outlined,
      size: 40,
      color: colors.corner,
    );
  }
}
