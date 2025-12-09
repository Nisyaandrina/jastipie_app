import 'package:flutter/material.dart';
import '../models/trip_model.dart';
import '../app_router.dart';

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

                  // Status open/closed
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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

              const SizedBox(height: 8),

              Text(
                "Berangkat: ${trip.departureDate.toLocal().toString().split(' ')[0]}",
                style: const TextStyle(fontSize: 13),
              ),

              Text(
                "Kuota: ${trip.quota}",
                style: const TextStyle(fontSize: 13),
              ),

              Text(
                "Harga jasa: Rp ${trip.price.toStringAsFixed(0)}",
                style: const TextStyle(fontSize: 13),
              ),

              const SizedBox(height: 6),
              const Divider(),

              Text(
                trip.notes,
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
}
