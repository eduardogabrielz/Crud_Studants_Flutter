import 'package:crud/colorPallete/palette.dart';
import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: ColorPalette.borderColorInput),
          borderRadius: BorderRadius.circular(16),
          color: ColorPalette.iconBackgroundColor),
      child: Image.network(
        imagePath,
        width: 50,
        height: 50,
        fit: BoxFit.contain,
      ),
    );
  }
}
