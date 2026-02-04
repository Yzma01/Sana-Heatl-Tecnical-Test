import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sana_health_t/blocs/product/categories/categories_event.dart';
import 'package:sana_health_t/blocs/product/categories/categories_state.dart';
import 'package:sana_health_t/repositories/product/product_repository.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final ProductRepository productRepository;
  CategoriesBloc({required this.productRepository})
    : super(CategorieInitial()) {
    on<LoadCategories>(_loadCategories);
  }
  void _loadCategories(
    LoadCategories event,
    Emitter<CategoriesState> emit,
  ) async {
    try {
      final categories = await productRepository.getCategories();
      emit(CategoriesLoaded(categories: categories));
    } catch (e) {
      emit(CategoresError(message: e.toString()));
    }
  }
}
