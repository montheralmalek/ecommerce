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
  final bool isNew;
  final double? rateValue;
  final double? discountAmount;
  final int stock;
  final List<String>? sizes;
  final bool isOnSale;

  final Rating? rating;
  const Product({
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
    this.isNew = false,
    this.rateValue,
    this.discountAmount,
    this.stock = 0,
    this.sizes,
    this.rating,
  });

  factory Product.loading() = _ProductLoading;

  factory Product.empty() {
    return Product(
      id: 0,
      title: '',
      price: 0.0,
      description: '',
      category: '',
      imageUrl: '',
      discount: 0,
      isNew: false,
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
    bool? isNew,
    double? discountAmount,
    double? rateValue,
    int? stock,
    List<String>? size,
    bool? isOnSale,
    Rating? rating,
  }) {
    return Product(
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
      isNew: isNew ?? this.isNew,
      isOnSale: isOnSale ?? this.isOnSale,
      discountAmount: discountAmount ?? this.discountAmount,
      rateValue: rateValue ?? this.rateValue,
      stock: stock ?? this.stock,
      sizes: size ?? sizes,
      rating: rating ?? this.rating,
    );
  }

  /// check is available
  bool get isAvailableInStock => stock > 0;

  /// Check if the product has a discount
  bool get hasDiscount => discount != null && discount! > 0;

  /// Original price before discount
  double get originalPrice => price;

  /// Real price after discount
  double get realPrice => price - (discountAmount ?? 0.0);

  /// Discount amount
  // double get discountAmount => hasDiscount ? (price * discount! / 100) : 0.0;

  /// Discount as string
  String get discountString => hasDiscount ? '$discount% Off' : '';

  /// Formatted price string
  String _formattedPrice(double price) => '\$${price.toStringAsFixed(2)}';

  /// Formatted real price string
  String get formattedRealPrice => _formattedPrice(realPrice);

  /// Formatted original price String
  String get formattedOriginalPrice => _formattedPrice(originalPrice);

  /// Check if the product has size
  bool get hasSize => sizes != null;

  /// Check if has rating
  bool get hasRating => rateValue != null;
}

//
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
    : super(
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
        isNew: false,
      );
}
