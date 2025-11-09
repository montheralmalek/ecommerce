import 'package:store/domain/entities/ad_banner.dart';
import 'package:store/domain/entities/catgory.dart';
import 'package:store/domain/entities/product/product.dart';

///
enum HomeSectionType {
  bannerSlider,
  gridItems,
  horizontalItems,
  horizontalCategories,
  gridCategories,
  unknown;

  static HomeSectionType getByName(String name) {
    return HomeSectionType.values.firstWhere(
      (e) => e.name == name,
      orElse: () => HomeSectionType.unknown,
    );
  }
}

///
abstract class HomeSection<T> {
  HomeSectionType get type;
  final String? title;
  final String? subtitle;
  final String? actionText;
  final String? targetId;
  const HomeSection({
    this.title,
    this.actionText,
    this.subtitle,
    this.targetId,
  });
  List<T>? get data;

  HomeSection<T> copyWith({
    String? title,
    String? subtitle,
    String? actionText,
    String? targetId,
    List<T>? data,
  });
}

///
class BannerSliderSection implements HomeSection<AdBanner> {
  @override
  final List<AdBanner>? data;
  @override
  HomeSectionType get type => HomeSectionType.bannerSlider;

  @override
  final String? title;
  @override
  final String? subtitle;
  @override
  final String? actionText;
  @override
  final String? targetId;

  BannerSliderSection({
    this.title,
    this.subtitle,
    this.actionText,
    this.targetId,

    this.data,
  });

  @override
  HomeSection<AdBanner> copyWith({
    String? title,
    String? subtitle,
    String? actionText,
    String? targetId,

    List<AdBanner>? data,
  }) {
    return BannerSliderSection(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      actionText: actionText ?? this.actionText,
      targetId: targetId ?? this.targetId,

      data: data ?? this.data,
    );
  }
}

///
final class ItemsGridSection implements HomeSection<Product> {
  @override
  final List<Product>? data;
  @override
  HomeSectionType get type => HomeSectionType.gridItems;

  @override
  final String? title;
  @override
  final String? subtitle;
  @override
  final String? actionText;
  @override
  final String? targetId;

  ItemsGridSection({
    this.title,
    this.subtitle,
    this.actionText,
    this.targetId,

    this.data,
  });

  @override
  HomeSection<Product> copyWith({
    String? title,
    String? subtitle,
    String? actionText,
    String? targetId,

    List<Product>? data,
  }) {
    return ItemsGridSection(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      actionText: actionText ?? this.actionText,
      targetId: targetId ?? this.targetId,

      data: data ?? this.data,
    );
  }
}

///
final class HorizontalItemsSection implements HomeSection<Product> {
  @override
  final List<Product>? data;
  @override
  HomeSectionType get type => HomeSectionType.horizontalItems;

  @override
  final String? title;
  @override
  final String? subtitle;
  @override
  final String? actionText;
  @override
  final String? targetId;

  HorizontalItemsSection({
    this.title,
    this.subtitle,
    this.actionText,
    this.targetId,
    this.data,
  });

  @override
  HomeSection<Product> copyWith({
    String? title,
    String? subtitle,
    String? actionText,
    String? targetId,

    List<Product>? data,
  }) {
    return HorizontalItemsSection(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      actionText: actionText ?? this.actionText,
      targetId: targetId ?? this.targetId,
      data: data ?? this.data,
    );
  }
}

///
final class HorizontalCategoriesSection implements HomeSection<Category> {
  @override
  final List<Category>? data;
  @override
  HomeSectionType get type => HomeSectionType.horizontalCategories;

  @override
  final String? title;
  @override
  final String? subtitle;
  @override
  final String? actionText;
  @override
  final String? targetId;

  HorizontalCategoriesSection({
    this.title,
    this.subtitle,
    this.actionText,
    this.targetId,

    this.data,
  });

  @override
  HomeSection<Category> copyWith({
    String? title,
    String? subtitle,
    String? actionText,
    String? targetId,

    List<Category>? data,
  }) {
    return HorizontalCategoriesSection(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      actionText: actionText ?? this.actionText,
      targetId: targetId ?? this.targetId,

      data: data ?? this.data,
    );
  }
}

///--------
final class UnknownSection<T> implements HomeSection<T> {
  @override
  List<T>? get data => null;

  @override
  HomeSectionType get type => HomeSectionType.unknown;

  @override
  String? get title => null;

  @override
  String? get subtitle => null;

  @override
  String? get actionText => null;

  @override
  String? get targetId => null;

  const UnknownSection();

  @override
  HomeSection<T> copyWith({
    String? title,
    String? subtitle,
    String? actionText,
    String? targetId,

    List<T>? data,
  }) {
    return UnknownSection<T>();
  }
}

extension SectionEntityX<T> on HomeSection<T> {
  bool get isBannerSlider => type == HomeSectionType.bannerSlider;
  bool get isProductsGrid => type == HomeSectionType.gridItems;
  bool get isHorizontalProducts => type == HomeSectionType.horizontalItems;
  bool get isHorizontalCategories =>
      type == HomeSectionType.horizontalCategories;
  bool get isCategoriesGrid => type == HomeSectionType.gridCategories;
  bool get isEmpty => data?.isEmpty ?? true;
  bool get hasData => data?.isNotEmpty ?? false;
  bool get hasAction => actionText != null && actionText!.isNotEmpty;
  bool get hasTargetId => targetId != null && targetId!.isNotEmpty;
}
