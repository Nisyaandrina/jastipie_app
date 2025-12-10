import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/trip_vm.dart';
import '../../widgets/trip_card.dart';

class TripListPage extends StatelessWidget {
  const TripListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TripViewModel>(context);

    if (!vm.isLoaded) {
      vm.fetchTrips();
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Trip")),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : vm.trips.isEmpty
              ? const Center(child: Text("Belum ada trip."))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: vm.trips.length,
                  itemBuilder: (context, i) => TripCard(trip: vm.trips[i]),
                ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/create-trip'),
      ),
    );
  }
}
