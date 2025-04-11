import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_store_delivery/Auth/forget_password/forget_password_cubit/forget_password_cubit.dart';
import 'package:one_store_delivery/Auth/login/view/login_page_view.dart';
import 'package:one_store_delivery/core/helper_fuctions.dart';
import 'package:one_store_delivery/core/validate.dart';
import 'package:one_store_delivery/home/view/custom_loading.dart';
import 'package:one_store_delivery/widgets/color.dart';
import 'package:one_store_delivery/widgets/custom_button.dart';
import 'package:one_store_delivery/widgets/custom_text.dart';
import 'package:one_store_delivery/widgets/custom_TextFormField.dart';
import 'package:one_store_delivery/widgets/custom_error_dailog.dart';

class EnterOtpPage extends StatelessWidget {
  final String phoneNumber;
  const EnterOtpPage({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    double width = MediaQuery.of(context).size.width;
    final cubit = ForgetPasswordCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 26.h),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40.w,
                    width: 40.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.lightBlue,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 15.w,
                        color: AppColor.appColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Center(
                  child: CustomText(
                    text: "أدخل رمز التحقق",
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                ),
                const SizedBox(height: 52),
                CustomTextFormField(
                  mycontroller: cubit.otpController,
                  hintText: " أدخل رمز التحقق",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "الرجاء إدخال الرمز";
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                    mycontroller: cubit.passwordController,
                    hintText: "كلمة السر الجديدة",
                    validator: (value) =>
                        Validate.validatePassword(value, context)),
                CustomTextFormField(
                    mycontroller: cubit.confirmPasswordController,
                    hintText: "تاكيد كلمة السر",
                    validator: (value) => Validate.validateConfirmPassword(
                        value, cubit.passwordController.text, context)),
                const SizedBox(height: 10),
                BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                  listener: (context, state) {
                    if (state is ForgetPasswordFailures) {
                      CustomFailureDialog.show(context,
                          "فشل في تعين كلمة المرور . يرجى التحقق من البيانات والمحاولة مرة أخرى.");
                    } else if (state is ForgetPasswordSuccess) {
                      HelperFunctions.navigateToScreen(
                        context,
                        (context) => LoginPageView(),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ForgetPasswordLoading) {
                      return const CustomLoading();
                    } else {
                      return CustomButton(
                        width: width,
                        text: "التالي",
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await cubit.forgetPassword(
                              phoneNumber,
                            );
                          }
                        },
                        colorBackGround: AppColor.appColor,
                        colorText: Colors.white,
                        colorBorder: AppColor.appColor,
                        paddingVertical: 13,
                        paddingHorizontal: 10,
                        borderRadius: 10,
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
