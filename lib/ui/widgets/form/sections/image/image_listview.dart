import 'package:flutter/material.dart';
import 'package:sana_health_t/data/models/image.dart';
import 'package:sana_health_t/ui/widgets/form/sections/image/add_more_image_button.dart';
import 'package:sana_health_t/ui/widgets/form/sections/image/image_preview_card.dart';

class ImageListView extends StatelessWidget {
  final List<ProductImage> images;
  final VoidCallback onAddMore;
  final Function(int) onRemove;
  final Function(int, int)? onReorder;

  const ImageListView({
    required this.images,
    required this.onAddMore,
    required this.onRemove,
    this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: ReorderableListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length + 1,
            onReorder: (oldIndex, newIndex) {
              if (oldIndex < images.length && onReorder != null) {
                onReorder!(oldIndex, newIndex);
              }
            },
            itemBuilder: (context, index) {
              if (index == images.length) {
                return AddMoreImageButton(
                  key: const ValueKey('add_more'),
                  onTap: onAddMore,
                );
              }
              return ImagePreviewCard(
                key: ValueKey(images[index].id ?? index),
                image: images[index],
                isMain: index == 0,
                onRemove: () => onRemove(index),
              );
            },
          ),
        ),
        if (images.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '${images.length} image(s) selected. First image will be the main thumbnail. Long press to reorder.',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
