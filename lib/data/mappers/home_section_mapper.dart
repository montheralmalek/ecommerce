import 'package:store/data/services/remote/models/home_section_model.dart';
import 'package:store/domain/entities/home_section.dart';

extension HomeSectionMapper on HomeSectionApiModel {
  HomeSection toEntity() {
    switch (type) {
      case HomeSectionType.bannerSlider:
        return BannerSliderSection(
          title: title,
          actionText: actionText,
          targetId: targetId,
        );
      case HomeSectionType.gridCategories:
        return HorizontalCategoriesSection(
          title: title,
          actionText: actionText,
          targetId: targetId,
        );
      case HomeSectionType.horizontalCategories:
        return HorizontalCategoriesSection(
          title: title,
          actionText: actionText,
          targetId: targetId,
        );
      case HomeSectionType.horizontalItems:
        return HorizontalItemsSection(
          title: title,
          actionText: actionText,
          targetId: targetId,
        );
      // case HOMESECTIONTYPE.itemsGrid:
      default:
        return UnknownSection();
    }
  }
}
