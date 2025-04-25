import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:one_store_delivery/core/assets_path/icons_path.dart';
import 'package:one_store_delivery/widgets/color.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.inkDrop(
        color: AppColor.appColor,
        size: 30,
      ),
    );
  }
}

class CustomLoadingAnimate extends StatelessWidget {
  const CustomLoadingAnimate({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        IconsPath.loading,
        repeat: true,
        animate: true,
      ),
    );
  }
}
