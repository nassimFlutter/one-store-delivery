import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_store_delivery/core/assets_path/icons_path.dart';
import 'package:one_store_delivery/core/validate.dart';
import 'package:one_store_delivery/home/view/custom_loading.dart';
import 'package:one_store_delivery/profile/manager/profile_cubit/profile_cubit.dart';
import 'package:one_store_delivery/widgets/color.dart';
import 'package:one_store_delivery/widgets/custom_TextFormField.dart';
import 'package:one_store_delivery/widgets/custom_button.dart';
import 'package:one_store_delivery/widgets/custom_error_dailog.dart';
import 'package:one_store_delivery/widgets/custom_success_snack_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // <-- Step 1

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).initTextController();
  }

  @override
  Widget build(BuildContext context) {
    ProfileCubit cubit = ProfileCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("الملف الشخصي"),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // <-- Step 2
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: CircleAvatar(
                  backgroundColor: AppColor.appColor,
                  radius: 50,
                  backgroundImage: AssetImage(IconsPath.deliveryBoyLogo),
                ),
              ),
              const SizedBox(height: 30),
              CustomTextFormField(
                mycontroller: cubit.nameController,
                keyboardType: TextInputType.name,
                hintText: "اسم المستخدم",
                validator: (value) => Validate.validateFullName(value, context),
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                mycontroller: cubit.phoneController,
                keyboardType: TextInputType.phone,
                hintText: "رقم الهاتف",
                validator: (value) =>
                    Validate.validatePhoneNumber(value, context),
              ),
              const SizedBox(height: 30),
              BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is ProfileFailures) {
                    CustomFailureDialog.show(context,
                        "خطا في تعديل ملفك الشخصي ${state.errMessage}");
                  } else if (state is ProfileSuccess) {
                    CustomSuccessSnackBar.show(
                        context, "تم تعديل ملفك الشخصي بنجاح");
                  }
                },
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(
                      child: CustomLoading(),
                    );
                  }
                  {
                    return CustomButton(
                      text: "تعديل الحساب",
                      colorBackGround: AppColor.appColor,
                      colorText: Colors.white,
                      colorBorder: AppColor.appColor,
                      paddingVertical: 13,
                      paddingHorizontal: 10,
                      borderRadius: 10,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          cubit.editAccount();
                        }
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
