import 'package:store/core/utils/result.dart';
import 'package:store/data/repositories/home_repository/home_repository.dart';
import 'package:store/domain/entities/ad_banner.dart';

class GetBannersUseCase {
  final HomeRepository _repository;

  GetBannersUseCase(this._repository);

  Future<Result<List<AdBanner>>> execute() async =>
      await _repository.getBanners();
}
