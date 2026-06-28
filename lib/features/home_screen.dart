import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minum_cekk_app/core/app_colors.dart';
import 'package:minum_cekk_app/core/app_text_styles.dart';
import 'package:minum_cekk_app/widgets/product_card.dart';
import 'package:minum_cekk_app/widgets/section_header.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minum_cekk_app/widgets/status_label_button.dart';
import 'package:minum_cekk_app/screens/penting_screen.dart';
import 'package:minum_cekk_app/screens/label_detail_screen.dart';
import 'package:minum_cekk_app/screens/product_info_screen.dart';
import 'package:minum_cekk_app/screens/pengaturan_screen.dart';
import 'package:minum_cekk_app/screens/ringkasan_berita_screen.dart';


// ── HOME SCREEN ───────────────────────────────────────────────────────────────
// The main landing screen of the app, assembled from reusable atomic widgets.
//
// DESIGN SPEC (extracted via Figma MCP, node 6228-13498 "MAIN MENU"):
//   • Screen background  : colors.fillCanvas  (#F4FBFD)
//   • Gradient header    : 200 px tall, #4FC3F7 → #F4FBFD (top to bottom)
//   • Scroll content     : starts at y=114, column gap ≈ 10 px
//   • Search bar         : 352×32, borderRadius 8, white, with search icon
//   • Nutri-Grade labels : Poppins 20 SemiBold (secondTitle) + info icon
//   • Status buttons     : 2×2 grid of StatusLabelButton (200×56 each)
//   • Section headers    : SectionHeader (pill + arrow)
//   • Product lists      : horizontal ListView of ProductCard (176×176, gap 10 px)
// ─────────────────────────────────────────────────────────────────────────────


