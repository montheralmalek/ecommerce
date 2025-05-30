part of 'home_cubit.dart';

abstract class HomeState {
  List<Section> get sections;
}

class HomeInitial extends HomeState {
  @override
  List<Section> get sections => [];
}

class HomeLoading extends HomeState {
  @override
  List<Section> get sections {
    final products = List.generate(3, (_) => Product.loading());
    return [
      Section<BannerModel>.loading(HOMESECTIONTYPE.bannerSlider, <BannerModel>[
        BannerModel.onLoading(),
      ]),
      Section<Product>.loading(HOMESECTIONTYPE.horizontalItems, products),
      Section<Product>.loading(HOMESECTIONTYPE.horizontalItems, products),
    ];
  }
}

class HomeLoaded extends HomeState {
  final List<Section> _sections;
  HomeLoaded(this._sections);

  @override
  List<Section> get sections => _sections;
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);

  @override
  List<Section> get sections => [];
}
