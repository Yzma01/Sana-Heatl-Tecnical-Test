import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sana_health_t/data/models/product.dart';
import 'package:sana_health_t/ui/screens/product_detail_screen.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to product detail page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: widget.product),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Image(
              image: widget.product.thumbnail.startsWith('http')
                  ? NetworkImage(widget.product.thumbnail)
                  : FileImage(File(widget.product.thumbnail)) as ImageProvider,
              width: 100,
              height: 100,
            ),

            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title.length > 20
                        ? '${widget.product.title.substring(0, 20)}...'
                        : widget.product.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16, color: Colors.green),
                  ),
                  Text(
                    widget.product.category,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    'Rating: ${widget.product.rating}',
                    style: const TextStyle(fontSize: 14, color: Colors.orange),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
