import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:one_store_delivery/Auth/repo/auth_repo_impl.dart';
import 'package:one_store_delivery/core/api/error_handler.dart';
import 'package:one_store_delivery/core/utils/service_locator.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
// void getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled, do nothing.

//       locationMessage = "Location services are disabled.";

//       return;
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, do nothing.
//         locationMessage = "Location permissions are denied.";

//         return;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, do nothing.
//       locationMessage = "Location permissions are permanently denied.";

//       return;
//     }

//     position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     locationMessage =
//         "Latitude: ${position?.latitude}, Longitude: ${position?.longitude}";
//   }

  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController datePicker = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  Future<void> register() async {
    emit(RegisterLoading());

    final Either<Failure, String> result = await getIt.get<AuthRepo>().register(
          nameController.text,
          passwordController.text,
          addressController.text,
          phoneController.text,
          passwordConfirmController.text,
          "30",
          "30",
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