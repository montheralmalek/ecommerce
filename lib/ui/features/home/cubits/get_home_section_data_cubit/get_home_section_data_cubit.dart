import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:store/core/utils/errors/exceptions.dart';
import 'package:store/domain/entities/home_section.dart';
import 'package:store/domain/use_cases/get_banners_use_case.dart';
import 'package:store/domain/use_cases/get_section_products_use_case.dart';

part 'get_home_section_data_state.dart';

class GetHomeSectionDataCubit extends Cubit<GetHomeSectionDataState> {
  final HomeSection section;
  final GetBannersUseCase _bannersUseCase;
  final GetSectionProductsUseCase _getSectionProductsUseCase;

  GetHomeSectionDataCubit({
    required this.section,
    required GetBannersUseCase bannersUseCase,
    required GetSectionProductsUseCase getSectionProductsUseCase,
  }) : _bannersUseCase = bannersUseCase,
       _getSectionProductsUseCase = getSectionProductsUseCase,
       super(GetHomeSectionDataInitial()) {
    _log.info('[${section.type.name}] CREATED');
    if (state is GetHomeSectionDataInitial) loadData();
  }

  static final Logger _log = Logger('GetHomeSectionDataCubit');
  @override
  Future<void> close() {
    _log.info('${section.type.name} DISPOSED');
    return super.close();
  }

  //Retry loading data
  void retry() {
    loadData();
    // if (state is Error) {
    //   setLoading();
    //   _loadHomeSections();
    // }
  }

  Future<void> loadData() async {
    try {
      _log.info('Start Load section data [${section.targetId}]');
      if (state is GetHomeSectionDataLoading) {
        return;
      }
      emit(GetHomeSectionDataLoading());

      _loadSectionData(section);
    } on Exception catch (e) {
      setError('Failed to load home sections data');
    }
  }

  Future<void> _loadSectionData(HomeSection section) async {
    try {
      switch (section) {
        case BannerSliderSection _:
          await _getBanners();
          break;
        case HorizontalItemsSection _:
          await _getSectionPrducts(section.targetId ?? '');
          break;
        default:
          // Handle other section types if needed
          break;
      }
    } catch (e) {
      // _updateSectionState(section, isLoading: false, hasError: true);
    }
  }

  Future<void> _getSectionPrducts(String sectionId) async {
    try {
      _log.info('Start get products of $sectionId');
      final result = await _getSectionProductsUseCase.execute(sectionId);
      result.where(
        onSuccess: (data) {
          _log.info('products of $sectionId == ${data.length}');
          emit(GetHomeSectionDataLoaded(section.copyWith(data: data)));
        },
        onFailure: (error) {
          _log.warning('Error getting products of $sectionId', error);
          emit(GetHomeSectionDataError(error.message));
        },
      );
    } on Exception catch (e) {
      setError(e.toAppException().message);
    }
  }

  Future<void> _getBanners() async {
    try {
      _log.info('Start get Banners of ${section.targetId}');
      final result = await _bannersUseCase.execute();
      //2. display home sections
      result.where(
        onSuccess: (data) {
          _log.info('Banners of ${section.targetId} == ${data.length}');
          emit(GetHomeSectionDataLoaded(section.copyWith(data: data)));
        },
        onFailure: (error) => emit(GetHomeSectionDataError(error.message)),
      );
    } on Exception catch (e) {
      setError(e.toAppException().message);
    }
  }

  void setLoading() {
    emit(GetHomeSectionDataLoading());
  }

  void setError(String error) {
    emit(GetHomeSectionDataError(error));
  }
}
