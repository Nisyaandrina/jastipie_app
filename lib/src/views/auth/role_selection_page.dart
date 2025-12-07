import 'package:flutter/material.dart';
import 'package:jastipie_app/app_router.dart';

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
                Navigator.of(context).pushReplacementNamed(
                  AppRouter.homeJastiperRoute, 
                );
              },
              child: const Text("Masuk sebagai Jastiper"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(
                  AppRouter.homePenitipRoute, 
                );
              },
              child: const Text("Masuk sebagai Penitip"),
            ),
          ],
        ),
      ),
    );
  }
}