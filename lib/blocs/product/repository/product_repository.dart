import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sana_health_t/data/api/dummyjson.dart';
import 'package:sana_health_t/data/models/product.dart';

class ProductRepository {
  final Dummyjson api;

  ProductRepository({required this.api});

  List<Product> parseResponse(Map<String, dynamic> response) {
    final productsData = response['products'] as List<dynamic>;
    final products = productsData
        .map((productJson) => Product.fromJson(productJson))
        .toList();
    return products;
  }

  Future<List<Product>> getAllProducts() async {
    try {
      final response = await api.fetchProducts();

      return parseResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await api.searchProducts(query);
      return parseResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await api.deleteProduct(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await api.addProduct(product);
    } catch (e) {
      rethrow;
    }
  }
}
