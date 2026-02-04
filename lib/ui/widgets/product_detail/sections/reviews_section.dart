import 'package:flutter/material.dart';
import 'package:sana_health_t/data/models/product.dart';
import 'package:sana_health_t/ui/widgets/general/section_title.dart';
import 'package:sana_health_t/ui/widgets/product_detail/review_card.dart';

class ReviewsSection extends StatelessWidget {
  final Product product;

  const ReviewsSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionTitle(title: 'Reviews'),
              if (product.reviews.isNotEmpty)
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Option not support')),
                    );
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Write Review'),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (product.reviews.isNotEmpty)
            ...product.reviews.map((review) => ReviewCard(review: review))
          else
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Icon(
                      Icons.rate_review_outlined,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No reviews yet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Be the first to review this product',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                      label: const Text('Write a Review'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
