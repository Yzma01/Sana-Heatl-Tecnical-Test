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
      final p;
      final products = productsData
          .map((productJson) => Product.fromJson(productJson))
          .toList();
      return products;
    } catch (e) {
      debugPrint('Error fetching products: $e');
      rethrow;
    }
  }
}
