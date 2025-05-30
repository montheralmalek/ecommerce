import 'package:store/core/utils/errors/app_errors.dart';
import 'package:store/core/utils/result.dart';
import 'package:store/data/repositories/product_repository.dart';
import 'package:store/data/shared_preferences_service.dart';
import 'package:store/domain/domain_models/banner.dart';
import 'package:store/domain/domain_models/section.dart';
import 'package:store/domain/domain_models/product.dart';

class GetProductsUseCase {
  final ProductRepository _repository;

  GetProductsUseCase(this._repository);

  Future<Result<List<Product>>> execute() => _repository.getProducts();
}

class GetSectionsUseCase {
  final ProductRepository _repository;

  GetSectionsUseCase(this._repository);

  Future<Result<List<Section>>> execute() async {
    try {
      final products = await _repository.getProducts();
      final result = products.where(
        onSuccess: (data) {
          final List<Section> sections = [];
          final bs = Section.bannerSlider([
            BannerModel(
              imageUrl:
                  'https://static.vecteezy.com/system/resources/thumbnails/010/248/863/small_2x/sale-now-on-labels-illustration-vector.jpg',
            ),
            BannerModel(
              imageUrl:
                  'https://img.freepik.com/free-vector/paper-style-podium-horizontal-banner_23-2150956911.jpg',
            ),
            BannerModel(
              imageUrl:
                  'https://d2tl9ctlpnidkn.cloudfront.net/quicksign/images/flashgallary/large/banner1_1737528096351.jpg',
            ),

            // 'https://alidropship.com/wp-content/uploads/2019/12/50-best-banner-ads-examples.jpg',
          ]);
          sections.addAll([
            bs,
            Section(
              type: HOMESECTIONTYPE.horizontalItems,
              title: 'Most Popular Products',
              actionText: 'see all',
              data: data.where((product) => product.isPopular).toList(),
            ),
            Section(
              type: HOMESECTIONTYPE.horizontalItems,
              title: 'On Sale Products',
              actionText: 'see all',
              data: data.where((product) => product.isOnSale).toList(),
            ),
            Section(
              type: HOMESECTIONTYPE.horizontalItems,
              title: 'Special Offer Products',
              actionText: 'see all',
              data:
                  data
                      .where(
                        (product) =>
                            product.discount != null && product.discount! >= 25,
                      )
                      .toList(),
            ),
          ]);
          return Result.success(sections);
        },
        onFailure: (error) => Result<List<Section>>.failure(error),
      );

      return result;
    } on Exception catch (e) {
      return Result.failure(AppError.fromException(e));
    }
  }
}
