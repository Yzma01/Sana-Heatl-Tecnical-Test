import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sana_health_t/blocs/product/bloc/product_bloc.dart';
import 'package:sana_health_t/blocs/product/bloc/product_event.dart';
import 'package:sana_health_t/blocs/product/bloc/product_state.dart';
import 'package:sana_health_t/data/models/product.dart';
import 'package:sana_health_t/providers/searchbar.dart';
import 'package:sana_health_t/ui/widgets/general/loading.dart';
import 'package:sana_health_t/ui/widgets/home/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  List<Product> _cachedProducts = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<SearchProvider>().clear();
          context.read<ProductBloc>().add(LoadProducts());
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductCategoryLoaded) {
              if (_cachedProducts.isNotEmpty) {
                return ListView(
                  children: _cachedProducts
                      .map((product) => ProductCard(product: product))
                      .toList(),
                );
              }
            }

            if (state is ProductError) {
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

            if (state is ProductLoaded) {
              _cachedProducts = state.products;
              return ListView(
                children: state.products
                    .map((product) => ProductCard(product: product))
                    .toList(),
              );
            }

            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 300),
                Center(child: Text('No products available')),
              ],
            );
          },
        ),
      ),
    );
  }
}
