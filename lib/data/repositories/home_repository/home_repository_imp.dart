import 'package:flutter/foundation.dart';
import 'package:store/core/utils/errors/app_errors.dart';
import 'package:store/core/utils/errors/exceptions.dart';
import 'package:store/core/utils/result.dart';
import 'package:store/data/mappers/banner_mapper.dart';
import 'package:store/data/mappers/home_section_mapper.dart';
import 'package:store/data/repositories/home_repository/home_repository.dart';
import 'package:store/data/services/remote/api_service.dart';
import 'package:store/domain/entities/ad_banner.dart';
import 'package:store/domain/entities/home_section.dart';

class HomeRepositoryImp implements HomeRepository {
  final ApiService _apiService;
  const HomeRepositoryImp(this._apiService);
  @override
  Future<Result<List<HomeSection>>> getHomeSections() async {
    try {
      final result = await _apiService.getHomeSections();

      final sections = result.map((section) => section.toEntity()).toList();
      return Success(sections);
    } catch (e) {
      //TODO:
      throw UnimplementedError();
    }
  }

  @override
  Future<Result<List<AdBanner>>> getBanners() async {
    try {
      final result = await _apiService.getBanners();
      final banners = result.map((banner) => banner.toEntity()).toList();
      return Success(banners);
    } on AppException catch (e) {
      return Failure(e.toError());
    } catch (e) {
      //TODO:
      throw UnimplementedError();
    }
  }
}
