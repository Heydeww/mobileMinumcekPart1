import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/app_text_styles.dart';

class RingkasanBeritaScreen extends StatelessWidget {
  final Map<String, dynamic> dataBerita;

  const RingkasanBeritaScreen({super.key, required this.dataBerita});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFFF4FBFD);
    const Color textColor = Color(0xFF000000);
    const Color cardTextColor = Color(0xFF263238);

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
                    'Ringkasan Berita',
                    style: AppTextStyles.pageTitle.copyWith(
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Scrollable Content Card ──────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
                child: Container(
                  width: double.infinity,
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
                  child: Stack(
                    children: [
                      // Layer 1: Image Background
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                          child: dataBerita['image_url'] != null
                              ? Image.asset(
                                  dataBerita['image_url'] as String,
                                  height: 208,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : const SizedBox(height: 208),
                        ),
                      ),
                      // Layer 2: Top to Bottom Transparent-to-White Gradient
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 208,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.0, 0.84], // matching Figma stop
                              colors: [
                                Colors.transparent,
                                Colors.white,
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Layer 3: Dynamic Copywriting
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, // Wrap content height
                          children: [
                            Text(
                              dataBerita['judul_berita'] as String? ?? '',
                              style: AppTextStyles.secondTitle.copyWith(
                                color: cardTextColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Red Label
                            if (dataBerita['label_berita'] != null)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF0032), // Custom Red
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  dataBerita['label_berita'] as String,
                                  style: AppTextStyles.newsButtonText.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 8),
                            // Text Body (Markdown Parsed)
                            _buildMarkdownBody(dataBerita['ringkasan'] as String? ?? ''),
                            const SizedBox(height: 8),
                            // Divider
                            Container(
                              height: 4,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Baca Selengkapnya
                            Text(
                              'Baca Selengkapnya :',
                              style: AppTextStyles.readingText.copyWith(
                                color: cardTextColor,
                              ),
                            ),
                            const SizedBox(height: 0),
                            if (dataBerita['link_sumber'] != null)
                              GestureDetector(
                                onTap: () async {
                                  final urlString = dataBerita['link_sumber'] as String;
                                  if (urlString.isNotEmpty) {
                                    final url = Uri.parse(urlString);
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url, mode: LaunchMode.externalApplication);
                                    }
                                  }
                                },
                                behavior: HitTestBehavior.opaque, // Ensures the whole bounding box is tapable
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0), // give it some top/bottom tap padding
                                  child: Text(
                                    dataBerita['link_sumber'] as String,
                                    style: AppTextStyles.readingText.copyWith(
                                      color: const Color(0xFF007AFF), // standard iOS blue link color
                                    ),
                                  ),
                                ),
                              ),
                          ],
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

  Widget _buildMarkdownBody(String text) {
    if (text.isEmpty) return const SizedBox.shrink();

    final List<TextSpan> spans = [];
    final RegExp regex = RegExp(r'\*\*(.*?)\*\*', dotAll: true);
    int lastMatchEnd = 0;

    for (var match in regex.allMatches(text)) {
      // Normal Text
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: text.substring(lastMatchEnd, match.start),
          style: AppTextStyles.readingText.copyWith(
            color: const Color(0xFF263238),
          ),
        ));
      }

      // Bold Text
      spans.add(TextSpan(
        text: match.group(1),
        style: AppTextStyles.readingText.copyWith(
          color: const Color(0xFF263238),
          fontWeight: FontWeight.bold,
        ),
      ));

      lastMatchEnd = match.end;
    }

    // Remaining Normal Text
    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastMatchEnd),
        style: AppTextStyles.readingText.copyWith(
          color: const Color(0xFF263238),
        ),
      ));
    }

    return RichText(
      text: TextSpan(children: spans),
      textAlign: TextAlign.justify,
    );
  }
}
