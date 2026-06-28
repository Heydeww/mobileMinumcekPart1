import 'package:flutter/material.dart';
import 'package:minum_cekk_app/core/app_colors.dart';
import 'package:minum_cekk_app/widgets/custom_bottom_nav.dart';
import 'package:minum_cekk_app/features/home_screen.dart';
import 'package:minum_cekk_app/features/scanner_screen.dart';
import 'package:minum_cekk_app/features/berita_screen.dart';

// ── MAIN SCREEN ───────────────────────────────────────────────────────────────
// The navigational shell of the app.
//
// Uses [IndexedStack] so that every tab's scroll position, form state, and
// widget tree are preserved when the user switches between tabs — no rebuilds,
// no lost state.
//
// TABS:
//   0 → Beranda   (home placeholder → swap for HomeScreen)
//   1 → Pindai    (scanner placeholder → swap for ScannerScreen)
//   2 → Berita    (news placeholder → swap for NewsScreen)
// ─────────────────────────────────────────────────────────────────────────────

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Placeholder bodies — replace each Center() with the real screen widget
  // once the corresponding feature screens are ready.
  static const List<Widget> _screens = [
    HomeScreen(), // <--- Ini dia bintang utama kita!
    SizedBox.shrink(),
    BeritaScreen(),
  ];

  void _onTabTapped(int index) {
    if (index == 1) {
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(builder: (context) => const ScannerScreen()),
      );
      return;
    }
    if (index == _currentIndex) return; // no-op when tapping the active tab
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return Scaffold(
      backgroundColor: colors.fillCanvas,
      // IndexedStack keeps all 3 pages alive simultaneously, preserving their
      // individual state across tab switches.
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

// ── Placeholder tabs ──────────────────────────────────────────────────────────
// Remove once real screens are wired in.
class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Center(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: colors.textPrimary,
        ),
      ),
    );
  }
}
