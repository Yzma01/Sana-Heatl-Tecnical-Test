import 'package:flutter/material.dart';
import 'package:sana_health_t/data/models/product.dart';
import 'package:sana_health_t/ui/widgets/general/section_title.dart';

class DimensionsSection extends StatelessWidget {
  final Product product;

  const DimensionsSection({super.key, required this.product});

  Widget _buildDimensionCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(icon, size: 28, color: Theme.of(context).primaryColor),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
          const SectionTitle(title: 'Dimensions'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDimensionCard(
                  context,
                  'Width',
                  '${product.dimensions.width} cm',
                  Icons.width_normal,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDimensionCard(
                  context,
                  'Height',
                  '${product.dimensions.height} cm',
                  Icons.height,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDimensionCard(
                  context,
                  'Depth',
                  '${product.dimensions.depth} cm',
                  Icons.straighten,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
