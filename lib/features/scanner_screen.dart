import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../screens/tutorial_screen.dart';


class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  // ── CAMERA STATE ─────────────────────────────────────────────────────────────
  CameraController? _controller;
  bool _isCameraReady = false;
  bool _isFlashOn = false;

  // ── IMAGE PICKER ─────────────────────────────────────────────────────────────
  final ImagePicker _picker = ImagePicker();

  // ── LIFECYCLE ────────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  /// Initialises the primary rear camera and wires up the [CameraController].
  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      // Prefer the first back-facing camera; fall back to whatever is available.
      final CameraDescription camera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      _controller = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _controller!.initialize();

      // Guard: widget may have been disposed during async init.
      if (!mounted) return;
      setState(() => _isCameraReady = true);
    } catch (e) {
      debugPrint('Camera init error: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // ── FLASH TOGGLE ─────────────────────────────────────────────────────────────

  Future<void> _toggleFlash() async {
    if (_controller == null || !_isCameraReady) return;
    try {
      final newMode = _isFlashOn ? FlashMode.off : FlashMode.torch;
      await _controller!.setFlashMode(newMode);
      setState(() => _isFlashOn = !_isFlashOn);
    } catch (e) {
      debugPrint('Flash toggle error: $e');
    }
  }

  // ── SHUTTER ───────────────────────────────────────────────────────────────────

  Future<void> _takePhoto() async {
    if (_controller == null || !_isCameraReady) return;
    try {
      await _controller!.takePicture();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text('Gagal mengambil foto: $e')));
    }
  }

  // ── GALLERY PICKER ───────────────────────────────────────────────────────────

  Future<void> _pickFromGallery() async {
    try {
      await _picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text('Gagal memilih gambar: $e')));
    }
  }

  // ── TUTORIAL ─────────────────────────────────────────────────────────────────

  void _openTutorial() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TutorialScreen(),
      ),
    );
  }



  // ── BUILD ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      // Extend body behind the status bar so the camera fills edge-to-edge.
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Layer 1: Camera Preview (or fallback) ───────────────────────────
          _isCameraReady && _controller != null
              ? CameraPreview(_controller!)
              : const ColoredBox(color: Colors.black),

          // ── Layer 2: Top gradient / vignette ────────────────────────────────
          // Matches the Rectangle 464 in Figma (y=0, h=120) — a soft black
          // gradient fading downward so the top action buttons remain readable.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenSize.height * (120 / 956),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                ),
              ),
            ),
          ),

          // ── Layer 3: Bottom black panel ──────────────────────────────────────
          // Matches Rectangle 463 in Figma (y=716, h=240).
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: screenSize.height * (240 / 956),
            child: Container(color: Colors.black),
          ),

          // ── Layer 4: Hint text ───────────────────────────────────────────────
          // Figma: y=758 from top, which is 758-716=42px inside the panel.
          // Width=385 centered on 440px frame → horizontal padding ≈28px.
          Positioned(
            bottom: screenSize.height * ((240 - 42 - 20) / 956),
            left: 28,
            right: 28,
            child: Text(
              'Arahkan kamera ke produk minuman yang ingin di pindai!',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ),

          // ── Layer 5: Bottom action row (Gallery | Shutter | Tutorial) ────────
          // Figma: Gallery x=64 y=828, Shutter x=184 y=820, Tutorial x=320 y=828
          // All bottom values measured from the bottom of the 956px frame.
          Positioned(
            bottom: screenSize.height * ((956 - 820 - 72) / 956),
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Gap from left edge to gallery: x=64 on 440px → left pad
                  // The row is centred and the shutter is the pivot.
                  // Gallery sits 120px left of shutter centre (220-64-28=128... )
                  // Use fixed spacing derived from Figma x-coordinates:
                  //   Gallery centre  = 64 + 56/2 = 92
                  //   Shutter centre  = 184 + 72/2 = 220
                  //   Tutorial centre = 320 + 56/2 = 348
                  //   Gap G→S = 220 - 92 - (72/2) = 92px  → SizedBox(92-28=64... )
                  // Simpler: just place them with exact spacers.
                  const Spacer(),

                  // Gallery button — 56×56
                  GestureDetector(
                    onTap: _pickFromGallery,
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: SvgPicture.asset(
                        'assets/icons/ic_galery.svg',
                        width: 56,
                        height: 56,
                      ),
                    ),
                  ),

                  // Gap between gallery and shutter
                  // From fig: shutter_left - gallery_right = 184 - (64+56) = 64px
                  const SizedBox(width: 64),

                  // Shutter button — 72×72
                  GestureDetector(
                    onTap: _takePhoto,
                    child: SizedBox(
                      width: 72,
                      height: 72,
                      child: SvgPicture.asset(
                        'assets/icons/ic_botton_camera.svg',
                        width: 72,
                        height: 72,
                      ),
                    ),
                  ),

                  // Gap between shutter and tutorial
                  // From fig: tutorial_left - shutter_right = 320 - (184+72) = 64px
                  const SizedBox(width: 64),

                  // Tutorial button — 56×56
                  GestureDetector(
                    onTap: _openTutorial,
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: SvgPicture.asset(
                        'assets/icons/ic_how_to_use.svg',
                        width: 56,
                        height: 56,
                      ),
                    ),
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),

          // ── Layer 6: Back button (top-left) ──────────────────────────────────
          // Figma: x=24, y=46 — size 50×50.
          Positioned(
            top: 46 + MediaQuery.of(context).padding.top,
            left: 24,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SizedBox(
                width: 50,
                height: 50,
                child: SvgPicture.asset(
                  'assets/icons/ic_back_pindai.svg',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ),

          // ── Layer 7: Flash button (top-right) ────────────────────────────────
          // Figma: x=377, y=57 — size 39×39.
          Positioned(
            top: 57 + MediaQuery.of(context).padding.top,
            right: 440 - 377 - 39, // = 24px from right
            child: GestureDetector(
              onTap: _toggleFlash,
              child: SizedBox(
                width: 39,
                height: 39,
                child: SvgPicture.asset(
                  'assets/icons/ic_flash.svg',
                  width: 39,
                  height: 39,
                  // Tint flash icon amber when torch is active.
                  colorFilter: _isFlashOn
                      ? const ColorFilter.mode(
                          Color(0xFFFFD600),
                          BlendMode.srcIn,
                        )
                      : const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
