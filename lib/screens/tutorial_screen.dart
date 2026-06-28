import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/app_text_styles.dart';

// ── TUTORIAL SCREEN ────────────────────────────────────────────────────────────
// Figma source : MinumCek ANAK GRANDWIS
//   Step 1 → node 8308:12840 (HTU 9)
//   Step 2 → node 8308:12891 (HTU 10)
//   Step 3 → node 8308:12945 (HTU 11)
//   Step 4 → node 8308:12994 (HTU 12)
//
// Frame size   : 440 × 956 (logical px)
// Background   : #F4FBFD
// Card         : x=16 y=136  →  408 × 700, border-radius 24, white, shadow 0 4 4 0 25%
// Badge        : 80 × 80, fill #4FC3F7, positioned at x=16 y=16 inside card
// Phone image  : ~197 × 407, centred inside card starting at card-relative y ≈ 112
// Instruction  : Poppins 600 24 (#000000), at card-relative x=24 y=577
// Next button  : ICON GO RIGHT SVG 48×48, at frame x=360 y=152
// MENGERTI btn : REGISTRASI SVG 248×48, centred at frame y=724; text + mini icon overlay
// ──────────────────────────────────────────────────────────────────────────────

// ── Data model for a single tutorial page ─────────────────────────────────────

class _TutorialPage {
  const _TutorialPage({
    required this.index,      // 0-based page index
    required this.image,      // asset path for the phone screenshot
    this.text,                // null on page index 3
  });

  final int index;
  final String image;
  final String? text;
}

// ── Pages data ─────────────────────────────────────────────────────────────────

const List<_TutorialPage> _pages = [
  _TutorialPage(
    index: 0,
    image: 'assets/images/tutorial_hp_1.png',
    text: 'ARAHKAN KAMERA\nKE MINUMAN KEMASAN\nUNTUK MEMINDAI',
  ),
  _TutorialPage(
    index: 1,
    image: 'assets/images/tutorial_hp_2.png',
    text: 'LIHAT INFORMASI DETAIL\nPRODUK DAN LABEL\nKESEHATAN',
  ),
  _TutorialPage(
    index: 2,
    image: 'assets/images/tutorial_hp_3.png',
    text: 'LIHAT DETAIL LABEL\nKESEHATAN DI SETIAP\nMINUMAN KEMASAN',
  ),
  _TutorialPage(
    index: 3,
    image: 'assets/images/tutorial_hp_4.gif',
    text: null, // Step 4: no descriptive text, no Next button
  ),
];

// ── Widget ────────────────────────────────────────────────────────────────────

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  // ── Figma palette ──────────────────────────────────────────────────────────
  static const Color _bgColor    = Color(0xFFF4FBFD);
  static const Color _badgeColor = Color(0xFF4FC3F7);
  static const Color _textBlack  = Color(0xFF000000);

  // ── PageView state ─────────────────────────────────────────────────────────
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  /// Badge label — Figma uses "1", "2", "3", "4".
  String _badgeLabel(int index) => '${index + 1}';

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      // Extend so the background bleeds behind the status bar.
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            // ── PageView (fills the whole body) ────────────────────────────
            PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemBuilder: (context, i) =>
                  _buildPage(context, _pages[i]),
            ),

            // ── Back button — Figma: x=16, y=66 on a 440px frame ──────────
            // SafeArea removes the status-bar height (~34 px), so we offset
            // by (66 - 34) ≈ 32 px from the SafeArea top.
            Positioned(
              top: 32,
              left: 16,
              child: GestureDetector(
                onTap: () {
                  if (_currentIndex == 0) {
                    Navigator.pop(context);
                  } else {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: SvgPicture.asset(
                  'assets/icons/ic_back.svg',
                  width: 32,
                  height: 32,
                ),
              ),
            ),

            // ── Header title — Figma: x=138, y=72, 164 × 24 ──────────────
            // SafeArea offset: 72 - 34 = 38 px from SafeArea top.
            Positioned(
              top: 38,
              left: 124,
              width: 164,
              child: Text(
                'Cara Menggunakan',
                style: AppTextStyles.readingTitle.copyWith(
                  color: _textBlack,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // ── Conditional bottom section ─────────────────────────────────
            // Steps 0-2: Next button (ICON GO RIGHT 48×48 at frame x=360, y=152).
            // SafeArea offset: 152 - 34 = 118 px from SafeArea top.
            // Step 3  : MENGERTI button — REGISTRASI SVG 248×48, centred on
            //           the 440 px frame at y=724 (SafeArea = 690).
            if (_currentIndex < 3)
              _buildNextButton()
            else
              _buildMengertButton(context),
          ],
        ),
      ),
    );
  }

  // ── Page content (card + image + optional text) ───────────────────────────

  Widget _buildPage(BuildContext context, _TutorialPage page) {
    return SingleChildScrollView(
      // Top padding = distance from SafeArea top to card top.
      // Card at frame y=136, SafeArea removes ~34px → padding ≈ 102px.
      // We add a little extra for the header (title at ~38+24 = ~62 px).
      padding: const EdgeInsets.only(top: 102, bottom: 32),
      child: Padding(
        // Card at x=16 on the 440 frame.
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          // Width: 408px (440 - 2×16). Height: let content determine it.
          width: 408,
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
          child: Padding(
            // Card inner padding: Figma badge at x=16, y=16 inside card.
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Number badge (Ellipse 58) ──────────────────────────────
                // Figma: 80 × 80, fill #4FC3F7, positioned at card x=16, y=16.
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: _badgeColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _badgeLabel(page.index),
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),

                // ── Phone image ────────────────────────────────────────────
                // Figma: ~197 × 407, centred.  For step 1: 206.72 × 415.8.
                // Using 197 × 407 as the common denominator across all steps.
                const SizedBox(height: 16),
                // Flutter's Image.asset handles both PNG and GIF natively.
                Center(
                  child: SizedBox(
                    height: 407,
                    child: Image.asset(
                      page.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // ── Descriptive text (Steps 0–2 only) ─────────────────────
                // Figma: card-relative x=24, y=577. Poppins 600 24.
                if (page.text != null) ...[
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      page.text!,
                      style: AppTextStyles.secondaryText.copyWith(
                        color: _textBlack,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Next button — ICON GO RIGHT 48×48 ────────────────────────────────────
  // Figma: frame x=360, y=152. SafeArea offset: 152 - 34 = 118 px from top.
  Widget _buildNextButton() {
    return Positioned(
      top: 118,
      right: 32, // frame x=360 on 440px frame → right = 440 - 360 - 48 = 32px
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.white,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/ic_next_tutor.svg',
                  width: 34,
                  height: 34,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── MENGERTI button (Step 4) ──────────────────────────────────────────────
  // Figma: REGISTRASI SVG bg 248×48 at frame x=96, y=724, borderRadius=50px.
  // Fill deduced from app palette: #4FC3F7 (same as badge colour).
  // MENGERTI group inside: text "MENGERTI" (white, Poppins 600 16) + MINUM
  // icon (ic_minum_cek_mini.svg, white, 19×27) spaced to the right.
  Widget _buildMengertButton(BuildContext context) {
    return Positioned(
      bottom: 138, // anchored from bottom — stays visible on all screen sizes
      left: 0,
      right: 0,
      child: Center(
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 248,
            height: 48,
            decoration: BoxDecoration(
              color: _badgeColor, // #4FC3F7
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'MENGERTI',
                  style: AppTextStyles.readingTitle.copyWith(
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/icons/ic_minum_cek_mini.svg',
                  width: 19,
                  height: 27,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
