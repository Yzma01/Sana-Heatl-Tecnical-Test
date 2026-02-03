import 'package:flutter/material.dart';
import 'package:sana_health_t/providers/form.dart';
import 'package:sana_health_t/ui/widgets/form/text_input.dart';

class PricingSection extends StatelessWidget {
  final FormProvider formProvider;

  const PricingSection({super.key, required this.formProvider});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextInput(
            controller: formProvider.priceController,
            label: 'Price',
            hint: '0.00',
            prefixIcon: Icons.attach_money,
            keyboardType: TextInputType.number,
            validator: formProvider.numberValidator,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: CustomTextInput(
            controller: formProvider.discountController,
            label: 'Discount %',
            hint: '0',
            prefixIcon: Icons.percent,
            keyboardType: TextInputType.number,
            validator: formProvider.percentageValidator,
          ),
        ),
      ],
    );
  }
}
