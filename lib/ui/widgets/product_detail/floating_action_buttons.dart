import 'package:flutter/material.dart';

class ProductFloatingActionButtons extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductFloatingActionButtons({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'edit',
          onPressed: onEdit,
          backgroundColor: Colors.amber,
          child: const Icon(Icons.edit),
        ),
        const SizedBox(height: 12),
        FloatingActionButton(
          heroTag: 'delete',
          onPressed: onDelete,
          backgroundColor: Colors.red,
          child: const Icon(Icons.delete_forever),
        ),
      ],
    );
  }
}
