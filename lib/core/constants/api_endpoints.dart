abstract final class ApiEndpoints {
  static const String _reactBaseurl =
      'https://fakestoreapiserver.reactbd.org/api';
  // static const String _fakestoreBaseUrl = 'https://fakestoreapi.com';
  static const String baseUrl = _reactBaseurl;

  // Auth endpoints
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';
  static const String logout = '$baseUrl/auth/logout';

  // User endpoints
  static const String getUserProfile = '$baseUrl/user/profile';
  static const String updateUserProfile = '$baseUrl/user/update';

  // Product endpoints
  static const String getProducts = '$baseUrl/products';
  static String getProductById(String id) => '$baseUrl/products/$id';
  static const String getCategories = '$baseUrl/products/category';
  static String getProductsByCategory(String catgory) =>
      '$baseUrl/products/category?type=$catgory';
  //  static const String getProductsBySection = '$baseUrl/products/section/';
  // static const String getProductByBanner = '$baseUrl/products/banner/';

  // Order endpoints
  static const String createOrder = '$baseUrl/orders/create';
  static const String getOrders = '$baseUrl/orders';
}
