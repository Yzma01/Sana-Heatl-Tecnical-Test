import 'package:flutter/material.dart';
import 'package:sana_health_t/data/api/dummyjson.dart';
import 'package:sana_health_t/data/models/product.dart';

class ProductRepository {
  final Dummyjson api;

  ProductRepository({required this.api});

  Future<List<Product>> getAllProducts() async {
    try {
      final response = await api.fetchProducts();

      final productsData = response['products'] as List<dynamic>;
      final List<Product> products = [];

      productsData.forEach((productJson) {
        debugPrint('Product JSON: $productJson');
        final p = Product.fromJson(productJson);
        debugPrint('Fetched product: ${p.title}');
        products.add(p);
      });

      return products;
    } catch (e) {
      rethrow;
    }
  }
}
