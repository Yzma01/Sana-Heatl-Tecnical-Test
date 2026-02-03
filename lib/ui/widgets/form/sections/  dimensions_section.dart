import 'package:flutter/material.dart';
import 'package:sana_health_t/providers/form.dart';
import 'package:sana_health_t/ui/widgets/form/text_input.dart';

class DimensionsSection extends StatelessWidget {
  final FormProvider formProvider;

  const DimensionsSection({super.key, required this.formProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextInput(
          controller: formProvider.weightController,
          label: 'Weight (kg)',
          hint: '0.0',
          prefixIcon: Icons.scale,
          keyboardType: TextInputType.number,
          validator: formProvider.numberValidator,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: CustomTextInput(
                controller: formProvider.widthController,
                label: 'Width (cm)',
                hint: '0.0',
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomTextInput(
                controller: formProvider.heightController,
                label: 'Height (cm)',
                hint: '0.0',
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomTextInput(
                controller: formProvider.depthController,
                label: 'Depth (cm)',
                hint: '0.0',
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
