import 'package:get/get.dart';
import 'package:store/main.dart';

List<GetPage<dynamic>> pagesRoutes = [
  //--------------------- Auth Pages ---------------------
  // GetPage(
  //     name: '/',
  //     page: () => const LoginScreen(),
  //     middlewares: [AppMiddleware()]),

  //--------------------- Home Page ---------------------
  GetPage(name: '/', page: () => const MyHomePage()),

  // //--------------------- Items Pages ---------------------
  // GetPage(name: ItemsScreen.id, page: () => const ItemsScreen()),
  // GetPage(name: AddItemScreen.id, page: () => const AddItemScreen()),
  // GetPage(name: ItemDetailScreen.id, page: () => const ItemDetailScreen()),

  // //--------------------- Categories Pages ---------------------
  // GetPage(
  //   name: CategoriesScreen.id,
  //   page: () => const CategoriesScreen(),
  //   binding: CategoryBinding(),
  // ),
  // GetPage(
  //   name: AddCategoryScreen.id,
  //   page: () => const AddCategoryScreen(),
  //   binding: CategoryBinding(),
  // ),

  // //--------------------- Units Pages ---------------------
  // GetPage(
  //   name: UnitsScreen.id,
  //   page: () => const UnitsScreen(),
  //   binding: UnitsBindings(),
  // ),
  // GetPage(
  //   name: AddUnitScreen.id,
  //   page: () => const AddUnitScreen(),
  //   title: 'Add Unit',
  //   fullscreenDialog: true,
  //   alignment: Alignment.center,
  // ),
  // GetPage(name: UpdateUnitScreen.id, page: () => const UpdateUnitScreen()),

  // //--------------------- Currencies Pages ---------------------
  // GetPage(name: CurrenciesScreen.id, page: () => const CurrenciesScreen()),
];
