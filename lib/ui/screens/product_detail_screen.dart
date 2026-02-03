import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sana_health_t/blocs/product/bloc/product_bloc.dart';
import 'package:sana_health_t/blocs/product/bloc/product_event.dart';
import 'package:sana_health_t/data/models/product.dart';
import 'package:sana_health_t/ui/screens/edit_product_screen.dart';
import 'package:sana_health_t/ui/screens/home_screen.dart';
import 'package:sana_health_t/ui/widgets/general/icon_button.dart';
import 'package:sana_health_t/ui/widgets/general/section_title.dart';
import 'package:sana_health_t/ui/widgets/product_detail/images_carousel.dart';
import 'package:sana_health_t/ui/widgets/product_detail/review_card.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  void _addReview() {}

  void _editProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductScreen(product: widget.product),
      ),
    );
  }

  void _deleteProduct() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              context.read<ProductBloc>().add(DeleteProduct(widget.product.id));
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ButtonWithIcon(
            message: 'Edit this product',
            onPressed: _editProduct,
            icon: Icon(Icons.edit, color: Colors.amber),
          ),
          ButtonWithIcon(
            message: 'Delete this item',
            onPressed: _deleteProduct,
            icon: Icon(Icons.delete_forever, color: Colors.red),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.product.images.isNotEmpty
                  ? ImagesCarousel(images: widget.product.images)
                  : Image.network(widget.product.thumbnail),
              const SizedBox(height: 10),
              Text(
                widget.product.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '\$${widget.product.price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ),
              const SizedBox(height: 10),
              Text(
                'Category: ${widget.product.category}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Text(
                'Rating: ${widget.product.rating}',
                style: const TextStyle(fontSize: 16, color: Colors.orange),
              ),
              const SizedBox(height: 20),
              Text(
                widget.product.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SectionTitle(title: 'Reviews'),
                  Spacer(),
                  Tooltip(
                    message: 'Add review',
                    child: IconButton(
                      onPressed: _addReview,
                      icon: Icon(Icons.add, color: Colors.blue),
                    ),
                  ),
                ],
              ),

              if (widget.product.reviews.isNotEmpty)
                ...widget.product.reviews.map(
                  (review) => ReviewCard(review: review),
                )
              else
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'No reviews available.',
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
