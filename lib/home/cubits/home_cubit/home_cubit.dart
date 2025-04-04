import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:one_store_delivery/core/api/error_handler.dart';
import 'package:one_store_delivery/core/utils/order_status.dart';
import 'package:one_store_delivery/core/utils/service_locator.dart';
import 'package:one_store_delivery/home/data/repo/home_repo.dart';
import 'package:one_store_delivery/models/home_response.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  HomeRepo repo = getIt.get<HomeRepo>();
  Future<void> fetchHomeOrder({OrderStatus? status}) async {
    emit(HomeLoading());
    Either<Failure, OrderResponse> result =
        await repo.getHomeOrder(status: status);
    result.fold(
      (failure) => emit(HomeError(message: failure.errMassage)),
      (orderResponse) => emit(HomeLoaded(orderResponse: orderResponse)),
    );
  }
}
