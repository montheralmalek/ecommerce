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
  final Rating? rating;
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
    this.rating,
  });
  static ProductBuiler builder() => ProductBuiler();

  factory Product.loading() = _ProductLoading;
  factory Product({
    required int id,
    required String title,
    required double price,
    required String description,
    required String category,
    required String imageUrl,
    String? brand,
    String? model,
    String? color,
    int? discount,
    bool isPopular = false,
    bool isOnSale = false,
    Rating? rating,
  }) {
    return Product._(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      imageUrl: imageUrl,
      brand: brand,
      model: model,
      color: color,
      discount: discount ?? 0,
      isPopular: isPopular,
      isOnSale: isOnSale,
      rating: rating ?? Rating.empty(),
    );
  }
  factory Product.empty() {
    return Product._(
      id: 0,
      title: '',
      price: 0.0,
      description: '',
      category: '',
      imageUrl: '',
      brand: null,
      model: null,
      color: null,
      discount: 0,
      isPopular: false,
      isOnSale: false,
      rating: Rating.empty(),
    );
  }
  Product copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? imageUrl,
    String? brand,
    String? model,
    String? color,
    int? discount,
    bool? isPopular,
    bool? isOnSale,
    Rating? rating,
  }) {
    return Product._(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      color: color ?? this.color,
      discount: discount ?? this.discount,
      isPopular: isPopular ?? this.isPopular,
      isOnSale: isOnSale ?? this.isOnSale,
      rating: rating ?? this.rating,
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
  Rating? _rating;

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

  ProductBuiler setRating(Rating? rating) {
    _rating = rating;
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
      rating: _rating ?? Rating.empty(),
    );
  }
}

class Rating {
  final double rateValue;
  final int reviewsCount;

  Rating({required this.rateValue, required this.reviewsCount});

  factory Rating.empty() {
    return Rating(rateValue: 0.0, reviewsCount: 0);
  }

  Rating copyWith({double? rateValue, int? reviewsCount}) {
    return Rating(
      rateValue: rateValue ?? this.rateValue,
      reviewsCount: reviewsCount ?? this.reviewsCount,
    );
  }

  @override
  String toString() {
    return 'Rating(rateValue: $rateValue, reviewsCount: $reviewsCount)';
  }
}

class _ProductLoading extends Product {
  _ProductLoading()
    : super._(
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
