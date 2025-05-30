abstract final class AppRoutes {
  static const String initial = home;
  static const String splash = '/splash';
  static const String onBoarding = '/onboarding';
  static const String login = '/login';
  static const String home = '/home';
  static const String productDetails = '/product';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String profile = '/profile';
  static const String categories = '/categories';
  static const String categoryProducts = '/category-products';
  static const String search = '/search';
  static const String settings = '/settings';
  static const String about = '/about';
  static const String contactUs = '/contact-us';
  static const String termsAndConditions = '/terms-and-conditions';
  static const String privacyPolicy = '/privacy-policy';
  static const String notFound = '/not-found';
  static const String language = '/language';
  static const String notifications = '/notifications';
  static const String faq = '/faq';
  static const String support = '/support';
  static const String wishlist = '/wishlist';
  static const String orderHistory = '/order-history';
  static const String orderDetails = '/order-details';
  // static String productDetailsWithId(int id) => '/$productDetailsRelative/$id';

  // Returns all the routes as a list
  static List<String> get allRoutes => [
    initial,
    splash,
    onBoarding,
    login,
    home,
    productDetails,
    cart,
    checkout,
    profile,
    categories,
    categoryProducts,
    search,
    settings,
    about,
    contactUs,
    termsAndConditions,
    privacyPolicy,
    notFound,
    language,
    notifications,
    faq,
    support,
    wishlist,
    orderHistory,
    orderDetails,
  ];
}
