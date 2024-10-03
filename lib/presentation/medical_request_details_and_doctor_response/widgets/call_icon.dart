import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/core/themes/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
class CallIcon extends StatelessWidget {
  final String? phoneNumber;
  const CallIcon({super.key,this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ()async
      {
        await launchUrl(Uri.parse("tel://$phoneNumber"),mode: LaunchMode.externalApplication,);
      },
      child: Container(
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
      ),
    );
  }
}

