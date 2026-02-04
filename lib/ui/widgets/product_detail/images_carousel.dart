import 'package:flutter/cupertino.dart';
import 'dart:io';

class ImagesCarousel extends StatelessWidget {
  final List<String> images;

  const ImagesCarousel({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];

          return Image(
            image: image.startsWith('http')
                ? NetworkImage(image)
                : FileImage(File(image)) as ImageProvider,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
