import 'package:store/core/utils/result.dart';
import 'package:store/data/repositories/home_repository/home_repository.dart';
import 'package:store/domain/entities/home_section.dart';

class GetHomeSectionsUseCase {
  final HomeRepository _repository;

  GetHomeSectionsUseCase(this._repository);

  Future<Result<List<HomeSection>>> execute() async =>
      await _repository.getHomeSections();
}
