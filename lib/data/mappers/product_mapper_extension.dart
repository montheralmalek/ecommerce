import 'package:store/domain/entities/product.dart';

import '../services/remote/models/product_api_model.dart';

// Map from ProductModel to ProductEntity
extension ProductModelMapper on ProductApiModel {
  Product toEntity() {
    return Product(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      imageUrl: image,
      brand: brand ?? 'Brand',
      model: model ?? 'Model',
      color: color ?? 'Color',
      discount: discount,
      isNew: isNew,
      isOnSale: isOnSale,
      discountAmount: discountAmount,
      rateValue: rateValue,
      stock: stock ?? 0,
      sizes: size,
      rating: rating.toEntity(),
    );
  }
}

// Map from ProductEntity to ProductModel
// extension ProductEntityMapper on Product {
//   ProductApiModel toModel() {
//     return ProductApiModel(
//       id: id,
//       title: title,
//       price: price,
//       description: description,
//       category: category,
//       image: imageUrl,
//       brand: brand,
//       color: color,
//       discount: discount,
//       model: model,
//     );
//   }
// }

extension ProductRatingMapper on RatingApiModel {
  Rating toEntity() {
    return Rating(rateValue: rate, reviewsCount: count);
  }
}
