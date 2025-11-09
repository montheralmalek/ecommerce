class ProductColor {
  final int id;
  final String name;
  final String hexCode;
  final List<String>? images;
  final bool isAvailable;
  final double priceAdjustment;

  const ProductColor({
    required this.id,
    required this.name,
    required this.hexCode,
    this.images,
    this.isAvailable = true,
    this.priceAdjustment = 0.0,
  });
}
