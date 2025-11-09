abstract class BaseProduct {
  final int id;
  final String name;
  final String description;
  final String category;
  final String? brand;
  final String? model;
  final String image;

  final String baseSlug;

  const BaseProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.brand,
    required this.model,
    required this.image,
    required this.baseSlug,
  });
}
