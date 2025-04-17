import 'package:flutter/material.dart';
import 'package:one_store_delivery/widgets/color.dart';

abstract class AppStyles {
  static String getFontFamily(BuildContext context) {
    return "";
  }

  static TextStyle getCustomTextStyle(
      BuildContext context, TextStyle textStyle) {
    String fontFamily = getFontFamily(context);
    return textStyle.copyWith(fontFamily: fontFamily);
  }

  static TextStyle style28w600GrayA1(context) {
    return getCustomTextStyle(
      context,
      const TextStyle(
        color: AppColor.grayA1,
        fontSize: 28, 
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static TextStyle style16w600GrayA1(context) {
    return getCustomTextStyle(
      context,
      const TextStyle(
        color: AppColor.grayA1,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        
      ),
    );
  }
}
