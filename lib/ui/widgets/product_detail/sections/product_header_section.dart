import 'package:flutter/material.dart';
import 'package:sana_health_t/data/models/product.dart';
import 'package:sana_health_t/ui/widgets/product_detail/images_carousel.dart';

class ProductHeaderSection extends StatelessWidget {
  final Product product;

  const ProductHeaderSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return product.images.isNotEmpty
        ? ImagesCarousel(images: product.images)
        : Hero(
            tag: 'product_${product.id}',
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Image.network(product.thumbnail, fit: BoxFit.cover),
              ),
            ),
          );
  }
}
