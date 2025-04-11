import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_store_delivery/widgets/color.dart';

class CustomTextFormField extends StatelessWidget {
  final TextAlign textAlign;
  final String? hintText;
  final TextInputType keyboardType;
  final void Function(String? newValue)? onSave;
  final TextEditingController? mycontroller;
  final String? errorMessage;

  final bool isAppColor;
  final Color? fillColor;

  final bool? isPassword;
  final Widget? suffix;
  final Widget? prefex;
  final void Function()? suffixPressed;
  final bool readOnly;
  final void Function()? onTap;
  final void Function()? onPressed;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final double? height;
  final double radius;
  final String? Function(String?)? validator;
  const CustomTextFormField({
    this.textAlign = TextAlign.start,
    this.hintText = '',
    this.onSave,
    this.validator,
    this.radius = 10,
    this.mycontroller,
    this.prefex,
    this.fillColor,
    this.keyboardType = TextInputType.name,
    super.key,
    this.errorMessage,
    this.isAppColor = false,
    this.onTap,
    this.readOnly = false,
    this.isPassword = false,
    this.suffix,
    this.suffixPressed,
    this.onPressed,
    this.onChanged,
    this.height,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    String initialValue = mycontroller?.text ?? '';

    bool hasValueChanged() {
      return mycontroller?.text != initialValue;
    }

    return Theme(
      data: Theme.of(context).copyWith(
          textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColor.appColor,
        selectionColor: AppColor.appColor,
        selectionHandleColor: Colors.orange,
      )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: SizedBox(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height,
              child: TextFormField(
                cursorColor: AppColor.appColor,
                obscureText: isPassword!,
                readOnly: readOnly,
                onTap: onTap,
                controller: mycontroller,
                textAlign: textAlign,
                keyboardType: keyboardType,
                style: const TextStyle(
                  locale: Locale('ar'),
                  fontFamily: 'Cairo',
                  fontSize: 15,
                  color: AppColor.colorText,
                  fontWeight: FontWeight.w400,
                ),
                maxLength: null,
                validator: validator,
                decoration: InputDecoration(
                  filled: true,
                  // constraints: BoxConstraints(minHeight: height),
                  fillColor: fillColor ?? AppColor.grayA1,

                  focusColor: AppColor.appColor,
                  hintText: hintText,
                  alignLabelWithHint: true,
                  isDense: true,
                  hintStyle: const TextStyle(
                    locale: Locale('ar'),
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColor.colorText,
                  ),
                  prefixIcon: prefex,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 15.h),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: (isAppColor)
                            ? AppColor.appColor
                            : AppColor.grayhintText),
                    borderRadius: BorderRadius.all(
                      Radius.circular(radius),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.appColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(radius),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.redAccent),
                    borderRadius: BorderRadius.all(
                      Radius.circular(radius),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.appColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(radius),
                    ),
                  ),
                  suffixIcon: suffix,
                ),
                onSaved: onSave,
                onChanged: onChanged,
                onFieldSubmitted: onFieldSubmitted,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
