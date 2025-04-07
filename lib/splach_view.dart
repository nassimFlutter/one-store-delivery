import 'dart:async';
import 'package:flutter/material.dart';
import 'package:one_store_delivery/Auth/login/view/login_page_view.dart';
import 'package:one_store_delivery/core/assets_path/icons_path.dart';
import 'package:one_store_delivery/core/helper_fuctions.dart';
import 'package:one_store_delivery/core/utils/app_keys.dart';
import 'package:one_store_delivery/core/utils/cache_helper.dart';
import 'package:one_store_delivery/home/view/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Start animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();

    // Wait for animation + navigate
    Timer(const Duration(seconds: 3), () async {
      final token = await CacheHelper.getData(key: AppKeys.kToken);

      if (!mounted) return;

      if (token != null) {
        HelperFunctions.navigateToScreenAndRemove(
          context,
          (context) => const MainPage(),
        );
      } else {
        HelperFunctions.navigateToScreenAndRemove(
          context,
          (context) => LoginPageView(),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: const Image(
            image: AssetImage(IconsPath.iconsLogo),
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}
