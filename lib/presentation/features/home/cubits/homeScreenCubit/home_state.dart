part of 'home_cubit.dart';

abstract class HomeState {
  List<HomeSectionI> get sections;
}

class HomeInitial extends HomeState {
  @override
  List<HomeSectionI> get sections => [];
}

class HomeLoading extends HomeState {
  @override
  List<HomeSectionI> get sections {
    final products = List.generate(3, (_) => Product.loading());
    return [
      BannerSliderSection(data: [BannerModel.onLoading()]),
      // HomeSectionI<BannerModel>.loading(
      //   HOMESECTIONTYPE.bannerSlider,
      //   <BannerModel>[BannerModel.onLoading()],
      // ),
      HorizontalItemsSection(title: 'title', data: products),
      HorizontalItemsSection(title: 'title', data: products),
      // HomeSectionI<Product>.loading(HOMESECTIONTYPE.horizontalItems, products),
      // HomeSectionI<Product>.loading(HOMESECTIONTYPE.horizontalItems, products),
    ];
  }
}

class HomeLoaded extends HomeState {
  final List<HomeSectionI> _sections;
  HomeLoaded(this._sections);

  @override
  List<HomeSectionI> get sections => _sections;
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);

  @override
  List<HomeSectionI> get sections => [];
}
