import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_store_delivery/Auth/forget_password/enter_otp_page.dart';
import 'package:one_store_delivery/Auth/forget_password/send_otp_cubit/send_otp_cubit.dart';
import 'package:one_store_delivery/core/assets_path/icons_path.dart';
import 'package:one_store_delivery/core/helper_fuctions.dart';
import 'package:one_store_delivery/core/validate.dart';
import 'package:one_store_delivery/home/view/custom_loading.dart';
import 'package:one_store_delivery/widgets/color.dart';
import 'package:one_store_delivery/widgets/custom_TextFormField.dart';
import 'package:one_store_delivery/widgets/custom_button.dart';
import 'package:one_store_delivery/widgets/custom_error_dailog.dart';
import 'package:one_store_delivery/widgets/custom_success_snack_bar.dart';
import 'package:one_store_delivery/widgets/custom_text.dart';

class SendOtpPage extends StatelessWidget {
  const SendOtpPage({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    double width = MediaQuery.of(context).size.width;
    final sendOtpCubit = SendOtpCubit.get(context);
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
                    text: "إرسال رمز التحقق",
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                ),
                const SizedBox(
                  height: 52,
                ),
                CustomTextFormField(
                  mycontroller: sendOtpCubit.phoneController,
                  hintText: "رقم الهاتف",
                  validator: (value) =>
                      Validate.validatePhoneNumber(value, context),
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocConsumer<SendOtpCubit, SendOtpState>(
                  listener: (context, state) {
                    if (state is SendOtpFailure) {
                      CustomFailureDialog.show(context,
                          "فشل ارسال الرمز . يرجى التحقق من البيانات والمحاولة مرة أخرى.");
                    } else if (state is SendOtpSuccess) {
                      CustomSuccessSnackBar.show(
                          context, "تم ارسال الرمز بنجاح");
                      HelperFunctions.navigateToScreen(
                        context,
                        (context) => EnterOtpPage(
                            phoneNumber: sendOtpCubit.phoneController.text),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is SendOtpLoading) {
                      return const Center(child: CustomLoading());
                    }
                    return CustomButton(
                      width: width,
                      text: "إرسال OTP",
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await sendOtpCubit.sendOtp(context);
                        }
                      },
                      colorBackGround: AppColor.appColor,
                      colorText: Colors.white,
                      colorBorder: AppColor.appColor,
                      paddingVertical: 13,
                      paddingHorizontal: 10,
                      borderRadius: 10,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
