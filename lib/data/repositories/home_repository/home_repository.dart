import 'package:store/core/utils/result.dart';
import 'package:store/domain/entities/ad_banner.dart';
import 'package:store/domain/entities/home_section.dart';

abstract class HomeRepository {
  Future<Result<List<HomeSection>>> getHomeSections();
  Future<Result<List<AdBanner>>> getBanners();
}
