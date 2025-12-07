import 'package:flutter/material.dart';
import 'package:jastipie_app/app_router.dart';

class HomePenitipPage extends StatelessWidget {
  const HomePenitipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Beranda Penitip")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _HomeCard(
            title: "Request Saya",
            subtitle: "Kelola permintaan titipan",
            icon: Icons.assignment,
            onTap: () => Navigator.of(context).pushNamed(AppRouter.requestListRoute),
          ),
          _HomeCard(
            title: "Trip Jastiper",
            subtitle: "Lihat daftar trip tersedia",
            icon: Icons.flight_takeoff,
            onTap: () => Navigator.of(context).pushNamed(AppRouter.tripListRoute),
          ),
          _HomeCard(
            title: "Booking",
            subtitle: "Pantau status booking",
            icon: Icons.book_online,
            onTap: () => Navigator.of(context).pushNamed(AppRouter.bookingListRoute),
          ),
          _HomeCard(
            title: "Chat",
            subtitle: "Komunikasi dengan jastiper",
            icon: Icons.chat,
            onTap: () => Navigator.of(context).pushNamed(AppRouter.chatListRoute),
          ),
          _HomeCard(
            title: "Profil",
            subtitle: "Lihat & edit profil",
            icon: Icons.person,
            onTap: () => Navigator.of(context).pushNamed(AppRouter.profileRoute),
          ),
          _HomeCard(
            title: "Rating & Review",
            subtitle: "Berikan ulasan jastiper",
            icon: Icons.star,
            onTap: () => Navigator.of(context).pushNamed(AppRouter.reviewFormRoute),
          ),
        ],
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _HomeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}