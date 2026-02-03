import 'package:flutter/material.dart';
import 'package:sana_health_t/providers/form.dart';
import 'package:sana_health_t/ui/widgets/form/selector_input.dart';
import 'package:sana_health_t/ui/widgets/form/text_input.dart';

class InventorySection extends StatelessWidget {
  final FormProvider formProvider;

  const InventorySection({super.key, required this.formProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextInput(
                controller: formProvider.stockController,
                label: 'Stock',
                hint: '0',
                prefixIcon: Icons.inventory,
                keyboardType: TextInputType.number,
                validator: formProvider.numberValidator,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomTextInput(
                controller: formProvider.minimumOrderController,
                label: 'Min. Order',
                hint: '1',
                prefixIcon: Icons.shopping_cart,
                keyboardType: TextInputType.number,
                validator: formProvider.numberValidator,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SelectorInput<String>(
          label: 'Availability Status',
          hint: 'Select status',
          prefixIcon: Icons.check_circle,
          value: formProvider.selectedAvailability,
          items: formProvider.availabilityStatuses
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
          onChanged: (value) {
            formProvider.updateAvailability(value);
          },
          validator: formProvider.basicSelectorValidator,
        ),
      ],
    );
  }
}
