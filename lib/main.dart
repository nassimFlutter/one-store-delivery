import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_store_delivery/Auth/forget_password/forget_password_cubit/forget_password_cubit.dart';
import 'package:one_store_delivery/Auth/forget_password/send_otp_cubit/send_otp_cubit.dart';
import 'package:one_store_delivery/Auth/login/login_cubit/login_cubit.dart';
import 'package:one_store_delivery/Auth/register/manager/cubit/register_cubit.dart';
import 'package:one_store_delivery/core/utils/cache_helper.dart';
import 'package:one_store_delivery/core/utils/service_locator.dart';
import 'package:one_store_delivery/generated/l10n.dart';
import 'package:one_store_delivery/home/cubits/edit_order_cubit/edit_order_cubit.dart';
import 'package:one_store_delivery/home/cubits/home_cubit/home_cubit.dart';
import 'package:one_store_delivery/splach_view.dart';

void main() async {
  // for ensure doing all lines before "runApp function"
  WidgetsFlutterBinding.ensureInitialized();
  // --------------------------------------------------
  CacheHelper.cacheInit();
  // for make device can not rotate
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // --------------------------------------------------
  // for initialized `ServiceLocator` for `getIt` package
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          const Size(375, 812), // Set your design size based on your UI design
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
          ],
          child: MaterialApp(
            title: 'One Store Delivery',
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
            home: SplashScreen(),
          ),
        );
      }),
    );
  }
}
