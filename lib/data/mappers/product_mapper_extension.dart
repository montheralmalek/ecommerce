import 'package:store/domain/entities/product_entity.dart';

import '../models/product_model.dart';

// Map from ProductModel to ProductEntity
extension ProductModelMapper on ProductModel {
  ProductEntity toEntity() {
    return ProductEntity.builder()
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
extension ProductEntityMapper on ProductEntity {
  ProductModel toModel() {
    return ProductModel(
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
