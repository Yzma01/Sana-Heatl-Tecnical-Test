import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sana_health_t/blocs/product/bloc/product_bloc.dart';
import 'package:sana_health_t/blocs/product/bloc/product_event.dart';
import 'package:sana_health_t/data/models/product.dart';
import 'package:sana_health_t/providers/form.dart';
import 'package:sana_health_t/ui/screens/add_product_screen.dart';
import 'package:sana_health_t/ui/widgets/product_detail/sections/dimensions_section.dart';
import 'package:sana_health_t/ui/widgets/product_detail/sections/meta_section.dart';
import 'package:sana_health_t/ui/widgets/product_detail/sections/price_section.dart';
import 'package:sana_health_t/ui/widgets/product_detail/sections/product_header_section.dart';
import 'package:sana_health_t/ui/widgets/product_detail/sections/product_info_section.dart';
import 'package:sana_health_t/ui/widgets/product_detail/sections/reviews_section.dart';
import 'package:sana_health_t/ui/widgets/product_detail/sections/shipping_section.dart';
import 'package:sana_health_t/ui/widgets/product_detail/sections/specs_section.dart';
import 'package:sana_health_t/ui/widgets/product_detail/sections/tags_section.dart';
import 'package:sana_health_t/ui/widgets/product_detail/floating_action_buttons.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  void _editProduct() {
    final formProvider = FormProvider();
    formProvider.loadProduct(widget.product);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: formProvider,
          child: AddProductScreen(product: widget.product),
        ),
      ),
    );
  }

  void _deleteProduct() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: Colors.red.shade700,
              ),
            ),
            const SizedBox(width: 12),
            const Text('Delete Product'),
          ],
        ),
        content: const Text(
          'Are you sure you want to delete this product? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              context.read<ProductBloc>().add(
                DeleteProduct(widget.product.id!),
              );
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 60,
            floating: true,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            foregroundColor: Colors.grey.shade800,
            elevation: 0,
            actions: [
              // IconButton(
              //   icon: const Icon(Icons.share_outlined),
              //   onPressed: () {},
              //   tooltip: 'Share',
              // ),
              // IconButton(
              //   icon: const Icon(Icons.favorite_border),
              //   onPressed: () {},
              //   tooltip: 'Add to favorites',
              // ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductHeaderSection(product: widget.product),
                ProductInfoSection(product: widget.product),
                PriceSection(product: widget.product),
                TagsSection(product: widget.product),
                SpecsSection(product: widget.product),
                ShippingSection(product: widget.product),
                DimensionsSection(product: widget.product),
                MetaSection(product: widget.product),
                ReviewsSection(product: widget.product),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: ProductFloatingActionButtons(
        onEdit: _editProduct,
        onDelete: _deleteProduct,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
