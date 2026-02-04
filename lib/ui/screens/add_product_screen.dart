import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sana_health_t/blocs/product/bloc/product_bloc.dart';
import 'package:sana_health_t/blocs/product/bloc/product_event.dart';
import 'package:sana_health_t/blocs/product/categories/categories_bloc.dart';
import 'package:sana_health_t/blocs/product/categories/categories_event.dart';
import 'package:sana_health_t/data/models/product.dart';
import 'package:sana_health_t/providers/form.dart';
import 'package:sana_health_t/ui/widgets/form/sections/%20%20dimensions_section.dart';
import 'package:sana_health_t/ui/widgets/form/sections/%20additional_info_section.dart';
import 'package:sana_health_t/ui/widgets/form/sections/%20basic_data_section.dart';
import 'package:sana_health_t/ui/widgets/form/sections/%20inventory_section.dart';
import 'package:sana_health_t/ui/widgets/form/sections/image/image_picker_section.dart';
import 'package:sana_health_t/ui/widgets/form/sections/pricing_section.dart';
import 'package:sana_health_t/ui/widgets/general/section_title.dart';

class AddProductScreen extends StatefulWidget {
  Product? product;
  AddProductScreen({super.key, this.product});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late FormProvider form;
  bool isEdit = false;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    form = context.read<FormProvider>();
  }

  @override
  void initState() {
    super.initState();
    context.read<CategoriesBloc>().add(LoadCategories());
    if (!_initialized && widget.product != null && !widget.product!.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<FormProvider>().loadProduct(widget.product!);
        isEdit = true;
        _initialized = true;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (form.selectedImages.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select at least one image')),
        );
        return;
      }

      final productData = form.product;
      debugPrint('aaaa; ${productData.toString()}');
      if (isEdit) {
        debugPrint('aaaa;se $isEdit');
        context.read<ProductBloc>().add(
          UpdateProduct(widget.product!.id!, productData),
        );
      } else {
        debugPrint('aaaa;na $isEdit');
        context.read<ProductBloc>().add(AddProduct(productData));
      }
      form.clearForm();
      form.clearImages();
      Navigator.pop(context);
      if (isEdit) Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all the data mark on red')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const SectionTitle(title: 'Basic Data'),
                  const SizedBox(height: 12),
                  BasicDataSection(formProvider: form),
                  const SizedBox(height: 24),
                  const SectionTitle(title: 'Pricing'),
                  const SizedBox(height: 12),
                  PricingSection(formProvider: form),
                  const SizedBox(height: 24),
                  const SectionTitle(title: 'Inventory'),
                  const SizedBox(height: 12),
                  InventorySection(formProvider: form),
                  const SizedBox(height: 24),
                  const SectionTitle(title: 'Dimensions'),
                  const SizedBox(height: 12),
                  DimensionsSection(formProvider: form),
                  const SizedBox(height: 24),
                  const SectionTitle(title: 'Additional Information'),
                  const SizedBox(height: 12),
                  AdditionalInfoSection(formProvider: form),
                  const SizedBox(height: 24),
                  const SectionTitle(title: 'Product Images'),
                  const SizedBox(height: 12),
                  const ImagePickerSection(),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _submitForm,
                      icon: const Icon(Icons.save),
                      label: const Text('Save product'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
