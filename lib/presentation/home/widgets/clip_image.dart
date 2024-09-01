import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClipImage extends StatelessWidget {
  final String imagePath;
  final Radius topLeftRadius;
  final Radius bottomRightRadius;
  const ClipImage({super.key,required this.imagePath,required this.topLeftRadius,required this.bottomRightRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: topLeftRadius!,
          bottomRight: bottomRightRadius!

        ),
        child: Image.asset(imagePath));
  }
}
