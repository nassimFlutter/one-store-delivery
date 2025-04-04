import 'package:flutter/material.dart';
import 'package:one_store_delivery/home/view/order_details_page.dart';
import 'package:one_store_delivery/widgets/color.dart';
import 'package:one_store_delivery/widgets/custom_button.dart';
import 'package:one_store_delivery/widgets/custom_text.dart';

class OrderTakenView extends StatefulWidget {
  const OrderTakenView({super.key});

  @override
  _OrderTakenViewState createState() => _OrderTakenViewState();
}

class _OrderTakenViewState extends State<OrderTakenView> {
  // Define the possible order states
  List<String> orderStates = [
    "Pending",
    "In Progress",
    "Completed",
    "Cancelled"
  ];
  String currentState = "Pending"; // Initial state of the order

  // Function to handle changing the order state
  void changeOrderState() {
    setState(() {
      // Cycle through the order states
      int currentIndex = orderStates.indexOf(currentState);
      currentState = orderStates[(currentIndex + 1) % orderStates.length];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const CustomText(
          text: "سجل الطلبات",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColor.appColor,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: 10, // Example number of orders in history
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "طلب رقم #12345",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.black,
                    ),
                    const SizedBox(height: 10),
                    const CustomText(
                      text: "عنوان الاستلام: شارع الملك فهد",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.colorText,
                    ),
                    const SizedBox(height: 5),
                    const CustomText(
                      text: "عنوان التسليم: شارع التحلية",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.colorText,
                    ),
                    const SizedBox(height: 10),

                    // Show the current order state
                    CustomText(
                      text:
                          "الحالة الحالية: $currentState", // Display the current state
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.colorText,
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: "عرض التفاصيل",
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => OrderDetailsPage(),
                              //   ),
                              // );
                            },
                            colorBackGround: AppColor.yellow,
                            colorText: Colors.white,
                            colorBorder: AppColor.yellow,
                            paddingVertical: 10,
                            paddingHorizontal: 10,
                            borderRadius: 10,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomButton(
                            width: 200,
                            text: "تغير الحالة",
                            onPressed:
                                changeOrderState, // Change order state when pressed
                            colorBackGround: AppColor.iconGrey,
                            colorText: Colors.white,
                            colorBorder: AppColor.iconGrey,
                            paddingVertical: 10,
                            paddingHorizontal: 10,
                            borderRadius: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
