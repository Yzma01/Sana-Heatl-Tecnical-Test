import 'package:sana_health_t/data/models/categories.dart';
import 'package:sana_health_t/data/models/product.dart';

class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}

class ProductCategoryLoaded extends ProductState {
  final List<Categories> categories;

  ProductCategoryLoaded({required this.categories});
}
