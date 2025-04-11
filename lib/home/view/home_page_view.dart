import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:one_store_delivery/core/assets_path/icons_path.dart';
import 'package:one_store_delivery/core/utils/order_status.dart';

import 'package:one_store_delivery/home/cubits/home_cubit/home_cubit.dart';
import 'package:one_store_delivery/widgets/color.dart';
import 'package:one_store_delivery/widgets/custom_emty_screen.dart';
import 'package:one_store_delivery/widgets/custom_text.dart';
import 'custom_error_widget.dart';
import 'custom_loading.dart';
import 'order_item_widget.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  HomePageViewState createState() => HomePageViewState();
}

class HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchHomeOrder(status: OrderStatus.vendorAccept);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: AppColor.appColor,
        onRefresh: () async {
          context
              .read<HomeCubit>()
              .fetchHomeOrder(status: OrderStatus.vendorAccept);
        },
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const CustomLoading();
            } else if (state is HomeError) {
              return CustomErrorWidget(
                errorMessage: state.message,
                retryCallback: () async {
                  await context
                      .read<HomeCubit>()
                      .fetchHomeOrder(status: OrderStatus.vendorAccept);
                },
              );
            } else if (state is HomeLoaded) {
              if (state.orderResponse.data.isEmpty) {
                return CustomEmptyScreen(
                  onPressed: () async {
                    await context
                        .read<HomeCubit>()
                        .fetchHomeOrder(status: OrderStatus.vendorAccept);
                  },
                );
              } else {
                return Padding(
                  padding: EdgeInsets.all(15.w),
                  child: ListView.builder(
                    itemCount: state.orderResponse.data.length,
                    itemBuilder: (context, index) {
                      var order = state.orderResponse.data[index];
                      return OrderItemWidget(
                        order: order,
                        width: width,
                        acceptTitle: "قبول",
                        loadingAcceptTitle: "جاري القبول ...",
                        status: OrderStatus.deliveryAccept,
                        successMessage: "تم قبول الطلب بنجاح!",
                        getStatus: OrderStatus.vendorAccept,
                      );
                    },
                  ),
                );
              }
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
