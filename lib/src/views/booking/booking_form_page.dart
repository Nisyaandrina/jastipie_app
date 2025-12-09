import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/booking_vm.dart';
import '../../models/booking_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BookingFormPage extends StatefulWidget {
  final String tripId;
  final String jastiperId;
  final String penitipId;

  const BookingFormPage({
    super.key,
    required this.tripId,
    required this.jastiperId,
    required this.penitipId,
  });

  @override
  State<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final _formKey = GlobalKey<FormState>();

  String itemName = '';
  String itemLink = '';
  String note = '';
  double estimatedPrice = 0;

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<BookingViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Booking Jastip')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Nama Barang'),
                onSaved: (v) => itemName = v!,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Link Barang'),
                onSaved: (v) => itemLink = v!,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Estimasi Harga'),
                keyboardType: TextInputType.number,
                onSaved: (v) => estimatedPrice = double.parse(v!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Catatan'),
                onSaved: (v) => note = v!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Kirim Booking'),
                onPressed: () {
                  _formKey.currentState!.save();

                  final booking = BookingModel(
                    bookingId: const Uuid().v4(),
                    tripId: widget.tripId,
                    penitipId: widget.penitipId,
                    jastiperId: widget.jastiperId,
                    itemName: itemName,
                    itemLink: itemLink,
                    estimatedPrice: estimatedPrice,
                    note: note,
                    status: "pending",
                    createdAt: Timestamp.now(),
                  );

                  vm.createBooking(booking);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
