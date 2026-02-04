import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sana_health_t/blocs/product/bloc/product_bloc.dart';
import 'package:sana_health_t/blocs/product/bloc/product_state.dart';
import 'package:sana_health_t/blocs/product/categories/categories_bloc.dart';
import 'package:sana_health_t/blocs/product/categories/categories_state.dart';
import 'package:sana_health_t/providers/form.dart';
import 'package:sana_health_t/ui/widgets/form/selector_input.dart';
import 'package:sana_health_t/ui/widgets/form/text_input.dart';

class BasicDataSection extends StatelessWidget {
  final FormProvider formProvider;

  const BasicDataSection({super.key, required this.formProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextInput(
          controller: formProvider.titleController,
          label: 'Product name',
          hint: 'Enter product name',
          prefixIcon: Icons.shopping_bag,
          validator: formProvider.basicStringValidator,
        ),
        const SizedBox(height: 12),
        CustomTextInput(
          controller: formProvider.descriptionController,
          label: 'Product description',
          isExpanded: true,
          minLines: 1,
          maxLines: 6,
          hint: 'Enter product description',
          prefixIcon: Icons.edit,
          validator: formProvider.basicStringValidator,
        ),
        const SizedBox(height: 12),
        BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            List<DropdownMenuItem<String>> categoryItems = [];
            if (state is CategoriesLoaded) {
              debugPrint('aaaa; ${state.categories}');
              categoryItems = state.categories
                  .map(
                    (c) => DropdownMenuItem(value: c.name, child: Text(c.name)),
                  )
                  .toList();
            }

            return SelectorInput<String>(
              label: 'Category',
              hint: 'Select a category',
              prefixIcon: Icons.category,
              value: formProvider.selectedCategory,
              items: categoryItems,
              onChanged: formProvider.updateCategory,
              validator: formProvider.basicSelectorValidator,
            );
          },
        ),
        const SizedBox(height: 12),
        CustomTextInput(
          controller: formProvider.brandController,
          label: 'Brand',
          hint: 'Enter brand name',
          prefixIcon: Icons.business,
          validator: formProvider.basicStringValidator,
        ),
        const SizedBox(height: 12),
        CustomTextInput(
          controller: formProvider.skuController,
          label: 'SKU',
          hint: 'Enter SKU code',
          prefixIcon: Icons.qr_code,
          validator: formProvider.basicStringValidator,
        ),
      ],
    );
  }
}
