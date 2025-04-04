import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_store_delivery/Auth/forget_password/send_otp_page.dart';
import 'package:one_store_delivery/Auth/login/login_cubit/login_cubit.dart';
import 'package:one_store_delivery/Auth/register/register_page_view.dart';
import 'package:one_store_delivery/core/assets_path/icons_path.dart';
import 'package:one_store_delivery/core/helper_fuctions.dart';
import 'package:one_store_delivery/core/validate.dart';
import 'package:one_store_delivery/home/view/custom_loading.dart';
import 'package:one_store_delivery/home/view/home_page_view.dart';
import 'package:one_store_delivery/home/view/main_page.dart';
import 'package:one_store_delivery/widgets/color.dart';
import 'package:one_store_delivery/widgets/custom_TextFormField.dart';
import 'package:one_store_delivery/widgets/custom_button.dart';
import 'package:one_store_delivery/widgets/custom_error_dailog.dart';
import 'package:one_store_delivery/widgets/custom_text.dart';

class LoginPageView extends StatelessWidget {
  LoginPageView({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    LoginCubit cubit = LoginCubit.get(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                const SizedBox(
                  height: 24,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 50.r,
                    backgroundColor: Colors.black12,
                    backgroundImage:
                        const AssetImage(IconsPath.iconsLogo) as ImageProvider,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Center(
                  child: CustomText(
                    text: "تسجيل الدخول",
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                ),
                const SizedBox(
                  height: 52,
                ),
                CustomTextFormField(
                  mycontroller: cubit.phoneController,
                  hintText: "اسم المستخدم",
                  validator: (value) =>
                      Validate.validateFullName(value, context),
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextFormField(
                    mycontroller: cubit.passwordController,
                    hintText: "كلمة السر",
                    validator: (value) =>
                        Validate.validatePassword(value, context)),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      HelperFunctions.navigateToScreen(
                        context,
                        (context) => const SendOtpPage(),
                      );
                    },
                    child: const CustomText(
                      text: "هل نسيت كلمة المرور؟",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.appColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 38,
                ),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginFailures) {
                      log(state.error.errMassage);
                      CustomFailureDialog.show(context,
                          " فشل تسجيل الدخول. يرجى التحقق من البيانات والمحاولة مرة أخرى.");
                    } else if (state is LoginSuccess) {
                      HelperFunctions.navigateToScreen(
                        context,
                        (context) => const MainPage(),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const Center(
                        child: CustomLoading(),
                      );
                    }
                    {
                      return CustomButton(
                          width: width,
                          text: "تسجيل الدخول",
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              cubit.login();
                            }
                          },
                          colorBackGround: AppColor.appColor,
                          colorText: Colors.white,
                          colorBorder: AppColor.appColor,
                          paddingVertical: 13,
                          paddingHorizontal: 10,
                          borderRadius: 10);
                    }
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: "ليس لدي حساب",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.colorText,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        HelperFunctions.navigateToScreen(
                          context,
                          (context) => const RegisterPageView(),
                        );
                      },
                      child: const CustomText(
                        underLine: true,
                        text: "إنشاء حساب",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.appColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
