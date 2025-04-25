import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_store_delivery/core/utils/order_status.dart';
import 'package:one_store_delivery/home/cubits/home_cubit/home_cubit.dart';
import 'package:one_store_delivery/home/view/custom_error_widget.dart';
import 'package:one_store_delivery/home/view/custom_loading.dart';
import 'package:one_store_delivery/home/view/order_item_widget.dart';

import 'package:one_store_delivery/widgets/custom_emty_screen.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchHomeOrder(status: OrderStatus.delivered);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HomeLoading) {
            return const CustomLoadingAnimate();
          } else if (state is HomeError) {
            return CustomErrorWidget(
              errorMessage: state.message,
              retryCallback: () async {
                await context
                    .read<HomeCubit>()
                    .fetchHomeOrder(status: OrderStatus.delivered);
              },
            );
          } else if (state is HomeLoaded) {
            if (state.orderResponse.data.isEmpty) {
              return Center(
                child: CustomEmptyScreen(
                  onPressed: () async {
                    await context
                        .read<HomeCubit>()
                        .fetchHomeOrder(status: OrderStatus.delivered);
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
                    acceptable: false,
                    acceptTitle: "تم التوصيل",
                    loadingAcceptTitle: "جاري التغير ...",
                    status: OrderStatus.delivered,
                    getStatus: OrderStatus.delivered,
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
