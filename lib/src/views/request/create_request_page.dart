import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jastipie_app/src/viewmodels/request_vm.dart';
import 'package:jastipie_app/src/widgets/app_button.dart';
import 'package:jastipie_app/src/widgets/app_textfield.dart';

class CreateRequestPage extends StatefulWidget {
  const CreateRequestPage({super.key});

  @override
  State<CreateRequestPage> createState() => _CreateRequestPageState();
}

class _CreateRequestPageState extends State<CreateRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _itemCtrl = TextEditingController();
  final _categoryCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();

  @override
  void dispose() {
    _itemCtrl.dispose();
    _categoryCtrl.dispose();
    _priceCtrl.dispose();
    _weightCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Menggunakan ChangeNotifierProvider untuk menghubungkan VM
    return ChangeNotifierProvider(
      create: (_) => RequestViewModel(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Buat Request Baru")),
        body: Consumer<RequestViewModel>(
          builder: (context, vm, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Detail Barang",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _itemCtrl,
                      label: "Nama Barang",
                      validator: (val) => val == null || val.isEmpty
                          ? "Nama barang wajib diisi"
                          : null,
                    ),
                    const SizedBox(height: 12),
                    AppTextField(
                      controller: _categoryCtrl,
                      label: "Kategori (Misal: Makanan, Tas)",
                      validator: (val) => val == null || val.isEmpty
                          ? "Kategori wajib diisi"
                          : null,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            controller: _priceCtrl,
                            label: "Estimasi (Rp)",
                            // validator: (val) => val == null || val.isEmpty ? "Wajib diisi" : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AppTextField(
                            controller: _weightCtrl,
                            label: "Berat (kg)",
                            // validator: (val) => val == null || val.isEmpty ? "Wajib diisi" : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    AppTextField(
                      controller: _noteCtrl,
                      label: "Catatan (Varian, Warna, dll)",
                    ),
                    const SizedBox(height: 32),

                    if (vm.isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      AppButton(
                        label: "Kirim Request",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final success = await vm.addRequest(
                              itemName: _itemCtrl.text,
                              category: _categoryCtrl.text,
                              priceEst: double.tryParse(_priceCtrl.text) ?? 0,
                              weight: double.tryParse(_weightCtrl.text) ?? 0,
                              note: _noteCtrl.text,
                            );

                            if (success && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Request berhasil dibuat!"),
                                ),
                              );
                              Navigator.pop(context);
                            } else if (context.mounted &&
                                vm.errorMessage != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(vm.errorMessage!)),
                              );
                            }
                          }
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
