part of 'edit_order_cubit.dart';

@immutable
sealed class EditOrderState {}

final class EditOrderInitial extends EditOrderState {}

final class EditOrderLoading extends EditOrderState {}

final class EditOrderSuccess extends EditOrderState {}

final class EditOrderFailures extends EditOrderState {
  final Failure error;

  EditOrderFailures({required this.error});
}
