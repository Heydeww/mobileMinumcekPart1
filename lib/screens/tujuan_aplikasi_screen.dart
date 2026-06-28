import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/app_text_styles.dart';

class TujuanAplikasiScreen extends StatelessWidget {
  const TujuanAplikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFFF4FBFD);
    const Color textColor = Color(0xFF000000);
    const Color contentTextColor = Color(0xFF263238);

    return Scaffold(
      backgroundColor: bgColor,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header (Back Button & Title) ─────────────────────────
            Padding(
              padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    behavior: HitTestBehavior.opaque,
                    child: SvgPicture.asset(
                      'assets/icons/ic_back.svg',
                      width: 32,
                      height: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Pengaturan',
                    style: AppTextStyles.pageTitle.copyWith(
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24), // Gap from header to card

            // ── Scrollable Content ───────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x40000000), // rgba(0,0,0,0.25)
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Tujuan Aplikasi Ini',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.secondTitle.copyWith(
                          color: contentTextColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'MinumCek',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.newsText.copyWith(
                          color: contentTextColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 4,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Long text mapping with bullet lists
                      _buildTextContent(contentTextColor),
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

  Widget _buildTextContent(Color color) {
    // List of map: section title -> list of bullet points
    final List<Map<String, dynamic>> sections = [
      {
        'heading': '1. Tujuan Utama: Edukasi dan Peningkatan Kesadaran Gizi',
        'bullets': [
          'Menyediakan Penilaian Risiko Gula Cepat: Tujuan utama kami adalah memberikan informasi akurat dan cepat mengenai potensi kandungan gula suatu minuman melalui sistem 4 label risiko (SANGAT AMAN hingga WASPADA).',
          'Membantu Pengambilan Keputusan Sehat: Kami bertujuan memberdayakan masyarakat untuk membuat pilihan minuman yang lebih sehat secara real-time, membantu pengguna secara proaktif menghindari minuman yang melebihi batas gula optimal harian yang direkomendasikan oleh WHO.',
        ],
      },
      {
        'heading': '2. Memastikan Keakuratan Data Produk yang Berkesinambungan',
        'bullets': [
          'Memperbarui Database Produk: Data anonim dari pemindaian membantu kami mengidentifikasi minuman apa saja yang paling sering dicari. Hal ini memprioritaskan tim kami untuk memastikan informasi nutrisi dan label risiko dari minuman-minuman populer tersebut selalu akurat dan mutakhir.',
          'Meningkatkan Kemampuan Deteksi: Kami menggunakan data non-personal dari foto yang dipindai untuk terus melatih dan menyempurnakan kemampuan aplikasi dalam mengenali berbagai merek, varian, dan ukuran minuman yang beredar luas di pasar Indonesia.',
        ],
      },
      {
        'heading': '3. Membangun Basis Data Konsumsi Nasional (Anonim)',
        'bullets': [
          'Mendukung Kesehatan Publik: Kami bertujuan mengumpulkan data statistik (tanpa identitas individu) tentang kecenderungan kategori gula yang dipindai oleh pengguna. Statistik anonim ini dapat digunakan untuk tujuan penelitian atau untuk menyoroti urgensi masalah konsumsi gula tinggi di Indonesia.',
        ],
      },
      {
        'heading': '4. Menjamin Kualitas dan Kinerja Aplikasi',
        'bullets': [
          'Pemeliharaan Sistem: Data teknis digunakan untuk memantau kinerja, mengidentifikasi kesalahan (bug), dan melakukan perbaikan yang diperlukan agar aplikasi tetap stabil dan cepat saat digunakan.',
        ],
      },
    ];

    List<Widget> contentWidgets = [];

    for (int i = 0; i < sections.length; i++) {
      final section = sections[i];
      final heading = section['heading'] as String;
      final bullets = section['bullets'] as List<String>;

      // Add Heading
      contentWidgets.add(
        Padding(
          padding: EdgeInsets.only(top: i == 0 ? 0 : 24.0),
          child: Text(
            heading,
            style: AppTextStyles.readingTitle.copyWith(color: color),
            textAlign: TextAlign.justify,
          ),
        ),
      );

      // Add Bullets
      for (final bullet in bullets) {
        contentWidgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bullet point widget
                Padding(
                  padding: const EdgeInsets.only(top: 7.0, right: 12.0, left: 4.0),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // Text content
                Expanded(
                  child: Text(
                    bullet,
                    style: AppTextStyles.readingText.copyWith(color: color),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: contentWidgets,
    );
  }
}
