abstract final class AppAssets {
  const AppAssets();
}

abstract final class ImageAssets {
  static const String _root = 'assets/images';
  static const String chooseProductImg = '$_root/choose_product.png';
  static const String easySavePaymentImg = '$_root/easy_save_payment.png';
  static const String trackOrderImg = '$_root/track_your_order.png';
  static const String fastDeliveryImg = '$_root/fast_delivery.png';
  static const String loginLogo = '$_root/login_logo.png';
  static const String signUpLogo = '$_root/signup_logo.png';
  static const String fingerprint = '$_root/fingerprint.png';
}

abstract final class JsonAssets {
  static const String _root = 'assets/json';
  static const homeSections = '$_root/home_sections.json';
  static const banner = '$_root/banner.json';
}
