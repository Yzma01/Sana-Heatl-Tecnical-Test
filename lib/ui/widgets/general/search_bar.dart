import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sana_health_t/blocs/product/bloc/product_bloc.dart';
import 'package:sana_health_t/blocs/product/bloc/product_event.dart';
import 'package:sana_health_t/providers/form.dart';
import 'package:sana_health_t/providers/searchbar.dart';
import 'package:sana_health_t/ui/screens/add_product_screen.dart';
import 'package:sana_health_t/ui/screens/categories_screen.dart';
import 'package:sana_health_t/ui/widgets/general/icon_button.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBarWidget> {
  SearchProvider? searchProvider;
  void _searchByCategories() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoriesScreen()),
    );
  }

  void _searchProduct() {
    if (searchProvider!.controller.text.isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    context.read<ProductBloc>().add(
      SearchProducts(searchProvider!.controller.text),
    );
  }

  void _addProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (_) => FormProvider(),
          child: AddProductScreen(),
        ),
      ),
    );
  }

  void _deleteSearch() {
    if (searchProvider!.controller.text.isEmpty) {
      return;
    }
    searchProvider!.controller.text = '';
    context.read<ProductBloc>().add(LoadProducts());
  }

  @override
  Widget build(BuildContext context) {
    searchProvider = context.watch<SearchProvider>();
    return Center(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: searchProvider!.controller,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Search product...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: _searchProduct,
                      icon: Icon(Icons.search, color: Colors.black),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (_) => _searchProduct(),
                ),
              ),
              ButtonWithIcon(
                message: 'Search by categories',
                onPressed: _searchByCategories,
                icon: Icon(Icons.article_outlined, color: Colors.green),
              ),
              ButtonWithIcon(
                message: 'Add new product',
                onPressed: _addProduct,
                icon: Icon(Icons.add, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
