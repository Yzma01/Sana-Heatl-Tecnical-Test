import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:sana_health_t/blocs/product/bloc/product_event.dart';
import 'package:sana_health_t/blocs/product/bloc/product_state.dart';
import 'package:sana_health_t/repositories/product/product_repository.dart';
import 'package:sana_health_t/data/models/categories.dart';
import 'package:sana_health_t/data/models/product.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  List<int> deletedProducts = [];
  List<Product> localProducts = [];

  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<SearchProducts>(_onSearchProducts);
    on<DeleteProduct>(_onDeleteProduct);
    on<AddProduct>(_onAddProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<ProductCategory>(_onProductCategory);
  }

  void _onDeleteProduct(DeleteProduct event, Emitter<ProductState> emit) async {
    final currentState = state as ProductLoaded;
    emit(ProductLoading());
    try {
      await productRepository.deleteProduct(event.productId);
      deletedProducts.add(event.productId);
      emit(ProductLoaded(filterProducts(currentState.products)));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onSearchProducts(
    SearchProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await productRepository.searchProducts(event.query);
      final hasLocalMatch = localProducts.any(
        (p) => p.title.toLowerCase().contains(event.query.toLowerCase()),
      );

      if (products.isEmpty && !hasLocalMatch) {
        debugPrint('empty');
        emit(ProductError("No products founded for ${event.query}"));
      } else {
        emit(ProductLoaded(filterProducts(products)));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await productRepository.getAllProducts();
      emit(ProductLoaded(filterProducts(products)));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onAddProduct(AddProduct event, Emitter<ProductState> emit) async {
    if (state is! ProductLoaded) return;
    final currentState = state as ProductLoaded;
    try {
      emit(ProductLoading());
      final newProduct = event.productData.copyWith(
        id: _nextId(currentState.products),
      );

      await productRepository.addProduct(newProduct);
      final updatedProducts = [...currentState.products, newProduct];

      emit(ProductLoaded(filterProducts(updatedProducts)));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onUpdateProduct(UpdateProduct event, Emitter<ProductState> emit) async {
    if (state is! ProductLoaded) return;
    final currentState = state as ProductLoaded;
    try {
      emit(ProductLoading());
      final updatedProducts = currentState.products.map((product) {
        if (product.id == event.productId) {
          return event.updatedData.copyWith(id: product.id);
        }
        return product;
      }).toList();

      await productRepository.updateProduct(event.productId, event.updatedData);

      emit(ProductLoaded(filterProducts(updatedProducts)));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onProductCategory(
    ProductCategory event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await productRepository.getCategory(event.url);
      emit(ProductLoaded(filterProducts(products)));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  List<Product> filterProducts(List<Product> products) {
    final merged = [...products, ...localProducts];

    if (deletedProducts.isEmpty) return merged;

    return merged.where((p) => !deletedProducts.contains(p.id)).toList();
  }

  int _nextId(List<Product> products) {
    if (products.isEmpty) return 1;
    return products.map((p) => p.id!).reduce((a, b) => a > b ? a : b) + 1;
  }
}
