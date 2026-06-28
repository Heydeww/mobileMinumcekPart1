import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minum_cekk_app/core/app_colors.dart';
import 'package:minum_cekk_app/core/app_text_styles.dart';
import 'package:minum_cekk_app/widgets/status_label_button.dart';
import 'package:minum_cekk_app/screens/label_detail_screen.dart';

class PentingScreen extends StatelessWidget {
  const PentingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return Scaffold(
      backgroundColor: colors.fillCanvas,
      body: SafeArea(
        child: Column(
          children: [
            // ── Custom AppBar ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    behavior: HitTestBehavior.opaque,
                    child: SvgPicture.asset(
                      'assets/icons/ic_back.svg',
                      width: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Penting',
                    style: AppTextStyles.pageTitle.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            // ── Main Content (The White Card) ──
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colors.background,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x40000000), // rgba(0, 0, 0, 0.25)
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Nutri-Grade',
                          style: AppTextStyles.secondTitle.copyWith(
                            color: colors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Bagaimana cara kita untuk mengetahui Label kesehatan dari setiap minuman?',
                          style: AppTextStyles.readingText.copyWith(
                            color: colors.textPrimary,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Menurut Aturan WHO :',
                          style: AppTextStyles.secondTitle.copyWith(
                            color: colors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'WHO (World Health Organization) atau Badan Kesehatan Dunia menyarankan kita untuk mengkonsumi gula dalam batasan tertentu!',
                          style: AppTextStyles.readingText.copyWith(
                            color: colors.textPrimary,
                          ),
                          textAlign: TextAlign.justify,
                        ),

                        Divider(color: colors.line, thickness: 3, height: 32),

                        
                        // Waspada
                        Align(
                          alignment: Alignment.centerLeft,
                          child: StatusLabelButton(
                            text: 'Waspada',
                            backgroundColor: colors.btnDanger,
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LabelDetailScreen(healthGrade: 'Waspada'))),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Hindari konsumsi gula dari minuman kemasan lebih dari 25 gram sehari. Melebihi batas optimal WHO (25g) dalam satu sajian. Sangat berisiko melebihi batas maksimal (50g) konsumsi gula dalam sehari.',
                          style: AppTextStyles.readingText.copyWith(
                            color: colors.textPrimary,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        
                        Divider(color: colors.line, thickness: 3, height: 32),
                        
                        // Hati-Hati
                        Align(
                          alignment: Alignment.centerLeft,
                          child: StatusLabelButton(
                            text: 'Hati-Hati',
                            backgroundColor: colors.btnWarning,
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LabelDetailScreen(healthGrade: 'Hati-Hati'))),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Konsumsi gula dari minuman kemasan lebih dari 8 gram dan kurang dari sama dengan 25 gram sehari. Mencapai/mendekati batas optimal (25g). Satu botol sudah cukup untuk jatah gula tambahan hari itu.',
                          style: AppTextStyles.readingText.copyWith(
                            color: colors.textPrimary,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        
                        Divider(color: colors.line, thickness: 3, height: 32),
                        
                        // Aman
                        Align(
                          alignment: Alignment.centerLeft,
                          child: StatusLabelButton(
                            text: 'Aman',
                            backgroundColor: colors.btnSafe,
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LabelDetailScreen(healthGrade: 'Aman'))),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Konsumsi gula dari minuman kemasan lebih dari 1 gram dan kurang dari sama dengan 8 gram sehari. Aman dikonsumsi 1-2 kali sehari, idealnya tidak lebih dari 2 kemasan dalam sehari dengan jumlah gula kemasan minuman yang sama.',
                          style: AppTextStyles.readingText.copyWith(
                            color: colors.textPrimary,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        
                        Divider(color: colors.line, thickness: 3, height: 32),
                        
                        // Sangat Aman
                        Align(
                          alignment: Alignment.centerLeft,
                          child: StatusLabelButton(
                            text: 'Sangat Aman',
                            backgroundColor: colors.btnVerySafe,
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LabelDetailScreen(healthGrade: 'Sangat Aman'))),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Konsumsi gula dari minuman kemasan kurang dari sama dengan 1 gram sehari, Menyumbang hampir nol pada batas harian. Bebas dikonsumsi kapan saja sebagai pengganti air.',
                          style: AppTextStyles.readingText.copyWith(
                            color: colors.textPrimary,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        
                        Divider(color: colors.line, thickness: 3, height: 32),
                        
                        // WHO
                        Align(
                          alignment: Alignment.centerLeft,
                          child: StatusLabelButton(
                            text: 'WHO',
                            backgroundColor: const Color(0xFF204E63), // Dark blue specified by Figma
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'WHO calls on countries to reduce sugars intake among adults and children',
                          style: AppTextStyles.readingText.copyWith(
                            color: colors.textPrimary,
                            decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
