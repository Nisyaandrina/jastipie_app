import 'package:flutter/material.dart';
import '../models/trip_model.dart';
import 'package:jastipie_app/app_router.dart';

class TripCard extends StatelessWidget {
  final TripModel trip;

  const TripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouter.tripDetailRoute,
          arguments: trip.id,
        );
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${trip.origin} → ${trip.destination}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    decoration: BoxDecoration(
                      color: trip.isOpen ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      trip.isOpen ? "Open" : "Closed",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              /// INFO
              Text("Berangkat: ${_formatDate(trip.departureDate)}"),
              Text("Kuota: ${trip.quota}"),
              Text("Harga jasa: Rp ${trip.price.toStringAsFixed(0)}"),

              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 4),

              /// NOTES
              Text(
                trip.notes.isEmpty ? "Tidak ada catatan." : trip.notes,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return date.toLocal().toString().split(" ")[0];
  }
}
