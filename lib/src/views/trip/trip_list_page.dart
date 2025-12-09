import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/trip_vm.dart';
import '../../widgets/trip_card.dart';

class TripListPage extends StatelessWidget {
  const TripListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TripViewModel()..fetchTrips(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Daftar Trip"),
        ),
        body: Consumer<TripViewModel>(
          builder: (context, vm, _) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.trips.isEmpty) {
              return const Center(
                child: Text("Belum ada trip yang tersedia."),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: vm.trips.length,
              itemBuilder: (context, index) {
                final trip = vm.trips[index];
                return TripCard(trip: trip);
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/create-trip');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
