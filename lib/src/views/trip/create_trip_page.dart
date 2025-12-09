import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/trip_vm.dart';

class CreateTripPage extends StatefulWidget {
  const CreateTripPage({super.key});

  @override
  State<CreateTripPage> createState() => _CreateTripPageState();
}

class _CreateTripPageState extends State<CreateTripPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController originC = TextEditingController();
  final TextEditingController destinationC = TextEditingController();
  final TextEditingController dateC = TextEditingController();
  final TextEditingController capacityC = TextEditingController();
  final TextEditingController priceC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TripViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Buat Trip Baru")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: originC,
                decoration: const InputDecoration(labelText: "Asal"),
                validator: (v) => v!.isEmpty ? "Tidak boleh kosong" : null,
              ),
              TextFormField(
                controller: destinationC,
                decoration: const InputDecoration(labelText: "Tujuan"),
                validator: (v) => v!.isEmpty ? "Tidak boleh kosong" : null,
              ),
              TextFormField(
                controller: dateC,
                decoration: const InputDecoration(labelText: "Tanggal"),
                validator: (v) => v!.isEmpty ? "Tidak boleh kosong" : null,
              ),
              TextFormField(
                controller: capacityC,
                decoration: const InputDecoration(labelText: "Kapasitas"),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? "Tidak boleh kosong" : null,
              ),
              TextFormField(
                controller: priceC,
                decoration: const InputDecoration(labelText: "Harga"),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? "Tidak boleh kosong" : null,
              ),

              const SizedBox(height: 20),

              Consumer<TripViewModel>(
                builder: (context, vm, _) {
                  return ElevatedButton(
                    onPressed: vm.isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              await vm.addTrip(
                                origin: originC.text,
                                destination: destinationC.text,
                                date: dateC.text,
                                capacity: int.tryParse(capacityC.text) ?? 0,
                                price: double.tryParse(priceC.text) ?? 0,
                              );

                              if (!context.mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Trip berhasil dibuat!"),
                                ),
                              );

                              Navigator.pop(context);
                            }
                          },
                    child: vm.isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text("Simpan Trip"),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
