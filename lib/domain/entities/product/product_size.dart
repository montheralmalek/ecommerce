class ProductSize {
  final int id;
  final String name;
  final bool isAvailable;
  final double priceAdjustment;

  const ProductSize({
    required this.id,
    required this.name,
    this.isAvailable = true,
    this.priceAdjustment = 0.0,
  });
}
