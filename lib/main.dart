import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sana_health_t/blocs/product/bloc/product_bloc.dart';
import 'package:sana_health_t/blocs/product/bloc/product_event.dart';
import 'package:sana_health_t/blocs/product/categories/categories_bloc.dart';
import 'package:sana_health_t/repositories/product/product_repository.dart';
import 'package:sana_health_t/data/api/dummyjson.dart';
import 'package:sana_health_t/providers/searchbar.dart';
import 'package:sana_health_t/ui/screens/home_screen.dart';
import 'package:sana_health_t/ui/widgets/general/search_bar.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ProductBloc(
                productRepository: ProductRepository(api: Dummyjson()),
              )..add(LoadProducts()),
            ),
            BlocProvider(
              create: (context) => CategoriesBloc(
                productRepository: ProductRepository(api: Dummyjson()),
              ),
            ),
          ],
          child: MyApp(),
        ),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SearchBarWidget(),
              Expanded(child: HomeScreen()),
            ],
          ),
        ),
      ),
    );
  }
}
