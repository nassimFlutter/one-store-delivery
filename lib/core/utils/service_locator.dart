import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:one_store_delivery/Auth/repo/auth_repo_impl.dart';
import 'package:one_store_delivery/core/api/api_service.dart';
import 'package:one_store_delivery/home/data/repo/home_repo.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: "https://one-store.sanoscotools.site/one-store",
      ),
    ),
  );
  getIt.registerSingleton<ApiService>(
    ApiService(
      getIt.get<Dio>(),
    ),
  );
  getIt.registerSingleton<AuthRepo>(AuthRepo());
  getIt.registerSingleton<HomeRepo>(HomeRepo());
}
