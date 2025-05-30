import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/domain/domain_models/banner.dart';
import 'package:store/domain/domain_models/section.dart';
import 'package:store/domain/domain_models/product.dart';
import 'package:store/domain/use_cases/get_products_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  // final ProductCubit productCubit;
  final GetSectionsUseCase _getSectionsUseCase;
  // final List<StreamSubscription> _subscriptions = [];
  bool _errorEmitted = false;

  HomeCubit(this._getSectionsUseCase) : super(HomeInitial());
  //  {
  //   // Listen to the productCubit state changes
  //   _subscriptions.add(
  //     productCubit.stream.listen((state) {
  //       debugPrint('ProductCubit state: ${state.toString()}');
  //       if (state is ProductLoading) {
  //         setLoading();
  //       } else if (state is ProductLoaded) {
  //         setLoaded();
  //       } else if (state is ProductError && !_errorEmitted) {
  //         _errorEmitted = true;
  //         setError(state.message);
  //       }
  //     }),
  //   );
  //   _loadHomeSections();
  // }

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
    loadHomeSections();
    // if (state is Error) {
    //   setLoading();
    //   _loadHomeSections();
    // }
  }

  Future<void> loadHomeSections() async {
    try {
      if (state is HomeLoading) {
        return;
      }
      emit(HomeLoading());
      final result = await _getSectionsUseCase.execute();
      result.where(
        onSuccess: (data) => emit(HomeLoaded(data)),
        onFailure: (error) => emit(HomeError(error.message)),
      );
    } on Exception catch (e) {
      setError('Failed to load home sections');
    }
  }

  // void reset() {
  //   emit(Initial());
  //   _loadHomeSections();
  // }

  void setLoading() {
    emit(HomeLoading());
  }

  void setError(String error) {
    emit(HomeError(error));
  }
}
