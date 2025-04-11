import 'package:flutter/material.dart';
import 'package:one_store_delivery/Auth/login/view/login_page_view.dart';
import 'package:one_store_delivery/core/assets_path/icons_path.dart';
import 'package:one_store_delivery/core/helper_fuctions.dart';
import 'package:one_store_delivery/core/text_style.dart';
import 'package:one_store_delivery/core/utils/app_keys.dart';
import 'package:one_store_delivery/core/utils/cache_helper.dart';
import 'package:one_store_delivery/profile/profile_page.dart';
import 'package:one_store_delivery/widgets/color.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header
          UserAccountsDrawerHeader(
            accountName: Text(
              CacheHelper.getData(key: AppKeys.kUserName) ?? "",
              style: AppStyles.style16w600GrayA1(context)
                  .copyWith(color: Colors.white),
            ),
            accountEmail: Text(CacheHelper.getData(key: AppKeys.kUserPhone)),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: AppColor.appColor,
              backgroundImage: AssetImage(IconsPath.deliveryBoyLogo),
            ),
            decoration: const BoxDecoration(
              color: AppColor.appColor,
            ),
          ),
          // Drawer Items
          ListTile(
            leading: const Icon(
              Icons.person,
              color: AppColor.appColor,
            ),
            title: const Text('الملف الشخصي'),
            onTap: () {
              HelperFunctions.navigateToScreen(
                context,
                (context) => const ProfilePage(),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: AppColor.appColor),
            title: const Text('تسجيل الخروج'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    titlePadding: EdgeInsets.zero,
                    title: Column(
                      children: [
                        // App Logo at the top
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Image.asset(
                            IconsPath.iconsLogo,
                            height: 60,
                            width: 60,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'تأكيد تسجيل الخروج',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColor.appColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    content: const Text(
                      'هل أنت متأكد أنك تريد تسجيل الخروج؟',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'إلغاء',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await CacheHelper.clearUserData();
                          if (context.mounted) {
                            HelperFunctions.navigateToScreenAndRemove(
                              context,
                              (context) => LoginPageView(),
                            );
                          }
                        },
                        child: const Text(
                          'تسجيل الخروج',
                          style: TextStyle(
                            color: AppColor.appColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
