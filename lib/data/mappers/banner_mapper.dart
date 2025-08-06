import 'package:store/data/services/remote/models/ad_banner_model.dart';
import 'package:store/domain/entities/ad_banner.dart';

extension BannerMapper on AdBannerModel {
  AdBanner toEntity() {
    return AdBanner(
      imageUrl: imageUrl,
      targetId: targetId ?? '',
      title: title,
      subtitle: subtitle,
    );
  }
}
