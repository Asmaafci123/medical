import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:dartz/dartz.dart' as dz;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/core/constants/app_strings.dart';
import 'package:more4u/core/errors/failures.dart';
import 'package:more4u/data/datasources/local_data_source/local_data_source.dart';
import 'package:more4u/data/datasources/local_data_source/secure_local_data_source.dart';
import 'package:more4u/domain/entities/mobile_version.dart';
import 'package:more4u/domain/usecases/get_mobile_version.dart';
import 'package:more4u/presentation/Login/login_screen.dart';
import 'package:more4u/presentation/widgets/helpers.dart';
import 'package:more4u/presentation/widgets/powered_by_cemex.dart';
import 'package:more4u/presentation/widgets/utils/message_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/constants.dart';
import '../../core/themes/app_colors.dart';
import '../../domain/usecases/get_home_data.dart';
import '../../injection_container.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../home/home_screen.dart';
import '../more4u_home/more4u_home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'SplashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? user;
  int? langId;

  String? version;


  _startDelay() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
    Timer(const Duration(seconds: 1), _checkVersion);
  }

  _checkVersion() async {

    var result = await _getMobileVersion();
    result.fold((failure) {
      if (failure.message ==AppStrings.noInternetConnection.tr()) {
        setState(() {
          isOffline=true;
        });
      }
      else
        {
      showMessageDialog(
          context: context,
          isSucceeded: false,
          message: failure.message,
          onPressedOk: () {
            if (failure.message !=AppStrings.noInternetConnection.tr()) {
              logOut(context);
            }
          });}
    }, (r) {
      Platform.isAndroid
          ? version!.compareTo(r.data.androidVersion??'1.0.0') == -1
          ? showAndroidUpdateDialog(r)
          : _goNext()
          : version!.compareTo(r.data.iosVersion??'1.0.0') == -1
          ? showIosUpdateDialog(r)
          : _goNext();
    });
  }

  Future<dynamic> showAndroidUpdateDialog(MobileVersion r) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title:Text(AppStrings.newVersionAvailable.tr()),
            content: Text(
                '${AppStrings.pleaseUpdateAppToNewVersion.tr()} ${r.data.androidVersion ?? ''}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  final Uri url = Uri.parse(r.data.androidLink ?? '');
                  _launchUrl(url);
                },
                child:Text(AppStrings.update.tr()),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> showIosUpdateDialog(MobileVersion r) {
    return showCupertinoDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: CupertinoAlertDialog(
            title:Text(AppStrings.newVersionAvailable.tr()),
            content: Text(
                '${AppStrings.pleaseUpdateAppToNewVersion.tr()} ${r.data.iosVersion ?? ''}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  final Uri url = Uri.parse(r.data.iosLink ?? '');
                  _launchUrl(url);
                },
                child: Text(AppStrings.update.tr()),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url,mode: LaunchMode.externalApplication,)) {
      throw Exception('Could not launch $url');
    }
  }

  _goNext() async {
    var result = await _getMobileVersion();
    result.fold((l) => null, (r) => null);
    await _getUserData();
    await _getLanguageCode();
    if (user == null) {
      if (!mounted) return;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    }else{
      Navigator.of(context).pushNamedAndRemoveUntil(
         HomeScreen.routeName, (Route<dynamic> route) => false);
    }
  }
  _getUserData() async {
    final secureStorage=SecureStorageImpl();
    String? userId=await secureStorage.readSecureData('user id');
    String? accToken=await  secureStorage.readSecureData('user accessToken');
    String? refToken=await secureStorage.readSecureData('user refreshToken');
    Map<String,dynamic> savedUser = {
      'userNumber':userId,
      'accessToken':accToken,
      'refreshToken':refToken,
    };
    final String cachedUser=jsonEncode(savedUser);
    setState(() {
      if(userId==null ||accToken==null || refToken==null)
      {
        user=null;
      }
      else
      {
        user = cachedUser;
        accessToken=savedUser['accessToken'];
        refreshToken=savedUser['refreshToken'];
        userNumber=int.parse(savedUser['userNumber']);
      }
    });
  }

  _getLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    final int? languageCode = prefs.getInt(APP_LANGUAGE);
    setState(() {
      langId = languageCode;
    });
  }

  Future<dz.Either<Failure, MobileVersion>> _getMobileVersion() async {
    GetMobileVersionUseCase getMobileVersionUseCase =
    sl<GetMobileVersionUseCase>();
    return await getMobileVersionUseCase();
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (context.locale.languageCode == 'ar') {
      timeago.setLocaleMessages('ar', ArMessages());
    }
    return Scaffold(
      body: SafeArea(
        child: isOffline==false?
        Column(
          children: [
            Center(
              child: SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/decoration.png',
                    fit: BoxFit.fitWidth,
                  )),
            ),
            Spacer(),
            Center(
              child: Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/images/more4u_new.png',
                  height: 209.h,
                  width: 275.w,
                ),
              ),
            ),
            SizedBox(height: 8.h,),
            Text(version??'unknown',style: TextStyle(fontSize: 12.sp),),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  color: Color(0xFF1980ff),
                ),
              ),
            ),
            Spacer(),
            PoweredByCemex(),
            SizedBox(
              height: 40.h,
            )
          ],
        ):
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20.h, 0,0.h),
                child: Center(
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'assets/images/more4u_new.png',
                      height: 170.h,
                      width: 180.w,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              CircleAvatar(
                radius: 40.r,
                backgroundColor: Colors.grey[300],
                child: Icon(
                  Icons.signal_wifi_bad_rounded,color: Colors.grey[700],
                  size: 45.r,),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text("You're offline",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text("Check your connection",
                style: TextStyle(
                    color: Colors.grey[800],
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    _startDelay();
                  });
                },
                child: Container(
                  width: 140.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                          color: AppColors.mainColor
                      )
                  ),
                  child:Center(child: Text("Try again",
                    style: TextStyle(
                        color: AppColors.mainColor,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp
                    ),)),
                ),
              ),
              Spacer(),
              const PoweredByCemex(),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
