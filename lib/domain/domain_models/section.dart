import 'package:flutter/cupertino.dart';

enum HOMESECTIONTYPE {
  bannerSlider,
  itemsGrid,
  horizontalItems,
  horizontalCategories,
  categoriesGrid,
}

class Section<T> {
  final HOMESECTIONTYPE type;
  final String title;
  final String? subtitle;
  final List<T> data;
  final String? backgroundColor;
  final String? textColor;
  final String? actionText;
  final String? targetId;

  Section({
    required this.type,
    required this.title,
    this.subtitle,
    required this.data,
    this.backgroundColor,
    this.textColor,
    this.actionText,
    this.targetId,
  });
  factory Section.bannerSlider(List<T> banners) => Section(
    type: HOMESECTIONTYPE.bannerSlider,
    title: 'Banner Slider',
    data: banners,
  );

  factory Section.itemsGrid(String title, List<T> items) =>
      Section(type: HOMESECTIONTYPE.itemsGrid, title: title, data: items);

  factory Section.horizontalItems(String title, List<T> items) =>
      Section(type: HOMESECTIONTYPE.horizontalItems, title: title, data: items);

  factory Section.horizontalCategories(String title, List<T> categories) =>
      Section(
        type: HOMESECTIONTYPE.horizontalCategories,
        title: title,
        data: categories,
      );

  factory Section.categoriesGrid(String title, List<T> categories) => Section(
    type: HOMESECTIONTYPE.categoriesGrid,
    title: title,
    data: categories,
  );
  factory Section.empty() =>
      Section(type: HOMESECTIONTYPE.bannerSlider, title: '', data: []);

  factory Section.loading(HOMESECTIONTYPE type, List<T> data) => Section(
    type: type,
    title: 'Loading...',
    data: data,
    backgroundColor: null,
    textColor: null,
    actionText: null,
    targetId: null,
  );
}

extension SectionEntityX on Section {
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
