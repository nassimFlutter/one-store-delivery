import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_store_delivery/models/home_response.dart';
import 'package:one_store_delivery/widgets/color.dart';
import 'package:one_store_delivery/widgets/custom_button.dart';
import 'package:one_store_delivery/widgets/custom_text.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key, required this.order});
  final OrderData order;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "تفاصيل الطلب",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColor.appColor,
        ),
        backgroundColor: AppColor.grayWithOpacity,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "رقم الطلب: #${order.id.toString()}",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                  SizedBox(height: 10.h),
                  CustomText(
                    text: "عنوان الاستلام: ${order.region}",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.colorText,
                  ),
                  SizedBox(height: 5.h),
                  CustomText(
                    text: "عنوان التسليم:${order.region}",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.colorText,
                  ),
                  SizedBox(height: 5.h),
                  // const CustomText(
                  //   text: "الوقت المتوقع: 30 دقيقة",
                  //   fontSize: 16,
                  //   fontWeight: FontWeight.w400,
                  //   color: AppColor.colorText,
                  // ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            const CustomText(
              text: "تفاصيل المنتجات:",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.black,
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: ListView.builder(
                itemCount: order.items.length,
                itemBuilder: (context, index) {
                  List<Item> items = order.items;
                  Product product = items[index].product;
                  Item orderItem = items[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    child: ListTile(
                      leading: Icon(Icons.shopping_bag,
                          color: AppColor.appColor, size: 30.w),
                      title: CustomText(
                        text: "اسم المنتج :${product.title}",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                      subtitle: CustomText(
                        text: "سعر المنتج:${product.price.toString()}",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.colorText,
                      ),
                      trailing: CustomText(
                        text: "${orderItem.quantity}",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.appColor,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "الإجمالي:",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                  CustomText(
                    text: "${order.total} ل.س",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.appColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Center(
              child: CustomButton(
                width: MediaQuery.of(context).size.width * 0.8,
                text: "العودة",
                onPressed: () {
                  Navigator.pop(context);
                },
                colorBackGround: AppColor.appColor,
                colorText: Colors.white,
                colorBorder: AppColor.appColor,
                paddingVertical: 12,
                paddingHorizontal: 10,
                borderRadius: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
