import 'package:flutter/cupertino.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:store/domain/entities/ad_banner.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
    required this.bannerModel,
    this.width = double.infinity,
    this.height = 200,
    this.backgroundColor,
    this.isLoading = false,
  });
  final AdBanner bannerModel;
  final double? height, width;
  final Color? backgroundColor;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        // child: Center(child: Text(bannerModel.title, style: TextStyle(fontSize: 30))),
      ),
    );
  }
}
