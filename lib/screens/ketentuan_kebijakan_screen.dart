import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/app_text_styles.dart';

class KetentuanKebijakanScreen extends StatelessWidget {
  const KetentuanKebijakanScreen({super.key});

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
                        'Ketentuan & Kebijakan',
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
                      // Long text mapping
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
    final List<String> paragraphs = [
      'I. Syarat & Ketentuan Penggunaan (S&K)',
      'A. Disclaimer (Penyangkalan Tanggung Jawab)',
      'Bagian ini sangat penting karena aplikasi Anda memberikan rekomendasi kesehatan. Anda harus melepaskan diri dari tanggung jawab sebagai penyedia layanan medis.',
      '1. Bukan Saran Medis: Aplikasi ini MinumCek bukan merupakan pengganti saran medis, diagnosis, atau perawatan profesional dari dokter, ahli gizi terdaftar, atau profesional kesehatan lainnya.',
      '2. Tanggung Jawab Pengguna: Semua informasi, label kategori (SANGAT AMAN, AMAN, HATI-HATI, WASPADA), dan rekomendasi yang diberikan adalah panduan edukasi berdasarkan standar kesehatan publik (WHO) dan harus digunakan atas risiko dan tanggung jawab penuh pengguna.',
      '3. Variabilitas Produk: Kandungan gula pada produk kemasan dapat berubah sewaktu-waktu. Pengguna wajib memverifikasi informasi gula pada label nutrisi produk sebelum mengonsumsi.',
      'B. Dasar Metodologi Pelabelan',
      'Anda perlu menjelaskan bahwa sistem kategori Anda bukan aturan subjektif, melainkan berbasis sains.',
      '1. Acuan Utama: Sistem pelabelan 4 Kategori Gula (Sangat Aman, Aman, Hati-Hati, Waspada) didasarkan pada Rekomendasi Batas Optimal Gula Bebas dari Organisasi Kesehatan Dunia (WHO) Guideline: Sugars intake for adults and children (2015), yaitu maksimal 25 gram gula bebas per hari.',
      '2. Klasifikasi Gula: Angka batasan mengacu pada Gula Bebas (Free Sugars), yaitu semua monosakarida dan disakarida yang ditambahkan ke makanan/minuman oleh produsen, juru masak, atau konsumen, ditambah gula yang secara alami ada dalam madu, sirup, dan jus buah.',
      '3. Prinsip Anak: Klasifikasi untuk Anak-anak (8_gram<Gula≤25_gram) dipertahankan untuk kesederhanaan desain, namun pengguna diwajibkan memperhatikan peringatan tambahan bahwa minuman mendekati 20 gram sudah melebihi batas optimal untuk sebagian besar anak.',
      'II. Kebijakan Privasi (KP)',
      'Karena Anda mungkin menyimpan data profil usia (Dewasa/Anak), Anda harus memastikan kepatuhan terhadap UU Perlindungan Data Pribadi (UU PDP).',
      'A. Jenis Data yang Dikumpulkan',
      '1. Data Non-Personal: Data teknis (misalnya, jenis perangkat, waktu penggunaan, crash reports). Digunakan untuk meningkatkan kualitas aplikasi.',
      '2. Data Aktivitas Aplikasi: Riwayat minuman yang dipindai/dicari oleh pengguna.',
      'B. Tujuan Penggunaan Data',
      'Kami menggunakan data Anda hanya untuk tujuan berikut:',
      '1. Personalisasi Layanan: Untuk menyesuaikan label peringatan gula (Sangat Aman hingga Waspada) secara spesifik berdasarkan kategori usia yang Anda pilih (Dewasa atau Anak).',
      '2. Analisis Agregat: Untuk menganalisis tren konsumsi minuman kemasan secara umum (misalnya, minuman apa yang paling sering dicari). Data ini selalu dianonimkan (tidak dapat diidentifikasi kembali kepada individu pengguna).',
      '3. Keamanan: Untuk mencegah bug, fraud, atau penyalahgunaan layanan.',
      'C. Keamanan Data',
      'Kami berkomitmen untuk melindungi data pribadi Anda melalui enkripsi dan prosedur keamanan standar industri. Kami tidak akan menjual atau menyewakan Data Pribadi Anda kepada pihak ketiga manapun.',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paragraphs.map((text) {
        TextStyle style;
        double topPadding = 12.0;

        if (text.startsWith('I. ') || text.startsWith('II. ')) {
          style = AppTextStyles.readingTitle.copyWith(color: color);
          topPadding = 24.0;
        } else if (text.startsWith('A. ') || text.startsWith('B. ') || text.startsWith('C. ')) {
          style = AppTextStyles.newsButtonText.copyWith(color: color);
          topPadding = 16.0;
        } else {
          style = AppTextStyles.readingText.copyWith(color: color);
          topPadding = 8.0;
        }

        if (text == paragraphs.first) {
          topPadding = 0;
        }

        return Padding(
          padding: EdgeInsets.only(top: topPadding),
          child: Text(
            text,
            style: style,
            textAlign: TextAlign.justify,
          ),
        );
      }).toList(),
    );
  }
}
