import 'package:flutter/material.dart';
import 'package:one_store_delivery/widgets/color.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: AppColor.appColor,
    ));
  }
}
