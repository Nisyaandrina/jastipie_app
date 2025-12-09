import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/booking_vm.dart';
import '../../models/booking_model.dart';

class BookingDetailPage extends StatelessWidget {
  final String tripId;
  final String bookingId;

  const BookingDetailPage({
    super.key,
    required this.tripId,
    required this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    final bookingVM = Provider.of<BookingViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Booking')),
      body: FutureBuilder<BookingModel?>(
        future: bookingVM._service.getBookingDetail(tripId, bookingId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Barang: ${data.itemName}",
                    style: const TextStyle(fontSize: 18)),
                Text("Link: ${data.itemLink}"),
                Text("Estimasi: ${data.estimatedPrice}"),
                Text("Catatan: ${data.note}"),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    bookingVM.updateStatus(
                        tripId, bookingId, "accepted");
                  },
                  child: const Text('Terima Booking'),
                ),
                ElevatedButton(
                  onPressed: () {
                    bookingVM.updateStatus(
                        tripId, bookingId, "rejected");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red),
                  child: const Text('Tolak Booking'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
