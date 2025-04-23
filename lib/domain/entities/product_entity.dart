class ProductEntity {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String imageUrl;
  final String? brand;
  final String? model;
  final String? color;
  final int? discount;
  final bool isPopular;
  final bool isOnSale;
  ProductEntity._({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    this.brand,
    this.color,
    this.discount,
    this.model,
    this.isOnSale = false,
    this.isPopular = false,
  });
  static ProductEntitBuiler builder() => ProductEntitBuiler();
}

/// ProductEntity builder pattern
class ProductEntitBuiler {
  int? _id;
  String? _title;
  double? _price;
  String? _description;
  String? _category;
  String? _imageUrl;
  String? _brand;
  String? _model;
  String? _color;
  int? _discount;
  bool? _isPopular;
  bool? _isOnSale;

  ProductEntitBuiler setId(int id) {
    _id = id;
    return this;
  }

  ProductEntitBuiler setTitle(String title) {
    _title = title;
    return this;
  }

  ProductEntitBuiler setPrice(double price) {
    _price = price;
    return this;
  }

  ProductEntitBuiler setDescription(String description) {
    _description = description;
    return this;
  }

  ProductEntitBuiler setCategory(String category) {
    _category = category;
    return this;
  }

  ProductEntitBuiler setImageUrl(String imageUrl) {
    _imageUrl = imageUrl;
    return this;
  }

  ProductEntitBuiler setBrand(String? brand) {
    _brand = brand;
    return this;
  }

  ProductEntitBuiler setModel(String? model) {
    _model = model;
    return this;
  }

  ProductEntitBuiler setColor(String? color) {
    _color = color;
    return this;
  }

  ProductEntitBuiler setDiscount(int? discount) {
    _discount = discount;
    return this;
  }

  ProductEntitBuiler setIsPopular(bool isPopular) {
    _isPopular = isPopular;
    return this;
  }

  ProductEntitBuiler setIsOnSale(bool isOnSale) {
    _isOnSale = isOnSale;
    return this;
  }

  ProductEntity build() {
    return ProductEntity._(
      id: _id ?? 0,
      title: _title ?? '',
      price: _price ?? 0.0,
      description: _description ?? '',
      category: _category ?? '',
      imageUrl: _imageUrl ?? '',
      brand: _brand ?? '',
      model: _model ?? '',
      color: _color ?? '',
      discount: _discount ?? 0,
      isOnSale: _isOnSale ?? false,
      isPopular: _isPopular ?? false,
    );
  }
}
