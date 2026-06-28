import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/app_text_styles.dart';
import '../screens/ringkasan_berita_screen.dart';

class BeritaScreen extends StatelessWidget {
  const BeritaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFFF4FBFD);
    const Color textColor = Color(0xFF000000);

    // Real-time Firestore stream, ordered by most recent first.
    final Stream<QuerySnapshot> beritaStream = FirebaseFirestore.instance
        .collection('berita')
        .orderBy('waktu_rilis', descending: true)
        .snapshots();

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ───────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 24),
              child: Text(
                'Berita',
                style: AppTextStyles.pageTitle.copyWith(
                  color: textColor,
                ),
              ),
            ),

            // ── Body ─────────────────────────────────────────────────
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: beritaStream,
                builder: (context, snapshot) {
                  // Loading state
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF4FC3F7),
                      ),
                    );
                  }

                  // Empty / no data state
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'Belum ada berita saat ini.',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Color(0xFF263238),
                        ),
                      ),
                    );
                  }

                  final docs = snapshot.data!.docs;

                  return ListView.separated(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
                    itemCount: docs.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final data = docs[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RingkasanBeritaScreen(
                                dataBerita: data.data() as Map<String, dynamic>,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 216,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
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
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(32),
                                  child: Image.asset(
                                    data['image_url'] as String,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Layer 2: Gradient Overlay (Dark to Bottom)
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0x00000000), // Transparent
                                        Color(0xF2000000), // 0.95 Opacity Black
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Layer 3: Text Content
                              Positioned(
                                left: 8,
                                right: 8,
                                bottom: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Red Label
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFF0032), // Custom Red
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        data['label_berita'] as String,
                                        style: AppTextStyles.newsButtonText.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Title / Headline
                                    Text(
                                      data['judul_berita'] as String,
                                      style: AppTextStyles.newsText.copyWith(
                                        color: Colors.white,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
