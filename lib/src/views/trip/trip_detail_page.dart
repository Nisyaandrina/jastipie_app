import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../models/trip_model.dart';
import '../../viewmodels/trip_vm.dart';

class TripDetailPage extends StatelessWidget {
  final String tripId;

  const TripDetailPage({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TripViewModel>(context);

    if (vm.tripDetail == null || vm.tripDetail!.id != tripId) {
      vm.fetchTripDetail(tripId);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Detail Trip")),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : vm.tripDetail == null
              ? const Text("Trip tidak ditemukan")
              : _buildContent(context, vm.tripDetail!),
    );
  }

  Widget _buildContent(BuildContext context, TripModel trip) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          item("Asal", trip.origin),
          item("Tujuan", trip.destination),
          item("Tanggal", DateFormat('dd MMM yyyy').format(trip.departureDate)),
          item("Kapasitas", trip.quota.toString()),
          item("Harga", "Rp ${trip.price.toStringAsFixed(0)}"),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget item(String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(value),
          ],
        ),
      );
}
