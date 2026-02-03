import 'package:flutter/material.dart';
import 'package:sana_health_t/data/models/product.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreen();
}

class _EditProductScreen extends State<EditProductScreen> {
  @override
  Widget build(Object context) {
    return Scaffold(appBar: AppBar(), body: Container());
  }
}
