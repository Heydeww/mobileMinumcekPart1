import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/app_theme.dart';
import 'features/scanner_screen.dart';
import 'package:minum_cekk_app/features/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MinumCekApp());
}

class MinumCekApp extends StatelessWidget {
  const MinumCekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MinumCek',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const MainScreen(),
    );
  }
}
