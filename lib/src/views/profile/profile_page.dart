import 'package:flutter/material.dart';
import 'package:jastipie_app/app_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder data user
    const userName = "Nisya";
    const userEmail = "nisya@gmail.com";

    return Scaffold(
      appBar: AppBar(title: const Text("Profil")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(userName[0]),
            ),
            const SizedBox(height: 16),
            Text(userName, style: Theme.of(context).textTheme.titleLarge),
            Text(userEmail, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRouter.editProfileRoute);
              },
              icon: const Icon(Icons.edit),
              label: const Text("Edit Profil"),
            ),
          ],
        ),
      ),
    );
  }
}