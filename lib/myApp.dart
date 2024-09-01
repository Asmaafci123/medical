import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:more4u/presentation/home/cubits/home_cubit.dart';
import 'package:more4u/presentation/medication/cubits/request_medication_cubit.dart';
import 'package:more4u/presentation/more4u_home/cubits/more4u_home_cubit.dart';
import 'package:more4u/presentation/pending_requests/cubits/pending_requests_cubit.dart';
import 'package:more4u/presentation/terms_and_conditions/cubits/terms_and_conditions_cubit.dart';
import 'core/constants/constants.dart';
import 'core/themes/app_colors.dart';
import 'injection_container.dart';
import 'core/config/routes/routes.dart';
import 'presentation/notification/cubits/notification_cubit.dart';
import 'presentation/splash/splash_screen.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: false,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<HomeCubit>(
                create: (context) => sl<HomeCubit>(),
              ),
              BlocProvider<More4uHomeCubit>(
                create: (context) => sl<More4uHomeCubit>(),
              ),
              BlocProvider<NotificationCubit>(
                create: (context) => sl<NotificationCubit>(),
              ),
              BlocProvider<TermsAndConditionsCubit>(
                  create: (context) => sl<TermsAndConditionsCubit>()
              ),
              BlocProvider<RequestMedicationCubit>(
                  create: (context) =>sl<RequestMedicationCubit>()
              ),
              BlocProvider<PendingRequestsCubit>(
                  create: (context) =>sl<PendingRequestsCubit>()
              ),
            ],
            child: MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              color: AppColors.mainColor,
              theme: ThemeData(
                primaryColor: AppColors.mainColor,
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: AppColors.mainColor,
                ),
                iconTheme: IconThemeData(color: AppColors.greyColor, size: 20.r),
                fontFamily: 'Cairo',
                drawerTheme:
                    DrawerThemeData(scrimColor: Colors.black.withOpacity(0.2))
                ,
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: <TargetPlatform, PageTransitionsBuilder>{
                    TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                  },
                ),
              ),
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppRoutes.onGenerateRoutes,
              initialRoute: SplashScreen.routeName,
            ),
          );
        },
    useInheritedMediaQuery: true,);
  }
}
