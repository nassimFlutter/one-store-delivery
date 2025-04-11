import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_store_delivery/core/api/error_handler.dart';
import 'package:one_store_delivery/core/utils/app_keys.dart';
import 'package:one_store_delivery/core/utils/cache_helper.dart';
import 'package:one_store_delivery/core/utils/service_locator.dart';
import 'package:one_store_delivery/profile/data/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);
  //! controllers
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  void initTextController() {
    phoneController.text = CacheHelper.getData(key: AppKeys.kUserPhone);
    nameController.text = CacheHelper.getData(key: AppKeys.kUserName);
  }

  Map<String, dynamic> sendData() {
    return {"user": nameController.text, "phone": phoneController.text};
  }

  Future<void> editAccount() async {
    emit(ProfileLoading());
    Either<Failure, String> result =
        await getIt.get<ProfileRepo>().editAccountApi(sendData());
    result.fold(
      (error) {
        emit(ProfileFailures(errMessage: error.errMassage));
      },
      (success) {
        emit(ProfileSuccess());
      },
    );
  }
}