// ── HOME SCREEN ───────────────────────────────────────────────────────────────
// The main landing screen of the app, assembled from reusable atomic widgets.
//
// DESIGN SPEC (extracted via Figma MCP, node 6228-13498 "MAIN MENU"):
//   • Screen background  : colors.fillCanvas  (#F4FBFD)
//   • Gradient header    : 200 px tall, #4FC3F7 → #F4FBFD (top to bottom)
//   • Scroll content     : starts at y=114, column gap ≈ 10 px
//   • Search bar         : 352×32, borderRadius 8, white, with search icon
//   • Nutri-Grade labels : Poppins 20 SemiBold (secondTitle) + info icon
//   • Status buttons     : 2×2 grid of StatusLabelButton (200×56 each)
//   • Section headers    : SectionHeader (pill + arrow)
//   • Product lists      : horizontal ListView of ProductCard (176×176, gap 10 px)
// ─────────────────────────────────────────────────────────────────────────────

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Standard section spacing (Figma column gap ≈ 10px, bumped to 16 for clarity)
  static const double _sectionGap = 16;
  // Horizontal screen padding (Figma: scroll content x=43 → ~16 safe)
  static const double _hPad = 16;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return Scaffold(
      backgroundColor: colors.fillCanvas,
      body: Stack(
        children: [
          // ── Gradient header backdrop ──────────────────────────────────
          // Figma: GRADIASI 440×200, LinearGradient 180°
          // #4FC3F7(0%) → #F4FBFD(100%)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 200,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colors.primary,   // #4FC3F7
                    colors.fillCanvas, // #F4FBFD
                  ],
                ),
              ),
            ),
          ),

          // ── Scrollable content ────────────────────────────────────────
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Search bar + Settings ───────────────────────────
                  // Figma: TOP FITUR, y=66 within scroll, h=32, search+settings
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: _hPad),
                    child: _SearchBar(),
                  ),

                  const SizedBox(height: 16),

                  // ── News Banner Carousel ────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: _hPad),
                    child: const NewsBannerCarousel(),
                  ),

                  const SizedBox(height: _sectionGap),

                  // ── Nutri-Grade section ─────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: _hPad),
                    child: _NutriGradeSection(colors: colors),
                  ),

                  const SizedBox(height: 24), // Strict 24px gap to match Figma spec

                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('beverages')
                        .orderBy('index', descending: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Center(child: Text('Error: ${snapshot.error}')),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Center(child: Text('Tidak ada data minuman')),
                        );
                      }

                      final docs = snapshot.data!.docs;
                      
                      // In-memory categorization based on explicit index ranges
                      final popular = docs.where((doc) {
                        final data = doc.data() as Map<String, dynamic>?;
                        if (data == null || !data.containsKey('index')) return false;
                        final index = data['index'] as int;
                        return index >= 1 && index <= 6;
                      }).toList();
                      
                      final waspada = docs.where((doc) {
                        final data = doc.data() as Map<String, dynamic>?;
                        if (data == null || !data.containsKey('index')) return false;
                        final index = data['index'] as int;
                        return index >= 7 && index <= 12;
                      }).toList();
                      
                      final hatiHati = docs.where((doc) {
                        final data = doc.data() as Map<String, dynamic>?;
                        if (data == null || !data.containsKey('index')) return false;
                        final index = data['index'] as int;
                        return index >= 13 && index <= 18;
                      }).toList();
                      
                      final aman = docs.where((doc) {
                        final data = doc.data() as Map<String, dynamic>?;
                        if (data == null || !data.containsKey('index')) return false;
                        final index = data['index'] as int;
                        return index >= 19 && index <= 24;
                      }).toList();
                      
                      final sangatAman = docs.where((doc) {
                        final data = doc.data() as Map<String, dynamic>?;
                        if (data == null || !data.containsKey('index')) return false;
                        final index = data['index'] as int;
                        return index >= 25 && index <= 30;
                      }).toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Minuman Populer ─────────────────────────────────
                          if (popular.isNotEmpty) ...[
                            _buildCategorySection(
                              title: 'Minuman Populer',
                              pillColor: colors.primary,
                              docs: popular,
                            ),
                            const SizedBox(height: _sectionGap),
                          ],

                          // ── Waspada ─────────────────────────────────────────
                          if (waspada.isNotEmpty) ...[
                            _buildCategorySection(
                              title: 'Waspada',
                              pillColor: colors.btnDanger,
                              docs: waspada,
                            ),
                            const SizedBox(height: _sectionGap),
                          ],

                          // ── Hati-Hati ───────────────────────────────────────
                          if (hatiHati.isNotEmpty) ...[
                            _buildCategorySection(
                              title: 'Hati-Hati',
                              pillColor: colors.btnWarning,
                              docs: hatiHati,
                            ),
                            const SizedBox(height: _sectionGap),
                          ],

                          // ── Aman ────────────────────────────────────────────
                          if (aman.isNotEmpty) ...[
                            _buildCategorySection(
                              title: 'Aman',
                              pillColor: colors.btnSafe,
                              docs: aman,
                            ),
                            const SizedBox(height: _sectionGap),
                          ],

                          // ── Sangat Aman ─────────────────────────────────────
                          if (sangatAman.isNotEmpty) ...[
                            _buildCategorySection(
                              title: 'Sangat Aman',
                              pillColor: colors.btnVerySafe,
                              docs: sangatAman,
                            ),
                          ],
                        ],
                      );
                    },
                  ),

                  // Bottom breathing room above nav bar
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection({
    required String title,
    required Color pillColor,
    required List<QueryDocumentSnapshot> docs,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: _hPad),
          child: SectionHeader(
            title: title,
            pillColor: pillColor,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 184, // card height + breathing room
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: _hPad),
            physics: const BouncingScrollPhysics(),
            itemCount: docs.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data() as Map<String, dynamic>? ?? {};

              return ProductCard(
                imageUrl: data['image_url'] ?? '',
                productName: data['display_name'] ?? '',
                volume: data['volume'] ?? '',
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (context) => ProductInfoScreen(
                        name: data['display_name'] ?? '',
                        volume: data['volume'] ?? '',
                        imageUrl: data['image_url'] ?? '',
                        ingredients: data['ingredients'] ?? '',
                        nutritionFacts: data['nutrition_facts'] ?? '',
                        healthGrade: data['health_grade'] ?? '',
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// ── TOP HEADER (Search Bar + Settings) ───────────────────────────────────────
// Figma: TOP FITUR (node 6228-13688)
//   • Search Bar: 352×32, borderRadius 8, white #FFFFFF, border 1px #000000
//     "Cari" text: Inter 13 Regular, #000000
//   • Settings Icon: SVG ic_settings.svg, 32×32, separated by 24px gap
class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Search bar (width: flex, height: 32)
        Expanded(
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              // Strict Figma spec: #FFFFFF fill, #000000 border
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF000000), width: 1),
            ),
            // Figma padding: x=16 for search icon
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                // Figma magnifier icon size ≈ 16×16
                const Icon(Icons.search, size: 16, color: Color(0xFF000000)),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      height: 1.21, // ~1.210227em from Figma
                      color: Color(0xFF000000),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Cari',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        height: 1.21,
                        color: const Color(0xFF000000).withAlpha(128),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Gap of exactly 24px (376 - 352)
        const SizedBox(width: 24),
        
        // Settings icon (Figma: 32×32)
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PengaturanScreen()),
            );
          },
          child: SvgPicture.asset(
            'assets/icons/ic_settings.svg',
            width: 32,
            height: 32,
            // SVG inherits black color if needed, but asset usually defines it
          ),
        ),
      ],
    );
  }
}


