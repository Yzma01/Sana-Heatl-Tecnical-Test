import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sana_health_t/data/models/product.dart';

class Dummyjson {
  //   GET https://dummyjson.com/products
  // • GET https://dummyjson.com/products/{id}
  // • GET https://dummyjson.com/products/categories
  // • GET https://dummyjson.com/products/category/{category}
  // • GET https://dummyjson.com/products/search?q={query}
  // Escritura (CRUD simulado)
  // • POST https://dummyjson.com/products/add
  // • PUT https://dummyjson.com/products/{id}
  // • PATCH https://dummyjson.com/products/{id}
  // • DELETE https://dummyjson.com/products/{id}

  static const String baseUrl = 'https://dummyjson.com/products';

  String getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad Request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 500:
        return 'Internal Server Error';
      default:
        return 'Unexpected Error: $statusCode';
    }
  }

  Map<String, dynamic> parseResponse(String response) {
    final Map<String, dynamic> data =
        jsonDecode(response) as Map<String, dynamic>;
    return data;
  }

  Future<Map<String, dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl'));

    if (response.statusCode == 200) {
      return parseResponse(response.body);
    } else {
      throw Exception(getErrorMessage(response.statusCode));
    }
  }

  Future<Map<String, dynamic>> searchProducts(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search?q=$query'));

    if (response.statusCode == 200) {
      return parseResponse(response.body);
    } else {
      throw Exception(getErrorMessage(response.statusCode));
    }
  }

  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return;
    }

    throw Exception(getErrorMessage(response.statusCode));
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 201) {
      return;
    }

    throw Exception(getErrorMessage(response.statusCode));
  }
}
