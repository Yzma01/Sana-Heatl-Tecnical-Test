import 'package:sana_health_t/data/models/categories.dart';

class CategoriesState {}

class CategorieInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  List<Categories> categories;
  CategoriesLoaded({required this.categories});
}

class CategoresError extends CategoriesState {
  final String message;
  CategoresError({required this.message});
}
