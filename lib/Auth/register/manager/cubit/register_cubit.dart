import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:one_store_delivery/Auth/repo/auth_repo_impl.dart';
import 'package:one_store_delivery/core/api/error_handler.dart';
import 'package:one_store_delivery/core/helper_fuctions.dart';
import 'package:one_store_delivery/core/utils/service_locator.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial()) {
    if (HelperFunctions.isInDebugMode()) {
      initializeTestRegisterData();
    }
  }
  static RegisterCubit get(context) => BlocProvider.of(context);

  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  double? lat;
  double? lon;
  void initializeTestRegisterData() {
    phoneController.text = '0997007017';
    passwordController.text = '123123123';
    addressController.text = "Test";
    passwordController.text = "xxxxxxxx";
    passwordConfirmController.text = "xxxxxxxx";
  }

  Future<Position?> getUserLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("الرجاء تفعيل خدمة الموقع")),
      );
      return null;
    }

    // Request permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تم رفض صلاحية الموقع")),
        );
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("صلاحية الموقع مرفوضة نهائيًا")),
      );
      return null;
    }

    // Get current location
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> register() async {
    emit(RegisterLoading());

    final Either<Failure, String> result = await getIt.get<AuthRepo>().register(
          nameController.text,
          passwordController.text,
          addressController.text,
          phoneController.text,
          passwordConfirmController.text,
          lat.toString(),
          lon.toString(),
        );

    result.fold(
      (failure) {
        String errorMessage = failure.errMassage;
        if (failure.errMassage == "users.phone Is Already Used.") {
          errorMessage = "رقم الهاتف مستخدم سابقا";

          emit(RegisterFailure(error: errorMessage));
        } else if (failure.errMassage == "users.user Is Already Used.") {
          errorMessage = 'اسم المستخدم موجود بلفعل';
          emit(RegisterFailure(error: errorMessage));
        } else {
          emit(RegisterFailure(error: errorMessage));
        }
      },
      (response) => emit(RegisterSuccess()),
    );
  }
}
// (failure) => emit(RegisterFailure(error: failure.errMassage))