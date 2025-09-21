import 'package:store/core/utils/errors/exceptions.dart';

class ProductApiModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final String? brand;
  final String? model;
  final String? color;
  final int? discount;
  final bool isNew;
  @Deprecated('Do not use this field, it is always false')
  final bool isOnSale;
  final double? rateValue;
  final double? discountAmount;
  final int? stock;
  final List<String>? size;
  @Deprecated('Use rateValue instead')
  final RatingApiModel rating;

  ProductApiModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.brand,
    this.color,
    this.discount,
    this.model,
    this.isOnSale = false,
    this.isNew = false,
    this.rateValue,
    this.discountAmount,
    this.stock,
    this.size,
    required this.rating,
  });

  factory ProductApiModel.fromJson(jsonData) {
    try {
      return ProductApiModel(
        id: jsonData['_id'],
        title: jsonData['title'],
        price: double.parse(jsonData['price'].toString()),
        description: jsonData['description'],
        category: jsonData['category'],
        image: jsonData['image'],
        brand: jsonData['brand'] ?? 'Brand',
        color: jsonData['color'] ?? 'Color',
        discount:
            jsonData['discount'] ??
            (jsonData['oldPrice'] != null
                ? int.tryParse(
                  (((jsonData['price'] / jsonData['discountedPrice']) - 1) *
                          100)
                      .toStringAsFixed(0),
                )
                : null),
        model: jsonData['model'],
        isOnSale: jsonData['onSale'] ?? false,
        isNew: jsonData['isNew'] ?? false,
        rateValue:
            jsonData['rating'] != null
                ? double.tryParse(jsonData['rating'].toString())
                : null,
        discountAmount:
            jsonData['discountedPrice'] != null
                ? double.tryParse(
                  (jsonData['price'] - jsonData['discountedPrice'])
                      .toStringAsFixed(2),
                )
                : null,
        stock: jsonData['stock'],
        size:
            jsonData['size'] != null
                ? List<String>.from(jsonData['size'])
                : null,
        rating:
            // jsonData['rating'] != null
            //     ? RatingApiModel.fromJson(jsonData['rating'])
            //     :
            RatingApiModel.empty(),
      );
    } on Exception catch (e) {
      throw ValidationException('Product model argument error');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'price': price,
      'description': description,
      'category': category,
      'imageUrl': image,
      'brand': brand,
      'color': color,
      'discount': discount,
      'model': model,
    };
  }
}

class RatingApiModel {
  final double rate;
  final int count;

  RatingApiModel({required this.rate, required this.count});

  factory RatingApiModel.fromJson(jsonData) {
    try {
      return RatingApiModel(
        rate: double.parse(jsonData['rate'].toString()),
        count: jsonData['count'],
      );
    } on Exception catch (e) {
      throw ValidationException('Rating model argument error');
    }
  }

  Map<String, dynamic> toJson() {
    return {'rate': rate, 'count': count};
  }

  factory RatingApiModel.empty() {
    return RatingApiModel(rate: 0.0, count: 0);
  }
}
