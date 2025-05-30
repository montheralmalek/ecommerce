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
        .build();
    // ProductEntity(
    //   id: id,
    //   title: title,
    //   price: price,
    //   description: description,
    //   category: category,
    //   imageUrl: image,
    //   brand: brand,
    //   color: color,
    //   discount: discount,
    //   model: model,
    // );
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
