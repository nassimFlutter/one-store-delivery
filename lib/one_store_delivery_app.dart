import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_store_delivery/Auth/forget_password/forget_password_cubit/forget_password_cubit.dart';
import 'package:one_store_delivery/Auth/forget_password/send_otp_cubit/send_otp_cubit.dart';
import 'package:one_store_delivery/Auth/login/login_cubit/login_cubit.dart';
import 'package:one_store_delivery/Auth/register/manager/cubit/register_cubit.dart';
import 'package:one_store_delivery/generated/l10n.dart';
import 'package:one_store_delivery/home/cubits/edit_order_cubit/edit_order_cubit.dart';
import 'package:one_store_delivery/home/cubits/home_cubit/home_cubit.dart';
import 'package:one_store_delivery/profile/manager/profile_cubit/profile_cubit.dart';
import 'package:one_store_delivery/splach_view.dart';

class OneStoreDeliveryApp extends StatelessWidget {
  const OneStoreDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: Builder(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginCubit(),
            ),
            BlocProvider(
              create: (context) => HomeCubit(),
            ),
            BlocProvider(
              create: (context) => RegisterCubit(),
            ),
            BlocProvider(
              create: (context) => EditOrderCubit(),
            ),
            BlocProvider(
              create: (context) => SendOtpCubit(),
            ),
            BlocProvider(
              create: (context) => ForgetPasswordCubit(),
            ),
            BlocProvider(
              create: (context) => ProfileCubit(),
            ),
          ],
          child: MaterialApp(
            title: 'One store delivery',
            locale: const Locale('ar'),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
                fontFamily: "Cairo"),
            home: const SplashScreen(),
          ),
        );
      }),
    );
  }
}
