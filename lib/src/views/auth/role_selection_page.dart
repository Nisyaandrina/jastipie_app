// lib/views/auth/role_selection_page.dart
import 'package:flutter/material.dart';
import '../../app_router.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pilih Peran")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRouter.homeJastiper);
              },
              child: const Text("Masuk sebagai Jastiper"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRouter.homePenitip);
              },
              child: const Text("Masuk sebagai Penitip"),
            ),
          ],
        ),
      ),
    );
  }
}