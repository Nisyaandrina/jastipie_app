import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app_router.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Minimal Firebase init. Assumes platform-specific configs are set (Android/iOS/web).
  await Firebase.initializeApp();

  runApp(const JastipieApp());
}

class JastipieApp extends StatelessWidget {
  const JastipieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JASTIPIE',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRouter.initialRoute,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}