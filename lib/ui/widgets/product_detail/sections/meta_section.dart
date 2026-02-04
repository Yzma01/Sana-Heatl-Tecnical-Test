import 'package:flutter/material.dart';
import 'package:sana_health_t/data/models/product.dart';

class MetaSection extends StatelessWidget {
  final Product product;

  const MetaSection({super.key, required this.product});

  Widget _buildMetaRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            _buildMetaRow('Barcode', product.meta.barcode),
            if (product.meta.qrCode.isNotEmpty) ...[
              const Divider(height: 24),
              _buildMetaRow('QR Code', product.meta.qrCode),
            ],
            const Divider(height: 24),
            _buildMetaRow('Created', _formatDate(product.meta.createdAt)),
            const Divider(height: 24),
            _buildMetaRow('Last Updated', _formatDate(product.meta.updatedAt)),
          ],
        ),
      ),
    );
  }
}
