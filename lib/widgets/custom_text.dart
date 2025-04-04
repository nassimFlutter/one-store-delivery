import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:one_store_delivery/widgets/color.dart';


class CustomText extends StatelessWidget {
  final String text;

  final double fontSize;

  final FontWeight fontWeight;

  final Color color;
  final int? maxLine;
  final String? fontFamily;

  final TextAlign? textAlign;
  final bool? underLine;
  final bool? islinThrough;
  const CustomText({
    super.key,
    this.text = '',
    this.fontSize = 18,
    this.underLine,
    this.maxLine = 2,
    this.islinThrough,
    this.color = AppColor.colorText,
    this.fontWeight = FontWeight.w500,
    this.fontFamily = 'Cairo',
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      style: TextStyle(
        height: 1.3,
        overflow: TextOverflow.ellipsis,
        color: color,
        decoration: underLine != null
            ? TextDecoration.underline
            : islinThrough != null
                ? TextDecoration.lineThrough
                : null,
        fontSize: fontSize,
        decorationColor:
            islinThrough != null ? AppColor.grayhintText : AppColor.appColor,
        fontWeight: fontWeight,
        fontFamily: 'Cairo',
      ),
    );
  }
}
