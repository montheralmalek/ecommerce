import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:store/core/network/api_request.dart';
import 'package:store/core/network/network_info.dart';
import 'package:store/data/data_sources/product_remote_data_source.dart';
import 'package:store/data/repositories/product_repository.dart';
import 'package:store/domain/use_cases/get_products_use_case.dart';
import 'package:store/presentation/cubits/product_cubit.dart';
import 'package:store/presentation/viewmodels/product_view_model.dart';

final getIt = GetIt.instance;

/// Initializes the dependencies for the application.
/// This function registers all the necessary dependencies using the GetIt package.
Future<void> initializeDependencies() async {
  // External packages
  getIt.registerSingleton<Connectivity>(Connectivity());

  // Core
  getIt.registerSingleton<ApiRequest>(ApiRequest());
  getIt.registerSingleton<NetworkInfo>(NetworkInfoImpl(getIt<Connectivity>()));

  // Initialize Hive
  // final appDocumentDirectory = await getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDirectory.path);
  // Hive.registerAdapter(ProductModelAdapter());
  // final productBox = await Hive.openBox<ProductModel>('products');
  // getIt.registerSingleton<Box<ProductModel>>(productBox);

  // Data sources
  getIt.registerSingleton<ProductRemoteDataSource>(
    ProductRemoteDataSourceImpl(getIt<ApiRequest>()),
  );
  // getIt.registerSingleton<ProductLocalDataSource>(
  //   ProductLocalDataSourceImpl(box: getIt<Box<ProductModel>>()),
  // );

  // Repository
  getIt.registerSingleton<ProductRepository>(
    ProductRepositoryImpl(
      remoteDataSource: getIt<ProductRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  // Use cases
  getIt.registerSingleton<GetProductsUseCase>(
    GetProductsUseCase(getIt<ProductRepository>()),
  );

  // Cubits
  getIt.registerFactory<ProductCubit>(
    () => ProductCubit(getProducts: getIt<GetProductsUseCase>()),
  );

  // view models

  getIt.registerLazySingleton<ProductViewModel>(
    () => ProductViewModel(productCubit: getIt<ProductCubit>()),
  );
}
