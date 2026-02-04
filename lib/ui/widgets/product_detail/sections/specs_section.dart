import 'package:flutter/material.dart';
import 'package:sana_health_t/data/models/product.dart';
import 'package:sana_health_t/ui/widgets/general/section_title.dart';

class SpecsSection extends StatelessWidget {
  final Product product;

  const SpecsSection({super.key, required this.product});

  Widget _buildSpecRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Product Information'),
          const SizedBox(height: 16),
          _buildSpecRow(Icons.qr_code_2, 'SKU', product.sku),
          _buildSpecRow(Icons.scale_outlined, 'Weight', '${product.weight} kg'),
          _buildSpecRow(
            Icons.verified_user_outlined,
            'Warranty',
            product.warrantyInformation,
          ),
          _buildSpecRow(
            Icons.assignment_return_outlined,
            'Return Policy',
            product.returnPolicy,
          ),
        ],
      ),
    );
  }
}
