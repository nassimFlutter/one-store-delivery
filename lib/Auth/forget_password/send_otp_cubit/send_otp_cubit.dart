import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_store_delivery/Auth/repo/auth_repo_impl.dart';
import 'package:one_store_delivery/core/api/error_handler.dart';
import 'package:one_store_delivery/core/utils/service_locator.dart';

part 'send_otp_state.dart';

class SendOtpCubit extends Cubit<SendOtpState> {
  SendOtpCubit() : super(SendOtpInitial());
  static SendOtpCubit get(context) => BlocProvider.of(context);
  final TextEditingController phoneController = TextEditingController();
  Future<void> sendOtp(context) async {
    emit(SendOtpLoading());
    Either<Failure, String> response =
        await getIt.get<AuthRepo>().sendOtp(phoneController.text);

    response.fold(
      (failure) => emit(SendOtpFailure(errormessage: failure.errMassage)),
      (message) => emit(SendOtpSuccess(message: message)),
    );
  }
}
