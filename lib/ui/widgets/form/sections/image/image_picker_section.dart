import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sana_health_t/data/models/image.dart';
import 'package:sana_health_t/providers/form.dart';
import 'package:sana_health_t/ui/widgets/form/sections/image/empy_image.dart';
import 'package:sana_health_t/ui/widgets/form/sections/image/image_listview.dart';
import 'package:sana_health_t/ui/widgets/form/sections/image/image_preview_card.dart';

class ImagePickerSection extends StatelessWidget {
  const ImagePickerSection({super.key});

  void _showImageSourceDialog(BuildContext context, FormProvider provider) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                provider.pickImagesFromGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context);
                provider.pickImageFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Add from URL'),
              onTap: () {
                Navigator.pop(context);
                _showUrlDialog(context, provider);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showUrlDialog(BuildContext context, FormProvider provider) {
    final TextEditingController urlController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Image from URL'),
        content: TextField(
          controller: urlController,
          decoration: const InputDecoration(
            hintText: 'https://example.com/image.jpg',
            labelText: 'Image URL',
          ),
          keyboardType: TextInputType.url,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (urlController.text.trim().isNotEmpty) {
                provider.addNetworkImage(urlController.text.trim());
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Product Images',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (provider.selectedImages.isNotEmpty)
                  TextButton.icon(
                    onPressed: () => provider.clearImages(),
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: const Text('Clear all'),
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            if (provider.selectedImages.isEmpty)
              EmptyImageState(
                onTap: () => _showImageSourceDialog(context, provider),
              )
            else
              ImageListView(
                images: provider.selectedImages,
                onAddMore: () => _showImageSourceDialog(context, provider),
                onRemove: provider.removeImage,
                onReorder: provider.reorderImages,
              ),
          ],
        );
      },
    );
  }
}
