import 'package:sana_health_t/data/models/product.dart';

abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class RefreshProducts extends ProductEvent {}

class SearchProducts extends ProductEvent {
  final String query;

  SearchProducts(this.query);
}

class FilterProductsByCategory extends ProductEvent {
  final String category;

  FilterProductsByCategory(this.category);
}

class SortProducts extends ProductEvent {
  final String sortBy; // e.g., 'price', 'rating'
  final bool ascending;

  SortProducts(this.sortBy, this.ascending);
}

class AddProduct extends ProductEvent {
  final Product productData;

  AddProduct(this.productData);
}

class UpdateProduct extends ProductEvent {
  final int productId;
  final Map<String, dynamic> updatedData;

  UpdateProduct(this.productId, this.updatedData);
}

class DeleteProduct extends ProductEvent {
  final int productId;

  DeleteProduct(this.productId);
}
