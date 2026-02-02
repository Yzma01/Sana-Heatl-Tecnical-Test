import 'package:flutter/cupertino.dart';

class ImagesCarousel extends StatelessWidget {
  final List<String> images;

  const ImagesCarousel({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    debugPrint('Building ImagesCarousel with ${images.length} images');
    return SizedBox(
      height: 300,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Image.network(images[index], fit: BoxFit.cover);
        },
      ),
    );
  }
}
