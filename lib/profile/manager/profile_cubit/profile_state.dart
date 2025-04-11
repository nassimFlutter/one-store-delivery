part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {}

final class ProfileFailures extends ProfileState {
  final String errMessage;

  ProfileFailures({required this.errMessage});
}
