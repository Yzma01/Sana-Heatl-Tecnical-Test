import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:sana_health_t/blocs/product/bloc/product_event.dart';
import 'package:sana_health_t/blocs/product/bloc/product_state.dart';
import 'package:sana_health_t/blocs/product/repository/product_repository.dart';
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
    final currentState = state;

    if (currentState is! ProductLoaded) {
      emit(ProductError('Cannot add product right now'));
      return;
    }
    emit(ProductLoading());
    try {
      await productRepository.addProduct(event.productData);
      event.productData.id = currentState.products.length + 10;
      localProducts.add(event.productData);
      emit(ProductLoaded(filterProducts(currentState.products)));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  List<Product> filterProducts(List<Product> products) {
    final merged = [...products, ...localProducts];

    if (deletedProducts.isEmpty) return merged;

    return merged.where((p) => !deletedProducts.contains(p.id)).toList();
  }
}
