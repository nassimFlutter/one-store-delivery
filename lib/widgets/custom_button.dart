import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final Color colorText;
  final FontWeight fontWeight;
  final double fontSize;
  final Color colorBorder;
  final Color colorBackGround;
  final String text;
  final double paddingVertical;
  final double paddingHorizontal;
  final double borderRadius;
  final double? width;
  final double? height;
  final String? icon;
  final void Function()? onPressed;
  const CustomButton(
      {super.key,
      required this.text,
      required this.colorBackGround,
      required this.colorText,
      required this.colorBorder,
      this.onPressed,
      required this.paddingVertical,
      required this.paddingHorizontal,
      required this.borderRadius,
      this.width,
      this.icon,
      this.fontWeight = FontWeight.w600,
      this.fontSize = 17.51,
      this.height = 50});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        // boxShadow: [
        //   BoxShadow(
        //     color: (colorBackGround == Colors.transparent)
        //         ? Colors.transparent
        //         : Colors.grey.withOpacity(0.5),
        //     offset: Offset(0, 2),
        //     spreadRadius: 1,
        //     blurRadius: 5,
        //   )
        // ]
      ),
      width: width,
      height: height,
      child: TextButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(colorBackGround),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(
                      horizontal: paddingHorizontal,
                      vertical: paddingVertical)),
              foregroundColor: MaterialStateProperty.all<Color>(colorBorder),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      side: BorderSide(color: colorBorder)))),
          onPressed: onPressed,
          child: Center(
            child: Row(
              mainAxisAlignment: icon != null
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: SvgPicture.asset(
                      icon!,
                      color: colorText,
                      width: 18.w,
                    ),
                  ),
                CustomText(
                    text: text,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: colorText),
              ],
            ),
          )),
    );
  }
}
