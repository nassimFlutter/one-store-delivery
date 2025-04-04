import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_store_delivery/Auth/login/view/login_page_view.dart';
import 'package:one_store_delivery/Auth/register/manager/cubit/register_cubit.dart';
import 'package:one_store_delivery/core/assets_path/icons_path.dart';
import 'package:one_store_delivery/core/validate.dart';
import 'package:one_store_delivery/home/view/custom_loading.dart';
import 'package:one_store_delivery/widgets/color.dart';
import 'package:one_store_delivery/widgets/custom_TextFormField.dart';
import 'package:one_store_delivery/widgets/custom_button.dart';
import 'package:one_store_delivery/widgets/custom_error_dailog.dart';
import 'package:one_store_delivery/widgets/custom_text.dart';

class RegisterPageViewBody extends StatefulWidget {
  const RegisterPageViewBody({super.key});

  @override
  State<RegisterPageViewBody> createState() => _RegisterPageViewBodyState();
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _RegisterPageViewBodyState extends State<RegisterPageViewBody> {
  @override
  Widget build(BuildContext context) {
    RegisterCubit cubit = RegisterCubit.get(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 26.h),
        child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: const CustomText(
                      text: "انشاء حساب",
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: AppColor.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFormField(
                  mycontroller: cubit.nameController,
                  hintText: "اسم المستخدم",
                  validator: (value) =>
                      Validate.validateFullName(value, context),
                  keyboardType: TextInputType.name,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFormField(
                  mycontroller: cubit.phoneController,
                  hintText: "رقم الهاتف",
                  validator: (value) =>
                      Validate.validatePhoneNumber(value, context),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFormField(
                  mycontroller: cubit.addressController,
                  hintText: "العنوان",
                  keyboardType: TextInputType.streetAddress,
                  validator: (value) => Validate.validateFieldWithTitle(
                      value, "العنوان مطلوب", context),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFormField(
                  mycontroller: cubit.passwordController,
                  hintText: "كلمة المرور",
                  validator: (value) =>
                      Validate.validatePassword(value, context),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFormField(
                  mycontroller: cubit.passwordConfirmController,
                  hintText: "تاكيد كلمة المرور",
                  validator: (value) => Validate.validateConfirmPassword(
                      value, cubit.passwordController.text, context),
                ),
                SizedBox(
                  height: 20.h,
                ),
                BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterFailure) {
                      CustomFailureDialog.show(context, state.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is RegisterLoading) {
                      return const CustomLoading();
                    } else {
                      return CustomButton(
                          width: MediaQuery.of(context).size.width,
                          text: "انشاء حساب",
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              cubit.register();
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
                )
              ],
            )),
      ),
    );
  }
}
