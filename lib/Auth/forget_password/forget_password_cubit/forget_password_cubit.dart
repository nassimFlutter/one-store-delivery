import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:one_store_delivery/Auth/repo/auth_repo_impl.dart';
import 'package:one_store_delivery/core/api/error_handler.dart';
import 'package:one_store_delivery/core/utils/service_locator.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  static ForgetPasswordCubit get(context) => BlocProvider.of(context);
  Future<void> forgetPassword(
    String phone,
  ) async {
    emit(ForgetPasswordLoading());
    Either<Failure, String> result = await getIt.get<AuthRepo>().forgetPassword(
        phone,
        passwordController.text,
        confirmPasswordController.text,
        otpController.text);

    result.fold(
      (l) {
        emit(ForgetPasswordFailures(errorMessage: l.errMassage));
      },
      (r) {
        emit(ForgetPasswordSuccess());
      },
    );
  }
}
