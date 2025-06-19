import 'package:store/domain/domain_models/product.dart';

import '../services/remote/models/product_api_model.dart';

// Map from ProductModel to ProductEntity
extension ProductModelMapper on ProductApiModel {
  Product toEntity() {
    return Product.builder()
        .setId(id)
        .setTitle(title)
        .setPrice(price)
        .setDescription(description)
        .setCategory(category)
        .setImageUrl(image)
        .setBrand(brand)
        .setColor(color)
        .setDiscount(discount)
        .setModel(model)
        .setIsPopular(isPopular)
        .setIsOnSale(isOnSale)
        .setRating(rating?.toEntity())
        .build();
  }
}

// Map from ProductEntity to ProductModel
extension ProductEntityMapper on Product {
  ProductApiModel toModel() {
    return ProductApiModel(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: imageUrl,
      brand: brand,
      color: color,
      discount: discount,
      model: model,
    );
  }
}

extension ProductRatingMapper on RatingApiModel {
  Rating toEntity() {
    return Rating(rateValue: rate, reviewsCount: count);
  }
}
