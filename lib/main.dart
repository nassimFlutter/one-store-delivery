import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_store_delivery/core/utils/bloc_observer.dart';
import 'package:one_store_delivery/core/utils/cache_helper.dart';
import 'package:one_store_delivery/core/utils/service_locator.dart';

import 'one_store_delivery_app.dart';

class CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

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
  HttpOverrides.global = CustomHttpOverrides();

  Bloc.observer = MyBlocObserver();

  // --------------------------------------------------
  // for initialized `ServiceLocator` for `getIt` package
  setupServiceLocator();
  runApp(const OneStoreDeliveryApp());
}
