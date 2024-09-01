import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/core/themes/app_colors.dart';
class CallIcon extends StatelessWidget {
  const CallIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                0.0,
                0.7,
                1
              ],
              //  tileMode: TileMode.repeated,
              colors: [
                Color(0xFF00a7ff),
                Color(0xFF2a64ff),
                Color(0xFF1980ff),
              ])
      ),
      child: CircleAvatar(
        radius: 25.r,
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.phone,
          color:AppColors.whiteColor,
        ),
      ),
    );
  }
}

