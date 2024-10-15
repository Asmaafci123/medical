import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/core/constants/app_strings.dart';
import 'package:more4u/core/constants/constants.dart';
import 'package:more4u/custom_icons.dart';
import 'package:more4u/injection_container.dart';
import 'package:more4u/presentation/Login/widgets/custom_more4u_logo.dart';
import 'package:more4u/presentation/Login/widgets/cutom_text_form_field.dart';
import 'package:more4u/presentation/Login/widgets/logo.dart';
import 'package:more4u/presentation/Login/widgets/terms_and_conditions.dart';
import 'package:more4u/presentation/terms_and_conditions/terms_and_conditions.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeago/timeago.dart';
import '../../core/themes/app_colors.dart';
import '../home/home_screen.dart';
import '../widgets/powered_by_cemex.dart';
import '../widgets/utils/loading_dialog.dart';
import '../widgets/utils/message_dialog.dart';
import 'cubits/login_cubit.dart';
import 'cubits/login_states.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'LoginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late LoginCubit _cubit;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _cubit = sl<LoginCubit>();
    super.initState();
  }

  String? validateEmail(String? value) {
    if (value != null && value.isEmpty) {
      return 'emailError';
    } else {
      return null;
    }
  }

//   validate Password
  String? validatePassword(String? value) {
    if (value != null && value.isEmpty) {
      return 'passwordError';
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.locale == const Locale('en')) {
      _cubit.changeAppLanguage('English');
    } else {
      _cubit.changeAppLanguage('Arabic');
    }
    if (context.locale.languageCode == 'ar') {
      timeago.setLocaleMessages('ar', ArMessages());
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            const CustomLogo(),
            const CustomMore4uLogo(),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: BlocConsumer(
                bloc: _cubit, //login cubit
                listener: (context, state) {
                  if (state is LoginLoadingState) loadingAlertDialog(context);
                  if (state is LoginErrorState) {
                    Navigator.pop(context);
                    showMessageDialog(
                      context: context,
                      message: state.message,
                      isSucceeded: false,
                    );
                  }
                  if (state is LoginSuccessState) {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomeScreen.routeName, (Route<dynamic> route) => false);
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      CustomTextFormField(
                        maxLines:1,
                        prefixIcon: Icon(
                          CustomIcons.user_info,
                          size: 20.r,
                        ),
                        labelText: AppStrings.userNumber.tr(),
                        hintText:
                            "${AppStrings.enterYourNumber.tr()} ${AppStrings.example.tr()} 45629438",
                        keyboardType: TextInputType.number,
                        controller: _cubit.userNumberController,
                        suffixIconConstraints:
                            BoxConstraints(maxHeight: 20.h, minWidth: 50.w),
                        prefixIconConstraints:
                            BoxConstraints(minHeight: 20.h, minWidth: 40.w),
                        textInputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                        ],
                        obscureText: false,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextFormField(
                        maxLines:1,
                        prefixIcon: Icon(
                          CustomIcons.lock2,
                          size: 20.r,
                        ),
                        suffixIcon: Material(
                          color: Colors.transparent,
                          type: MaterialType.circle,
                          clipBehavior: Clip.antiAlias,
                          borderOnForeground: true,
                          elevation: 0,
                          child: IconButton(
                            onPressed: () {
                              _cubit
                                  .changeTextVisibility(!_cubit.isTextVisible);
                            },
                            icon: !_cubit.isTextVisible
                                ? Icon(
                                    Icons.visibility_off_outlined,
                                    size: 20.r,
                                  )
                                : Icon(
                                    Icons.remove_red_eye_outlined,
                                    size: 20.r,
                                  ),
                          ),
                        ),
                        labelText: AppStrings.password.tr(),
                        hintText: AppStrings.enterYourPassword.tr(),
                        keyboardType: TextInputType.visiblePassword,
                        controller: _cubit.passwordController,
                        suffixIconConstraints:
                            BoxConstraints(minHeight: 50.h, minWidth: 50.w),
                        prefixIconConstraints:
                            BoxConstraints(minHeight: 20.h, minWidth: 40.w),
                        obscureText: !_cubit.isTextVisible,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      DropdownButtonFormField(
                        style: TextStyle(
                            color: AppColors.mainColor, fontSize: 16.sp),
                        validator: (String? value) {
                          if (value == null) return AppStrings.required.tr();
                          return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.5.w, color: AppColors.greyColor)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 0.5.w)),
                          isDense: false,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 8.w),
                          suffixIconConstraints:
                              BoxConstraints(minHeight: 50.h, minWidth: 50.w),
                          prefixIconConstraints:
                              BoxConstraints(minHeight: 20.h, minWidth: 40.w),
                          prefixIcon: const Icon(
                            Icons.language,
                          ),
                          border: const OutlineInputBorder(),
                          labelText: AppStrings.language.tr(),
                          hintText: AppStrings.enterLanguage.tr(),
                          labelStyle: TextStyle(
                            fontSize: 16.sp,
                              fontFamily: "Certa Sans"
                          ),
                          hintStyle: TextStyle(
                            color: Color(0xffc1c1c1),
                            fontSize: 16.sp,
                              fontFamily: "Certa Sans"
                          ),
                          errorStyle: TextStyle(
                            fontSize: 12.sp,
                              fontFamily: "Certa Sans"
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        items: ['English', 'Arabic'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value == 'Arabic' ? "عربى" : value,style: TextStyle(   fontFamily: "Certa Sans",),),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          _cubit.changeAppLanguage(newValue!);
                          if (newValue == 'English') {
                            context.setLocale(const Locale('en'));
                          } else {
                            context.setLocale(const Locale('ar'));
                          }
                        },
                        iconSize: 20.r,
                        value: _cubit.dropdownvalue,
                      ),
                      SizedBox(
                        height: 55.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _cubit.login();
                          }
                        },
                        child: Container(
                          height: 60.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
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
                                  ])),
                          child: Center(
                            child: Text(
                              AppStrings.login.tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Certa Sans",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.sp),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                     CustomTermsAndConditions(),
                      const PoweredByCemex()
                    ]),
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
