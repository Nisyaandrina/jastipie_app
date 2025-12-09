import 'package:flutter/material.dart';
import 'package:jastipie_app/src/models/request_model.dart';
import 'package:jastipie_app/src/utils/formatters.dart';
import 'package:jastipie_app/src/widgets/app_button.dart';
import 'package:jastipie_app/theme.dart';
import 'package:jastipie_app/app_router.dart';

class RequestDetailPage extends StatelessWidget {
  final Object? args;

  const RequestDetailPage({super.key, this.args});

  @override
  Widget build(BuildContext context) {
    if (args is! RequestModel) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("Data request tidak valid")),
      );
    }

    final request = args as RequestModel;

    return Scaffold(
      appBar: AppBar(title: const Text("Detail Request")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info dalam Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.inventory_2_outlined,
                        color: AppColors.primary,
                        size: 28,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          request.itemName,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                                fontSize: 20,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  _DetailRow(
                    icon: Icons.category,
                    label: "Kategori",
                    value: request.category,
                  ),
                  _DetailRow(
                    icon: Icons.attach_money,
                    label: "Estimasi Harga",
                    value: Formatters.formatCurrency(request.priceEst),
                  ),
                  _DetailRow(
                    icon: Icons.scale,
                    label: "Berat",
                    value: "${request.weight} kg",
                  ),
                  _DetailRow(
                    icon: Icons.calendar_today,
                    label: "Dibuat",
                    value: Formatters.formatDate(request.createdAt),
                  ),
                  _DetailRow(
                    icon: Icons.info_outline,
                    label: "Status",
                    value: request.status,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Catatan Tambahan:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                request.note.isEmpty ? "Tidak ada catatan." : request.note,
                style: const TextStyle(height: 1.5, fontSize: 14),
              ),
            ),

            const SizedBox(height: 40),

            // Tombol Aksi - Integrasi Booking
            if (request.status == 'PENDING') ...[
              AppButton(
                label: "Tawarkan Bantuan (Booking)",
                onPressed: () {
                  // Arahkan ke list booking atau flow booking
                  Navigator.of(context).pushNamed(AppRouter.bookingListRoute);
                },
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Placeholder untuk fitur hapus
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Fitur hapus belum diimplementasikan"),
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete_outline),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  label: const Text("Batalkan Request"),
                ),
              ),
            ] else ...[
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Status: ${request.status}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
