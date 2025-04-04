part of 'send_otp_cubit.dart';

@immutable
sealed class SendOtpState {}

final class SendOtpInitial extends SendOtpState {}

final class SendOtpLoading extends SendOtpState {}

final class SendOtpSuccess extends SendOtpState {
  final String message;

  SendOtpSuccess({required this.message});
}

final class SendOtpFailure extends SendOtpState {
  final String errormessage;

  SendOtpFailure({required this.errormessage});
}
