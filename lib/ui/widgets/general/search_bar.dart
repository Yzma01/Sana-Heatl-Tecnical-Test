import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sana_health_t/blocs/product/bloc/product_bloc.dart';
import 'package:sana_health_t/blocs/product/bloc/product_event.dart';
import 'package:sana_health_t/ui/screens/add_product_screen.dart';
import 'package:sana_health_t/ui/widgets/general/icon_button.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBarWidget> {
  final TextEditingController _textInputControl = TextEditingController();

  void _searchByCategories() {}

  void _searchProduct() {
    if (_textInputControl.text.isEmpty) {
      return;
    }
    context.read<ProductBloc>().add(SearchProducts(_textInputControl.text));
  }

  void _addProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddProductScreen()),
    );
  }

  void _deleteSearch() {
    if (_textInputControl.text.isEmpty) {
      return;
    }
    _textInputControl.text = '';
    context.read<ProductBloc>().add(LoadProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: _textInputControl,
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
              ButtonWithIcon(
                message: 'Delete search values',
                onPressed: _deleteSearch,
                icon: Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
