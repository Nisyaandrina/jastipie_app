import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/trip_model.dart';
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
  final TextEditingController quotaC = TextEditingController();
  final TextEditingController priceC = TextEditingController();
  final TextEditingController notesC = TextEditingController();

  DateTime? selectedDate;

  @override
  void dispose() {
    originC.dispose();
    destinationC.dispose();
    quotaC.dispose();
    priceC.dispose();
    notesC.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  /// Handler sinkron untuk hasil create trip — AMAN dari warning
  void _handleResult(bool success) {
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Trip berhasil dibuat!")),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal membuat trip")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TripViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Buat Trip Baru")),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: originC,
                      decoration: const InputDecoration(labelText: "Asal"),
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? "Tidak boleh kosong" : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: destinationC,
                      decoration: const InputDecoration(labelText: "Tujuan"),
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? "Tidak boleh kosong" : null,
                    ),
                    const SizedBox(height: 12),

                    // Date picker
                    GestureDetector(
                      onTap: _pickDate,
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Tanggal Berangkat",
                            hintText: selectedDate == null
                                ? "Pilih tanggal"
                                : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                          ),
                          validator: (_) =>
                              selectedDate == null ? "Tanggal belum dipilih" : null,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      controller: quotaC,
                      decoration: const InputDecoration(labelText: "Kapasitas"),
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return "Tidak boleh kosong";
                        if (int.tryParse(v.trim()) == null) return "Harus angka bulat";
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      controller: priceC,
                      decoration: const InputDecoration(labelText: "Harga Jasa"),
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return "Tidak boleh kosong";
                        if (double.tryParse(v.trim()) == null) return "Harus angka";
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      controller: notesC,
                      decoration:
                          const InputDecoration(labelText: "Catatan (opsional)"),
                      maxLines: 3,
                    ),

                    const SizedBox(height: 24),

                    ElevatedButton(
                      onPressed: vm.isLoading
                          ? null
                          : () async {
                              if (!_formKey.currentState!.validate()) return;

                              if (selectedDate == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Pilih tanggal keberangkatan")),
                                );
                                return;
                              }

                              final user = FirebaseAuth.instance.currentUser;
                              if (user == null) {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Silakan login terlebih dahulu")),
                                );
                                return;
                              }

                              final newTrip = TripModel(
                                id: '',
                                jastiperId: user.uid,
                                origin: originC.text.trim(),
                                destination: destinationC.text.trim(),
                                departureDate: selectedDate!,
                                quota: int.tryParse(quotaC.text.trim()) ?? 0,
                                price: double.tryParse(priceC.text.trim()) ?? 0,
                                notes: notesC.text.trim(),
                                isOpen: true,
                                createdAt: DateTime.now(),
                              );

                              final success = await vm.createTrip(newTrip);

                              if (!mounted) return;

                              // Panggil handler sinkron → tanpa warning
                              _handleResult(success);
                            },
                      child: vm.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                          : const Text("Simpan Trip"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
