import 'package:flutter/material.dart';
import 'package:jastipie_app/src/models/request_model.dart';
import 'package:jastipie_app/src/utils/formatters.dart';
import 'package:jastipie_app/theme.dart';

class RequestCard extends StatelessWidget {
  final RequestModel request;
  final VoidCallback onTap;

  const RequestCard({super.key, required this.request, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Menentukan warna badge berdasarkan status
    Color statusColor;
    Color statusBgColor;

    switch (request.status) {
      case 'ACCEPTED':
        statusColor = Colors.green;
        statusBgColor = Colors.green.withValues(alpha: 0.1); 
        break;
      case 'REJECTED':
        statusColor = Colors.red;
        statusBgColor = Colors.red.withValues(alpha: 0.1); 
        break;
      default: // PENDING
        statusColor = Colors.orange;
        statusBgColor = Colors.orange.withValues(alpha: 0.1); 
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Icon Placeholder Barang
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1), 
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  color: AppColors.primary,
                  size: 30,
                ),
              ),
              const SizedBox(width: 12),

              // Informasi Barang
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.itemName,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      request.category,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      Formatters.formatCurrency(request.priceEst),
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Status Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  request.status,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
