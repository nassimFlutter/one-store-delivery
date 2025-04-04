import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_store_delivery/Auth/repo/auth_repo_impl.dart';
import 'package:one_store_delivery/core/api/error_handler.dart';
import 'package:one_store_delivery/core/helper_fuctions.dart';
import 'package:one_store_delivery/core/utils/app_keys.dart';
import 'package:one_store_delivery/core/utils/cache_helper.dart';
import 'package:one_store_delivery/core/utils/service_locator.dart';
import 'package:one_store_delivery/models/login_response.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial()) {
    if (HelperFunctions.isInDebugMode()) {
      initializeTestLoginData();
    }
  }
  static LoginCubit get(context) => BlocProvider.of(context);

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void initializeTestLoginData() {
    passwordController.text = 'hH1234##1212';
    phoneController.text = 'user11111';
  }

  Future<void> login() async {
    emit(LoginLoading());
    Either<Failure, LoginResponse> result = await getIt
        .get<AuthRepo>()
        .login(phoneController.text, passwordController.text);
    result.fold(
      (l) {
        emit(LoginFailures(error: l));
      },
      (r) async {
        // Save token
        await CacheHelper.setData(key: AppKeys.kToken, value: r.data?.token);

        // Save user attributes separately
        User? user = r.data?.user;
        if (user != null) {
          await CacheHelper.setData(key: AppKeys.kUserId, value: user.id);
          await CacheHelper.setData(key: AppKeys.kUserName, value: user.user);
          await CacheHelper.setData(key: AppKeys.kUserPhone, value: user.phone);
          await CacheHelper.setData(
              key: AppKeys.kUserAddress, value: user.address);
          await CacheHelper.setData(
              key: AppKeys.kUserRegion, value: user.region);
          await CacheHelper.setData(key: AppKeys.kUserRole, value: user.role);
          await CacheHelper.setData(
              key: AppKeys.kUserStatus, value: user.status);
          await CacheHelper.setData(key: AppKeys.kUserLat, value: user.lat);
          await CacheHelper.setData(key: AppKeys.kUserLon, value: user.lon);
          await CacheHelper.setData(
              key: AppKeys.kUserIsVerified, value: user.isVerified);
          await CacheHelper.setData(
              key: AppKeys.kUserCreatedAt, value: user.createdAt);
          await CacheHelper.setData(
              key: AppKeys.kUserUpdatedAt, value: user.updatedAt);
        }

        emit(LoginSuccess(loginData: r));
      },
    );
  }
}