// ── Nutri-Grade Section ────────────────────────────────────────────────────────
// Figma: NUTRI GRADE label (Poppins 20 SemiBold) + a 2×2 grid of StatusLabelButton
// Button y-positions: row1 y=262, row2 y=334 → gap = 72-56 = 16 px between rows
// Horizontal layout: Waspada x=43, Hati-Hati x=251 → gap ≈ 8 px between pairs
class _NutriGradeSection extends StatelessWidget {
  const _NutriGradeSection({required this.colors});
  final AppColorsExtension colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label row: "Nutri-Grade" + info icon (Figma: Vector SVG → Icons.info_outline)
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PentingScreen())),
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Text(
                'Nutri-Grade',
                style: AppTextStyles.secondTitle.copyWith(
                  color: colors.textPrimary,
                  height: 1.5,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.info_outline,
                size: 20,
                color: colors.textPrimary,
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: StatusLabelButton(
                    text: 'Waspada',
                    backgroundColor: colors.btnDanger,
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LabelDetailScreen(healthGrade: 'Waspada'))),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: StatusLabelButton(
                    text: 'Hati-Hati',
                    backgroundColor: colors.btnWarning,
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LabelDetailScreen(healthGrade: 'Hati-Hati'))),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: StatusLabelButton(
                    text: 'Aman',
                    backgroundColor: colors.btnSafe,
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LabelDetailScreen(healthGrade: 'Aman'))),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: StatusLabelButton(
                    text: 'Sangat Aman',
                    backgroundColor: colors.btnVerySafe,
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LabelDetailScreen(healthGrade: 'Sangat Aman'))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// (Horizontal Product List widgets are populated using _buildCategorySection directly via FutureBuilder)

// ── News Banner Carousel ───────────────────────────────────────────────────────
// Auto-scrolling carousel for news banners.
// Figma dimensions: ~184 height.
class NewsBannerCarousel extends StatefulWidget {
  const NewsBannerCarousel({super.key});

  @override
  State<NewsBannerCarousel> createState() => _NewsBannerCarouselState();
}

class _NewsBannerCarouselState extends State<NewsBannerCarousel> {
  late final PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  // Stable stream object — initialized once in initState so it is never
  // recreated on rebuild (fixes the infinite-loading / flicker loop).
  late final Stream<QuerySnapshot> _newsStream;

  // Docs cache used exclusively by the auto-scroll timer for bounds checking.
  List<QueryDocumentSnapshot> _docs = [];
  StreamSubscription<QuerySnapshot>? _streamSub;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Build the stream ONCE here so it stays the same instance across rebuilds.
    _newsStream = FirebaseFirestore.instance
        .collection('berita')
        .orderBy('waktu_rilis', descending: true)
        .limit(3)
        .snapshots();

    // Also subscribe for timer management (needs to know _docs.length).
    _streamSub = _newsStream.listen((snapshot) {
      if (!mounted) return;
      setState(() {
        _docs = snapshot.docs;
        if (_currentPage >= _docs.length && _docs.isNotEmpty) {
          _currentPage = 0;
          _pageController.jumpToPage(0);
        }
      });
      // Start the timer only once after first data arrives.
      if (_timer == null || !_timer!.isActive) {
        _startAutoScroll();
      }
    });
  }

  void _startAutoScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 5000), (timer) {
      if (!mounted || _docs.isEmpty) return;
      if (_currentPage < _docs.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _streamSub?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return StreamBuilder<QuerySnapshot>(
      stream: _newsStream, // Stable reference — never recreated on rebuild
      builder: (context, snapshot) {
        // ── Loading ────────────────────────────────────────────────────
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AspectRatio(
            aspectRatio: 408 / 176,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: colors.corner,
                alignment: Alignment.center,
                child: CircularProgressIndicator(color: colors.primary),
              ),
            ),
          );
        }

        // ── Error ──────────────────────────────────────────────────────
        if (snapshot.hasError) {
          return AspectRatio(
            aspectRatio: 408 / 176,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: colors.corner,
                alignment: Alignment.center,
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red, fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }

        // ── Empty ──────────────────────────────────────────────────────
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return AspectRatio(
            aspectRatio: 408 / 176,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: colors.corner,
                alignment: Alignment.center,
                child: const Text(
                  'Tidak ada berita',
                  style: TextStyle(fontFamily: 'Poppins', color: Colors.grey),
                ),
              ),
            ),
          );
        }

        final docs = snapshot.data!.docs;

        return Column(
          children: [
        // Carousel View
        AspectRatio(
          aspectRatio: 408 / 176, // Figma width 408 / height 176
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final data = docs[index].data() as Map<String, dynamic>;
                final imageUrl = data['image_url'] as String? ?? '';
                final labelBerita = data['label_berita'] as String? ?? '';
                final judulBerita = data['judul_berita'] as String? ?? '';

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RingkasanBeritaScreen(
                          dataBerita: docs[index].data() as Map<String, dynamic>,
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Layer 1: Background Image
                      Image.asset(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: colors.corner,
                          alignment: Alignment.center,
                          child: Icon(Icons.image, color: colors.textSecondary),
                        ),
                      ),
                      // Layer 2: Dark gradient overlay (bottom to top)
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0x00000000), // Transparent
                              Color(0xF2000000), // 0.95 Opacity Black
                            ],
                          ),
                        ),
                      ),
                      // Layer 3: Label + Title text
                      Positioned(
                        left: 8,
                        right: 8,
                        bottom: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (labelBerita.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF0032),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  labelBerita,
                                  style: AppTextStyles.newsButtonText.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            if (labelBerita.isNotEmpty) const SizedBox(height: 4),
                            Text(
                              judulBerita,
                              style: AppTextStyles.newsText.copyWith(
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _docs.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? colors.primary
                    : colors.corner,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
          ],
        );
      },
    );
  }
}

