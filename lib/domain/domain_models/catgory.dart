class Category {
  final String id;
  final String name;
  final String? imageUrl;

  Category({required this.id, required this.name, this.imageUrl});

  @override
  String toString() {
    return 'Catgory{id: $id, name: $name, imageUrl: $imageUrl}';
  }
}
