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

  static const String baseUrl = 'https://dummyjson.com';

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

  Future<Map<String, dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return data;
    } else {
      throw Exception(getErrorMessage(response.statusCode));
    }
  }
}
