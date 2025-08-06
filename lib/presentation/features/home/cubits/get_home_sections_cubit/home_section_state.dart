part of 'home_sections_cubit.dart';

@immutable
abstract class HomeSectionState {
  List<HomeSection> get sections;
}

class HomeSectionInitial extends HomeSectionState {
  @override
  List<HomeSection> get sections => [];
}

class HomeSectionLoading extends HomeSectionState {
  @override
  List<HomeSection> get sections {
    final products = List.generate(3, (_) => Product.loading());
    return [
      BannerSliderSection(data: [AdBanner.onLoading()]),
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

class HomeSectionLoaded extends HomeSectionState {
  final List<HomeSection> _sections;
  HomeSectionLoaded(this._sections);

  @override
  List<HomeSection> get sections => _sections;

  HomeSectionLoaded copyWith({List<HomeSection>? sections}) {
    return HomeSectionLoaded(sections ?? this.sections);
  }

  List<Object> get props => [sections];
}

class HomeSectionError extends HomeSectionState {
  final String message;

  HomeSectionError(this.message);

  @override
  List<HomeSection> get sections => [];
}
