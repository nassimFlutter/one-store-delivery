import 'package:dartz/dartz.dart';
import 'package:one_store_delivery/core/api/api_service.dart';
import 'package:one_store_delivery/core/api/error_handler.dart';
import 'package:one_store_delivery/core/utils/service_locator.dart';

class ProfileRepo {
  Future<Either<Failure, String>> editAccountApi(
      Map<String, dynamic> data) async {
    try {
      await getIt.get<ApiService>().put(endPoint: "/api/auth/", data: data);
      return right("Edited");
    } catch (e) {
      return left(ErrorHandler.handleError(e));
    }
  }
}
