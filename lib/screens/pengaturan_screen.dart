import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/app_text_styles.dart';
import 'ketentuan_kebijakan_screen.dart';
import 'tujuan_aplikasi_screen.dart';
// ── PENGATURAN SCREEN ────────────────────────────────────────────────────────
// Figma source : MinumCek ANAK GRANDWIS → node 8324:12840 ("SETTING 5")
// Frame size   : 440 × 956 (logical pixels)
// Background   : #F4FBFD
//
// Header       : Back button at x=16 y=52 (y=66 absolute icon), 
//                Title "Pengaturan" at x=64, Poppins 600 40.
//                SafeArea top offset applied: ~34px.
//
// Card 1 (Profile)
//   - 408 × 88, border-radius 24, white fill, shadow 0 4 4 0 25%
//   - Located at x=16, y=136
//   - Profile Icon: 56×56 at card x=16, y=16 (ic_profil.svg)
//   - Text: "Minum Cek" at card x=137, y=31 (Poppins 600 24, #263238)
//
// Card 2 (Menu)
//   - 408 × 128, border-radius 24, white fill, shadow 0 4 4 0 25%
//   - Located at x=16, y=256
//   - Item 1: "Ketentuan dan Kebijakan" at card y=24, icon x=32, text x=120
//     (gap 64 between 24px icon and text)
//   - Divider: #D9D9D9, 2px height, at card y=60, x=16 to x=392 (horizontal padding 16)
//   - Item 2: "Tujuan Aplikasi Ini" at card y=80, icon x=32, text x=120
// ─────────────────────────────────────────────────────────────────────────────

class PengaturanScreen extends StatelessWidget {
  const PengaturanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFFF4FBFD);
    const Color textColor = Color(0xFF000000);
    const Color profileTextColor = Color(0xFF263238);
    
    return Scaffold(
      backgroundColor: bgColor,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 32, bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header (Back Button & Title) ─────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    Text(
                      'Pengaturan',
                      style: AppTextStyles.pageTitle.copyWith(
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24), // Gap from 52 (header) to 136 (card)

              // ── Profile Card ─────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 88,
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
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      SvgPicture.asset(
                        'assets/icons/ic_profil.svg',
                        width: 56,
                        height: 56,
                      ),
                      const SizedBox(width: 65), // 137(text) - 16(icon_x) - 56(icon_w) = 65
                      Text(
                        'Minum Cek',
                        style: AppTextStyles.secondaryText.copyWith(
                          color: profileTextColor,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32), // Gap from 136+88=224 to 256. 256-224 = 32

              // ── Menu Card ────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 128,
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
                    children: [
                      // Item 1: Ketentuan dan Kebijakan
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const KetentuanKebijakanScreen(),
                            ),
                          );
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 32),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/ic_ketentuan_kebijakan.svg',
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 64), // 88 (text_x inside group) - 24 (icon_w) = 64
                              Text(
                                'Ketentuan dan Kebijakan',
                                style: AppTextStyles.settingsMenuText.copyWith(
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Divider
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),

                      // Item 2: Tujuan Aplikasi Ini
                      const SizedBox(height: 18),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TujuanAplikasiScreen(),
                            ),
                          );
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 32),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/ic_tujuan.svg',
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 64),
                              Text(
                                'Tujuan Aplikasi Ini',
                                style: AppTextStyles.settingsMenuText.copyWith(
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
