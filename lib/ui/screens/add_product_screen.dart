import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sana_health_t/blocs/product/bloc/product_bloc.dart';
import 'package:sana_health_t/blocs/product/bloc/product_event.dart';
import 'package:sana_health_t/providers/form.dart';
import 'package:sana_health_t/ui/widgets/form/sections.dart/%20%20dimensions_section.dart';
import 'package:sana_health_t/ui/widgets/form/sections.dart/%20additional_info_section.dart';
import 'package:sana_health_t/ui/widgets/form/sections.dart/%20basic_data_section.dart';
import 'package:sana_health_t/ui/widgets/form/sections.dart/%20inventory_section.dart';
import 'package:sana_health_t/ui/widgets/form/sections.dart/image_picker_section.dart';
import 'package:sana_health_t/ui/widgets/form/sections.dart/pricing_section.dart';
import 'package:sana_health_t/ui/widgets/general/section_title.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late FormProvider form;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    form = context.read<FormProvider>();
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
      context.read<ProductBloc>().add(AddProduct(productData));
      form.clearForm();
      form.clearImages();
      Navigator.pop(context);
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
