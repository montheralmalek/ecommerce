import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/domain/entities/ad_banner.dart';
import 'package:store/domain/entities/home_section.dart';
import 'package:store/domain/entities/product/product.dart';
import 'package:store/domain/use_cases/get_home_sections_use_case.dart';
import 'package:store/domain/use_cases/get_section_products_use_case.dart';

part 'home_section_state.dart';

class HomeCubit extends Cubit<HomeSectionState> {
  // final ProductCubit productCubit;
  final GetHomeSectionsUseCase _getSectionsUseCase;
  final GetSectionProductsUseCase _getSectionProductsUseCase;

  bool _errorEmitted = false;

  HomeCubit(this._getSectionsUseCase, this._getSectionProductsUseCase)
    : super(HomeSectionInitial());

  bool get errorEmitted => _errorEmitted;
  // Dispose of the subscriptions when the cubit is closed
  @override
  Future<void> close() {
    // for (final subscription in _subscriptions) {
    //   subscription.cancel();
    // }

    return super.close();
  }

  //Retry loading data
  void retry() {
    _errorEmitted = false;
    emit(HomeSectionInitial());
    // loadHomeSections();
    // if (state is Error) {
    //   setLoading();
    //   _loadHomeSections();
    // }
  }

  Future<void> loadHomeSections() async {
    try {
      if (state is HomeSectionLoading) {
        return;
      }
      emit(HomeSectionLoading());
      //1. fetch home sections
      final result = await _getSectionsUseCase.execute();
      //2. display home sections
      result.where(
        onSuccess: (data) {
          emit(HomeSectionLoaded(data));
        },
        onFailure: (error) => emit(HomeSectionError(error.message)),
      );
    } on Exception catch (e) {
      setError('Failed to load home sections');
    }
  }

  // void _updateSectionWithData(HomeSection section, dynamic data) {
  //   if (state is HomeSectionsLoaded) {
  //     final currentState = state as HomeSectionsLoaded;

  //     final updatedSections =
  //         currentState.sections.map((s) {
  //           if (s.type == section.type) {
  //             // return _createUpdatedSection(s, data);
  //           }
  //           return s;
  //         }).toList();

  //     emit(currentState.copyWith(sections: updatedSections));
  //   }
  // }

  // HomeSection _createUpdatedSection(HomeSection section, dynamic data) {
  //   switch (section.type) {
  //     case 'bannerSlider':
  //       return BannerSliderSection(banners: data);
  //     case 'itemsGrid':
  //       return ItemsGridSection(products: data);
  //     // ... [بقية الأنواع] ...
  //     default:
  //       return section;
  //   }
  // }
  // void reset() {
  //   emit(Initial());
  //   _loadHomeSections();
  // }

  void setLoading() {
    emit(HomeSectionLoading());
  }

  void setError(String error) {
    emit(HomeSectionError(error));
  }
}
