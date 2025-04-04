import 'package:dartz/dartz.dart';
import 'package:one_store_delivery/core/api/api_service.dart';
import 'package:one_store_delivery/core/api/error_handler.dart';
import 'package:one_store_delivery/core/utils/service_locator.dart';
import 'package:one_store_delivery/models/login_response.dart';

class AuthRepo {
  ApiService apiMethod = getIt.get<ApiService>();
  Future<Either<Failure, LoginResponse>> login(
      String user, String password) async {
    try {
      var response = await apiMethod.post(
          endPoint: "/api/auth/login",
          isLogin: true,
          data: {"user": user, "password": password});
      return right(LoginResponse.fromJson(response));
    } catch (e) {
      return left(ErrorHandler.handleError(e));
    }
  }

  Future<Either<Failure, String>> sendOtp(String phone) async {
    try {
      await apiMethod.post(
          endPoint: "/api/auth/otp", isLogin: true, data: {"phone": phone});
      return right("Send");
    } catch (e) {
      return left(ErrorHandler.handleError(e));
    }
  }

  Future<Either<Failure, String>> forgetPassword(
    String phone,
    String password,
    String confirmPassword,
    String otp,
  ) async {
    try {
      await apiMethod.put(endPoint: "/api/auth/forget-password", data: {
        "phone": phone,
        "otp": otp,
        "password": password,
        "confirmPassword": confirmPassword
      });
      return right("Ok");
    } catch (e) {
      return left(ErrorHandler.handleError(e));
    }
  }

  Future<Either<Failure, String>> register(
      String user,
      String password,
      String address,
      String phone,
      String confirmPassword,
      String lat,
      String lon) async {
    try {
      var response = await apiMethod
          .post(endPoint: "/api/auth/register", isLogin: true, data: {
        "user": user,
        "phone": phone,
        "address": address,
        "confirm_password": confirmPassword,
        "password": password,
        "lat": lat,
        "lon": lon,
        "role": 4
      });
      return right("Success");
    } catch (e) {
      return left(ErrorHandler.handleError(e));
    }
  }
}
// {
//     "user": "dele1",
//     "password": "hH1234##1212"
// }