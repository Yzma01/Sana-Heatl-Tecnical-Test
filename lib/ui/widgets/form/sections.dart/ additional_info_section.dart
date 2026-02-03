import 'package:flutter/material.dart';
import 'package:sana_health_t/providers/form.dart';
import 'package:sana_health_t/ui/widgets/form/text_input.dart';

class AdditionalInfoSection extends StatelessWidget {
  final FormProvider formProvider;

  const AdditionalInfoSection({super.key, required this.formProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextInput(
          controller: formProvider.warrantyController,
          label: 'Warranty Information',
          hint: 'e.g., 1 year warranty',
          prefixIcon: Icons.verified_user,
        ),
        const SizedBox(height: 12),
        CustomTextInput(
          controller: formProvider.shippingController,
          label: 'Shipping Information',
          hint: 'e.g., Ships in 3-5 business days',
          prefixIcon: Icons.local_shipping,
        ),
        const SizedBox(height: 12),
        CustomTextInput(
          controller: formProvider.returnPolicyController,
          label: 'Return Policy',
          hint: 'e.g., 30 days return policy',
          prefixIcon: Icons.assignment_return,
        ),
        const SizedBox(height: 12),
        CustomTextInput(
          controller: formProvider.barcodeController,
          label: 'Barcode',
          hint: 'Enter product barcode',
          prefixIcon: Icons.qr_code_2,
        ),
        const SizedBox(height: 12),
        CustomTextInput(
          controller: formProvider.tagsController,
          label: 'Tags (comma separated)',
          hint: 'e.g., beauty, mascara, makeup',
          prefixIcon: Icons.label,
        ),
      ],
    );
  }
}
