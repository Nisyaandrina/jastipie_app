import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/review_vm.dart';

class ReviewFormPage extends StatefulWidget {
  final String reviewerId;
  final String jastiperId;
  final String bookingId;

  const ReviewFormPage({
    super.key,
    required this.reviewerId,
    required this.jastiperId,
    required this.bookingId,
  });

  @override
  State<ReviewFormPage> createState() => _ReviewFormPageState();
}

class _ReviewFormPageState extends State<ReviewFormPage> {
  double _rating = 0;
  final TextEditingController _commentCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ReviewViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Beri Review")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Rating Jastiper", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (i) => IconButton(
                  icon: Icon(
                    i < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 32,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = i + 1.0;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _commentCtrl,
              decoration: const InputDecoration(
                labelText: "Komentar",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            vm.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      await vm.sendReview(
                        reviewerId: widget.reviewerId,
                        jastiperId: widget.jastiperId,
                        bookingId: widget.bookingId,
                        rating: _rating,
                        comment: _commentCtrl.text.trim(),
                      );

                      if (context.mounted) Navigator.pop(context);
                    },
                    child: const Text("Kirim"),
                  ),
          ],
        ),
      ),
    );
  }
}
