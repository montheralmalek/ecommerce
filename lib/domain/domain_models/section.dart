import 'package:store/domain/domain_models/banner.dart';
import 'package:store/domain/domain_models/catgory.dart';
import 'package:store/domain/domain_models/product.dart';

///
enum HOMESECTIONTYPE {
  bannerSlider,
  itemsGrid,
  horizontalItems,
  horizontalCategories,
  categoriesGrid,
}

///
abstract class HomeSectionI<T> {
  HOMESECTIONTYPE get type;
  String? get title;
  String? get subtitle;
  List<T> get data;
  String? get backgroundColor;
  String? get textColor;
  String? get actionText;
  String? get targetId;
  const HomeSectionI();
}

///
final class BannerSliderSection implements HomeSectionI<BannerModel> {
  @override
  final List<BannerModel> data;

  const BannerSliderSection({required this.data});
  @override
  HOMESECTIONTYPE get type => HOMESECTIONTYPE.bannerSlider;
  @override
  String? get title => null;
  @override
  String? get subtitle => null;
  @override
  String? get backgroundColor => null;
  @override
  String? get textColor => null;
  @override
  String? get actionText => null;
  @override
  String? get targetId => null;
}

///
final class ItemsGridSection implements HomeSectionI<Product> {
  @override
  final String? title;
  @override
  final List<Product> data;

  ItemsGridSection({required this.title, required this.data});
  @override
  HOMESECTIONTYPE get type => HOMESECTIONTYPE.itemsGrid;
  @override
  String? get subtitle => null;
  @override
  String? get backgroundColor => null;
  @override
  String? get textColor => null;
  @override
  String? get actionText => null;
  @override
  String? get targetId => null;
}

///
final class HorizontalItemsSection implements HomeSectionI<Product> {
  @override
  final String? title;
  @override
  final List<Product> data;
  HorizontalItemsSection({required this.title, required this.data});
  @override
  HOMESECTIONTYPE get type => HOMESECTIONTYPE.horizontalItems;
  @override
  String? get subtitle => null;
  @override
  String? get backgroundColor => null;
  @override
  String? get textColor => null;
  @override
  String? get actionText => 'See All';
  @override
  String? get targetId => null;
}

///
final class HorizontalCategoriesSection implements HomeSectionI<Category> {
  @override
  final String? title;
  @override
  final List<Category> data;
  HorizontalCategoriesSection({this.title, required this.data});
  @override
  HOMESECTIONTYPE get type => HOMESECTIONTYPE.horizontalCategories;
  @override
  String? get subtitle => null;
  @override
  String? get backgroundColor => null;
  @override
  String? get textColor => null;
  @override
  String? get actionText => null;
  @override
  String? get targetId => null;
}

extension SectionEntityX<T> on HomeSectionI<T> {
  bool get isBannerSlider => type == HOMESECTIONTYPE.bannerSlider;
  bool get isProductsGrid => type == HOMESECTIONTYPE.itemsGrid;
  bool get isHorizontalProducts => type == HOMESECTIONTYPE.horizontalItems;
  bool get isHorizontalCategories =>
      type == HOMESECTIONTYPE.horizontalCategories;
  bool get isCategoriesGrid => type == HOMESECTIONTYPE.categoriesGrid;
  bool get isEmpty => data.isEmpty;
  bool get isNotEmpty => data.isNotEmpty;
  bool get hasAction => actionText != null && actionText!.isNotEmpty;
  bool get hasTargetId => targetId != null && targetId!.isNotEmpty;
}
