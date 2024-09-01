import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class CustomIndicatorPageView extends StatefulWidget {
  final PageController controller;
  CustomIndicatorPageView({required this.controller});

  @override
  _CustomIndicatorPageViewState createState() => _CustomIndicatorPageViewState();
}

class _CustomIndicatorPageViewState extends State<CustomIndicatorPageView> {
  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
        controller: widget.controller,
        count:3,
        effect: ScaleEffect(
          activeDotColor: Color(0xFF2c93e7),
          activePaintStyle: PaintingStyle.stroke,
          //  dotColor: Color(0xFF888888),
          activeStrokeWidth: 2,
          strokeWidth:3,
          scale: 2.4,
          radius: 10,
          spacing: 10,
          dotHeight: 6,
          dotWidth: 6,
          paintStyle: PaintingStyle.fill,
        ));
  }
}