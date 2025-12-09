import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/review_vm.dart';
import '../../models/review_model.dart';

class ReviewListPage extends StatelessWidget {
  final String jastiperId;

  const ReviewListPage({super.key, required this.jastiperId});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ReviewViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Review Pengguna")),
      body: StreamBuilder<List<ReviewModel>>(
        stream: vm.reviewStream(jastiperId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final reviews = snapshot.data!;

          if (reviews.isEmpty) {
            return const Center(child: Text("Belum ada review"));
          }

          return ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, i) {
              final r = reviews[i];
              return ListTile(
                leading: Icon(Icons.star, color: Colors.amber[700], size: 32),
                title: Text("Rating: ${r.rating} ⭐"),
                subtitle: Text(r.comment),
              );
            },
          );
        },
      ),
    );
  }
}
