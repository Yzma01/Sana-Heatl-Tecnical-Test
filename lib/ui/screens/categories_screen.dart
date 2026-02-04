import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sana_health_t/blocs/product/bloc/product_bloc.dart';
import 'package:sana_health_t/blocs/product/bloc/product_event.dart';
import 'package:sana_health_t/blocs/product/bloc/product_state.dart';
import 'package:sana_health_t/blocs/product/categories/categories_bloc.dart';
import 'package:sana_health_t/blocs/product/categories/categories_event.dart';
import 'package:sana_health_t/blocs/product/categories/categories_state.dart';
import 'package:sana_health_t/data/models/categories.dart';
import 'package:sana_health_t/ui/widgets/category/category_card.dart';
import 'package:sana_health_t/ui/widgets/general/loading.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoriesBloc>().add(LoadCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoading) return Loading();

          if (state is CategoresError) {
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Center(child: Text('Error: ${state.message}')),
                ),
              ],
            );
          }

          if (state is CategoriesLoaded) {
            return ListView(
              children: state.categories
                  .map((category) => CategoryCard(category: category))
                  .toList(),
            );
          }
          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: const [
              SizedBox(height: 300),
              Center(child: Text('No categories available')),
            ],
          );
        },
      ),
    );
  }
}
