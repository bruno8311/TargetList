import 'package:flutter/material.dart';

class ImageSectionWidget extends StatelessWidget {
  final String? imageUrl;
  final double size;
  const ImageSectionWidget({
    super.key,
    this.imageUrl,
    this.size = 150
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? Image.network(imageUrl!)
                  : Icon(Icons.image, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
