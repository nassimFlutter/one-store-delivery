// order_history_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_store_delivery/core/utils/order_status.dart';
import 'package:one_store_delivery/home/cubits/home_cubit/home_cubit.dart';
import 'package:one_store_delivery/home/view/custom_loading.dart';
import 'package:one_store_delivery/home/view/order_item_widget.dart';
import 'package:one_store_delivery/widgets/custom_emty_screen.dart';
import 'package:one_store_delivery/widgets/custom_text.dart';
import 'package:one_store_delivery/widgets/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_error_widget.dart';

class OrderTakenPageView extends StatefulWidget {
  const OrderTakenPageView({super.key});

  @override
  State<OrderTakenPageView> createState() => _OrderTakenPageState();
}

class _OrderTakenPageState extends State<OrderTakenPageView> {
  @override
  void initState() {
    super.initState();
    context
        .read<HomeCubit>()
        .fetchHomeOrder(status: OrderStatus.deliveryAccept);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const CustomLoading();
          } else if (state is HomeError) {
            return CustomErrorWidget(
              errorMessage: state.message,
              retryCallback: () async {
                await context
                    .read<HomeCubit>()
                    .fetchHomeOrder(status: OrderStatus.deliveryAccept);
              },
            );
          } else if (state is HomeLoaded) {
            if (state.orderResponse.data.isEmpty) {
              return Center(
                child: CustomEmptyScreen(
                  onPressed: () async {
                    await context
                        .read<HomeCubit>()
                        .fetchHomeOrder(status: OrderStatus.deliveryAccept);
                  },
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.all(15.w),
              child: ListView.builder(
                itemCount: state.orderResponse.data.length,
                itemBuilder: (context, index) {
                  var order = state.orderResponse.data[index];
                  return OrderItemWidget(
                    order: order,
                    width: width,
                    acceptable: true,
                    acceptTitle: "تم التوصيل",
                    loadingAcceptTitle: "جاري التغير ...",
                    status: OrderStatus.delivered,
                    getStatus: OrderStatus.deliveryAccept,
                    successMessage: "تم التوصيل بنجاح",
                  );
                },
              ),
            );
          }
          return const Center(child: Text("لا توجد طلبات"));
        },
      ),
    );
  }
}
