import 'package:flutter/cupertino.dart';

enum HOMESECTIONTYPE {
  bannerSlider,
  itemsGrid,
  horizontalItems,
  horizontalCategories,
  categoriesGrid,
}

class HomeSectionEntity {
  final HOMESECTIONTYPE type;
  final String title;
  final String? subtitle;
  final List<dynamic> data;
  final String? backgroundColor;
  final String? textColor;
  final String? actionText;
  final String? targetId;

  HomeSectionEntity({
    required this.type,
    required this.title,
    this.subtitle,
    required this.data,
    this.backgroundColor,
    this.textColor,
    this.actionText,
    this.targetId,
  });
}

extension HomeSectionEntityX on HomeSectionEntity {
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
