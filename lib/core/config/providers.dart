import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/config/dependency_injection.dart';
import 'package:store/data/repositories/auth_repository.dart';
import 'package:store/data/repositories/product_repository.dart';
import 'package:store/data/repositories/settings_repository.dart';
import 'package:store/domain/use_cases/get_products_use_case.dart';
import 'package:store/presentation/features/auth/cubits/auth_cubit.dart';
import 'package:store/presentation/features/product/cubits/getProductsCubit/product_cubit.dart';
import 'package:store/presentation/features/home/cubits/homeScreenCubit/home_cubit.dart';
import 'package:store/presentation/features/product/cubits/getProductByIdCubit/product_detail_cubit.dart';
import 'package:store/presentation/features/settings/cubit/settings_cubit.dart';

List<BlocProvider> providers = [
  BlocProvider<AuthCubit>(
    create: (context) => AuthCubit(authRepository: getIt<AuthRepository>()),
  ),
  BlocProvider<ProductCubit>(
    create: (context) => ProductCubit(getProducts: getIt<GetProductsUseCase>()),
  ),
  BlocProvider<HomeCubit>(
    create: (context) => HomeCubit(getIt())..loadHomeSections(),
  ),
  BlocProvider<ProductDetailCubit>(
    create:
        (context) =>
            ProductDetailCubit(productRepository: getIt<ProductRepository>()),
  ),
  BlocProvider<SettingCubit>(
    create: (context) => SettingCubit(getIt<SettingsRepository>()),
  ),
];
