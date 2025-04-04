import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:one_store_delivery/core/api/error_handler.dart';
import 'package:one_store_delivery/core/utils/order_status.dart';
import 'package:one_store_delivery/core/utils/service_locator.dart';
import 'package:one_store_delivery/home/data/repo/home_repo.dart';
import 'package:one_store_delivery/models/order_response.dart';

part 'edit_order_state.dart';

class EditOrderCubit extends Cubit<EditOrderState> {
  EditOrderCubit() : super(EditOrderInitial());
  HomeRepo repo = getIt.get<HomeRepo>();
  Future<void> editOrder(String orderId, OrderStatus status) async {
    emit(EditOrderLoading());
    Either<Failure, OrderResponseModel> result =
        await repo.editOrderApi(orderId, status);
    result.fold(
      (error) {
        emit(EditOrderFailures(error: error));
      },
      (success) {
        emit(EditOrderSuccess());
      },
    );
  }
}
