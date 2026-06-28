import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import 'label_detail_screen.dart';

class ProductInfoScreen extends StatelessWidget {
  final String name;
  final String volume;
  final String imageUrl;
  final String ingredients;
  final String nutritionFacts;
  final String healthGrade;

  const ProductInfoScreen({
    super.key,
    required this.name,
    required this.volume,
    required this.imageUrl,
    required this.ingredients,
    required this.nutritionFacts,
    required this.healthGrade,
  });

  Color _getHealthGradeColor(String grade, AppColorsExtension colors) {
    switch (grade.toLowerCase()) {
      case 'waspada':
        return colors.btnDanger;
      case 'hati-hati':
        return colors.btnWarning;
      case 'aman':
        return colors.btnSafe;
      case 'sangat aman':
        return colors.btnVerySafe;
      default:
        return colors.line;
    }
  }

  List<TextSpan> _buildSmartNutritionText(String text, TextStyle baseStyle) {
    final boldStyle = baseStyle.copyWith(fontWeight: FontWeight.bold);
    
    // Find substring starting with "Gula" and ending with "g"
    final regex = RegExp(r'(Gula.*?g\b)', caseSensitive: false);
    final matches = regex.allMatches(text);

    if (matches.isEmpty) {
      return [TextSpan(text: text, style: baseStyle)];
    }

    final spans = <TextSpan>[];
    int currentIndex = 0;

    for (final match in matches) {
      if (match.start > currentIndex) {
        spans.add(TextSpan(text: text.substring(currentIndex, match.start), style: baseStyle));
      }
      spans.add(TextSpan(text: text.substring(match.start, match.end), style: boldStyle));
      currentIndex = match.end;
    }

    if (currentIndex < text.length) {
      spans.add(TextSpan(text: text.substring(currentIndex), style: baseStyle));
    }

    return spans;
  }

  Widget _buildWhiteCard({
    required Widget child,
    double borderRadius = 24.0,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      width: double.infinity,
      margin: margin,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000), // rgba(0,0,0,0.25)
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return Scaffold(
      backgroundColor: colors.fillCanvas,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      'assets/icons/ic_back.svg',
                      width: 32,
                      height: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Informasi',
                      style: AppTextStyles.pageTitle.copyWith(color: colors.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
            
            // Body Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: _buildWhiteCard(
                  borderRadius: 24.0,
                  padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                  child: Column(
                    children: [
                      // Title
                      Text(
                        'INFORMASI PRODUK',
                        style: AppTextStyles.secondaryText.copyWith(color: colors.textPrimary),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      
                      // Product Image
                      Container(
                        height: 140,
                        alignment: Alignment.center,
                        child: Image.asset(
                          imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => 
                              const SizedBox(
                                height: 140,
                                child: Icon(Icons.image_not_supported, color: Colors.grey, size: 100),
                              ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Product Name
                      Text(
                        name,
                        style: AppTextStyles.beverageNameTitle.copyWith(color: colors.textPrimary),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      
                      // Volume
                      Text(
                        volume,
                        style: AppTextStyles.readingText.copyWith(color: colors.textPrimary),
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Inner Card (Card 2)
                      _buildWhiteCard(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        borderRadius: 12.0,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Komposisi :',
                              style: AppTextStyles.readingTitle.copyWith(color: colors.textPrimary),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              ingredients,
                              style: AppTextStyles.readingText.copyWith(color: colors.textPrimary),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 16),
                            Divider(color: colors.line, thickness: 1, height: 1),
                            const SizedBox(height: 16),
                            Text(
                              'Gizi :',
                              style: AppTextStyles.readingTitle.copyWith(color: colors.textPrimary),
                            ),
                            const SizedBox(height: 8),
                            RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                children: _buildSmartNutritionText(
                                  nutritionFacts,
                                  AppTextStyles.readingText.copyWith(color: colors.textPrimary),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Health Grade Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LabelDetailScreen(healthGrade: healthGrade),
                                ),
                              );
                            },
                            child: Container(
                              width: 200,
                              height: 56,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: _getHealthGradeColor(healthGrade, colors),
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x40000000), // Figma effect_AETROX
                                    offset: Offset(0, 4),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Text(
                                healthGrade,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
