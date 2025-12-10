import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app_router.dart';       
import 'theme.dart';           

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('✅ Firebase initialized successfully');
  } catch (e, s) {
    debugPrint('❌ Firebase init error: $e\n$s');
  }

  runApp(const JastipieApp());
}

class JastipieApp extends StatelessWidget {
  const JastipieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JASTIPIE',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: AppRouter.initialRoute, // pastikan tidak null
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}