import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_store_delivery/core/assets_path/icons_path.dart';
import 'package:one_store_delivery/core/utils/order_status.dart';
import 'package:one_store_delivery/home/cubits/edit_order_cubit/edit_order_cubit.dart';
import 'package:one_store_delivery/home/cubits/home_cubit/home_cubit.dart';
import 'package:one_store_delivery/home/view/order_details_page.dart';
import 'package:one_store_delivery/models/home_response.dart';
import 'package:one_store_delivery/widgets/color.dart';
import 'package:one_store_delivery/widgets/custom_button.dart';
import 'package:one_store_delivery/widgets/custom_success_snack_bar.dart';
import 'package:one_store_delivery/widgets/custom_text.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderData order;
  final double width;
  final bool acceptable;
  final String acceptTitle, loadingAcceptTitle;
  final OrderStatus status;
  final OrderStatus getStatus;
  final String successMessage;

  const OrderItemWidget(
      {super.key,
      required this.order,
      required this.width,
      this.acceptable = true,
      required this.acceptTitle,
      required this.loadingAcceptTitle,
      required this.status,
      required this.successMessage,
      required this.getStatus});

  @override
  OrderItemWidgetState createState() => OrderItemWidgetState();
}

class OrderItemWidgetState extends State<OrderItemWidget> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  void dispose() {
    isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: "طلب جديد",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.black12,
                  backgroundImage: const AssetImage(IconsPath.iconsLogo),
                ),
              ],
            ),

            SizedBox(height: 10.h),

            // Order Info
            CustomText(
              text: "عنوان الاستلام: ${widget.order.vendor.region}",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColor.colorText,
            ),
            SizedBox(height: 5.h),
            CustomText(
              text: "عنوان التسليم: ${widget.order.region}",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColor.colorText,
            ),
            SizedBox(height: 5.h),
            CustomText(
              text: "اسم المتجر ${widget.order.vendor.user}",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColor.colorText,
            ),
            SizedBox(height: 20.h),

            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // "قبول" Button with ValueNotifier for Local Loading State
                ValueListenableBuilder<bool>(
                  valueListenable: isLoading,
                  builder: (context, loading, _) {
                    return Visibility(
                      visible: widget.acceptable,
                      child: CustomButton(
                        width:
                            loading ? widget.width * 0.4 : widget.width * 0.28,
                        text: loading
                            ? widget.loadingAcceptTitle
                            : widget.acceptTitle,
                        onPressed: loading
                            ? null
                            : () async {
                                isLoading.value = true;
                                await context
                                    .read<EditOrderCubit>()
                                    .editOrder(widget.order.id.toString(),
                                        widget.status)
                                    .then((_) {
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(
                                  //     content: Row(
                                  //       children: [
                                  //         const Icon(Icons.check_circle,
                                  //             color:
                                  //                 Colors.white), // Success Icon
                                  //         const SizedBox(width: 10),
                                  //         Expanded(
                                  //           child: Text(
                                  //             widget.successMessage,
                                  //             style: const TextStyle(
                                  //                 fontSize: 16,
                                  //                 color: Colors.white),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     backgroundColor: AppColor.green,
                                  //     behavior: SnackBarBehavior.floating,
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(10),
                                  //     ),
                                  //     duration: const Duration(seconds: 3),
                                  //   ),
                                  // );
                                  if (context.mounted) {
                                    CustomSuccessSnackBar.show(
                                        context, widget.successMessage);
                                    context.read<HomeCubit>().fetchHomeOrder(
                                        status: widget.getStatus);
                                  }
                                }).catchError((error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          const Icon(Icons.error,
                                              color:
                                                  Colors.white), // Error Icon
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              error.toString(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      duration: const Duration(seconds: 3),
                                    ),
                                  );
                                }).whenComplete(() {
                                  isLoading.value = false;
                                });
                              },
                        colorBackGround: AppColor.green,
                        colorText: Colors.white,
                        colorBorder: AppColor.green,
                        paddingVertical: 10,
                        paddingHorizontal: 10,
                        borderRadius: 10,
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 20.w,
                ),
                // "التفاصيل" Button
                CustomButton(
                  width: widget.width * 0.28,
                  text: "التفاصيل",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailsPage(
                          order: widget.order,
                        ),
                      ),
                    );
                  },
                  colorBackGround: AppColor.yellow,
                  colorText: Colors.white,
                  colorBorder: AppColor.yellow,
                  paddingVertical: 10,
                  paddingHorizontal: 10,
                  borderRadius: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
