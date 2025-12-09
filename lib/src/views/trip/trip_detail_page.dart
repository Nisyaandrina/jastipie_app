import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/trip_model.dart';
import '../../viewmodels/trip_vm.dart';

class TripDetailPage extends StatelessWidget {
  final String tripId;

  const TripDetailPage({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TripViewModel()..fetchTripById(tripId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Detail Trip"),
        ),
        body: Consumer<TripViewModel>(
          builder: (context, vm, _) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final TripModel? trip = vm.selectedTrip;

            if (trip == null) {
              return const Center(
                child: Text("Trip tidak ditemukan."),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildItem("Asal", trip.origin),
                  _buildItem("Tujuan", trip.destination),
                  _buildItem("Tanggal", trip.date),
                  _buildItem("Kapasitas", trip.capacity.toString()),
                  _buildItem("Harga", "Rp ${trip.price.toStringAsFixed(0)}"),

                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: () {
                      // Integrasi booking akan dibuat setelah modul booking siap
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Fitur Accept Booking belum diintegrasikan."),
                        ),
                      );
                    },
                    child: const Text("Accept Booking"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
