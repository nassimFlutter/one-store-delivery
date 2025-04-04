import 'package:dartz/dartz.dart';
import 'package:one_store_delivery/core/api/api_service.dart';
import 'package:one_store_delivery/core/api/error_handler.dart';
import 'package:one_store_delivery/core/utils/order_status.dart';
import 'package:one_store_delivery/core/utils/service_locator.dart';
import 'package:one_store_delivery/models/home_response.dart';
import 'package:one_store_delivery/models/order_response.dart';

class HomeRepo {
  var apiService = getIt.get<ApiService>();
  Future<Either<Failure, OrderResponse>> getHomeOrder(
      {OrderStatus? status}) async {
    try {
      String endPoint = "/api/users/orders";
      if (status != null) {
        endPoint += "?status=${status.toApiString()}";
      }

      var response = await apiService.get(endPoint: endPoint);
      return right(OrderResponse.fromJson(response));
    } catch (e) {
      return left(ErrorHandler.handleError(e));
    }
  }

  Future<Either<Failure, OrderResponseModel>> editOrderApi(
      String orderId, OrderStatus status) async {
    try {
      var response = await apiService.put(
          endPoint: "/api/users/orders/$orderId",
          data: {"status": status.toApiString()});
      return right(OrderResponseModel.fromJson(response));
    } catch (e) {
      return left(ErrorHandler.handleError(e));
    }
  }
}
