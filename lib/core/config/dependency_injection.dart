import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/core/network/dio_client.dart';
import 'package:store/core/network/network_info.dart';
import 'package:store/data/repositories/auth_repository.dart';
import 'package:store/data/repositories/auth_repository_remote.dart';
import 'package:store/data/repositories/settings_repository.dart';
import 'package:store/data/services/remote/api_client.dart';
import 'package:store/data/repositories/product_repository.dart';
import 'package:store/data/services/remote/auth_api_client.dart';
import 'package:store/data/shared_preferences_service.dart';
import 'package:store/domain/use_cases/get_products_use_case.dart';

final getIt = GetIt.instance;

/// Initializes the dependencies for the application.
/// This function registers all the necessary dependencies using the GetIt package.
Future<void> initializeDependencies() async {
  // External packages
  getIt.registerSingleton<Connectivity>(Connectivity());

  // Core
  getIt.registerFactory<DioClient>(() => DioClient(Dio()));
  getIt.registerSingleton<NetworkInfo>(NetworkInfoImpl(getIt<Connectivity>()));
  // getIt.registerSingleton<PlatformService>(
  //   Platform.isIOS ? IosService() : AndroidService(),
  // );

  // Data source Services
  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferencesService>(
    SharedPreferencesServiceImp(sharedPreferences),
  );
  getIt.registerSingleton<ApiClient>(ApiClientImpl(getIt<DioClient>()));
  // Auth API
  getIt.registerSingleton<AuthApi>(AuthApiImp(getIt<DioClient>()));

  // Repository
  getIt.registerSingleton<ProductRepository>(
    ProductRepositoryImpl(
      remoteDataSource: getIt<ApiClient>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryRemote(
      remoteAuthService: getIt<AuthApi>(),
      sharedPreferencesService: getIt<SharedPreferencesService>(),
    ),
  );
  getIt.registerSingletonAsync<SettingsRepository>(
    () => SettingsRepositoryImpl(getIt<SharedPreferencesService>()).init(),
  );
  // Use cases
  getIt.registerSingleton<GetProductsUseCase>(
    GetProductsUseCase(getIt<ProductRepository>()),
  );
  getIt.registerSingleton<GetSectionsUseCase>(
    GetSectionsUseCase(getIt<ProductRepository>()),
  );
}
