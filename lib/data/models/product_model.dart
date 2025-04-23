import 'package:store/core/errors/exceptions.dart';

class ProductModel {
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
  final bool isPopular;
  final bool isOnSale;

  ProductModel({
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
    this.isPopular = false,
  });

  factory ProductModel.fromJson(jsonData) {
    try {
      return ProductModel(
        id: jsonData['id'],
        title: jsonData['title'],
        price: double.parse(jsonData['price'].toString()),
        description: jsonData['description'],
        category: jsonData['category'],
        image: jsonData['image'],
        brand: jsonData['brand'],
        color: jsonData['color'],
        discount: jsonData['discount'],
        model: jsonData['model'],
        isOnSale: jsonData['onSale'] ?? false,
        isPopular: jsonData['popular'] ?? false,
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
