import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/booking_vm.dart';
import '../../models/booking_model.dart';
import '../../app_router.dart';

class BookingListPage extends StatelessWidget {
  final String tripId;

  const BookingListPage({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    final bookingVM = Provider.of<BookingViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Booking List')),
      body: StreamBuilder<List<BookingModel>>(
        stream: bookingVM.getBookings(tripId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final bookings = snapshot.data!;

          if (bookings.isEmpty) {
            return const Center(child: Text('Belum ada booking'));
          }

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, i) {
              final b = bookings[i];

              return ListTile(
                title: Text(b.itemName),
                subtitle: Text("Status: ${b.status}"),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRouter.bookingDetailRoute,
                    arguments: {
                      'tripId': tripId,
                      'bookingId': b.bookingId,
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
