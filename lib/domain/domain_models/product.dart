class Product {
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
  Product._({
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
  static ProductBuiler builder() => ProductBuiler();

  factory Product.loading() {
    return Product._(
      id: 0,
      title: 'Loading...',
      price: 0.0,
      description: 'Loading description...',
      category: 'Loading category...',
      imageUrl: '',
      brand: null,
      model: null,
      color: null,
      discount: null,
      isOnSale: false,
      isPopular: false,
    );
  }
}

/// ProductEntity builder pattern
class ProductBuiler {
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

  ProductBuiler setId(int id) {
    _id = id;
    return this;
  }

  ProductBuiler setTitle(String title) {
    _title = title;
    return this;
  }

  ProductBuiler setPrice(double price) {
    _price = price;
    return this;
  }

  ProductBuiler setDescription(String description) {
    _description = description;
    return this;
  }

  ProductBuiler setCategory(String category) {
    _category = category;
    return this;
  }

  ProductBuiler setImageUrl(String imageUrl) {
    _imageUrl = imageUrl;
    return this;
  }

  ProductBuiler setBrand(String? brand) {
    _brand = brand;
    return this;
  }

  ProductBuiler setModel(String? model) {
    _model = model;
    return this;
  }

  ProductBuiler setColor(String? color) {
    _color = color;
    return this;
  }

  ProductBuiler setDiscount(int? discount) {
    _discount = discount;
    return this;
  }

  ProductBuiler setIsPopular(bool isPopular) {
    _isPopular = isPopular;
    return this;
  }

  ProductBuiler setIsOnSale(bool isOnSale) {
    _isOnSale = isOnSale;
    return this;
  }

  Product build() {
    return Product._(
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
