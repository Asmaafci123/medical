import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:more4u/data/datasources/local_data_source/local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/firebase/push_notification_service.dart';
import '../../core/themes/app_colors.dart';
import '../../data/datasources/local_data_source/secure_local_data_source.dart';
import '../Login/login_screen.dart';
import '../notification/cubits/notification_cubit.dart';

Color getBenefitStatusColor(String status) {
  switch (status) {
    case 'Pending':
      return Colors.indigo;
    case 'InProgress':
      return AppColors.yellowColor;
    case 'Approved':
      return AppColors.greenColor;

    default:
      return AppColors.redColor;
  }
}

Uint8List decodeImage(String imageBase64) {
  try {
    return base64Decode(imageBase64);
  } catch (error) {
    return Uint8List(0);
  }
}

void logOut(BuildContext context) {
  NotificationCubit.get(context).notifications.clear();
  PushNotificationService.deleteDeviceToken();
  final secureStorage=SecureStorageImpl();
  secureStorage.deleteSecureData('user id');
  secureStorage.deleteSecureData('user accessToken');
  secureStorage.deleteSecureData('user refreshToken');
  SharedPreferences.getInstance().then((value) async {
    await value.reload();
    return value.clear();
  });
  Navigator.of(context).pushNamedAndRemoveUntil(
      LoginScreen.routeName, (Route<dynamic> route) => false);
}
